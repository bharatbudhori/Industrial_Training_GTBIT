import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:dmrc_delhi_metro/data/data.dart';
import 'package:dmrc_delhi_metro/models/station_model.dart';
import 'package:dmrc_delhi_metro/screens/map_screen.dart';
import 'package:dmrc_delhi_metro/screens/metro_route_screen.dart';
import 'package:dmrc_delhi_metro/screens/pdf_viewer.dart';
import 'package:dmrc_delhi_metro/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(
        detailed: false,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  bool _isLoading = false;
  String? _sourceStation;
  String? _destinationStation;

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = math.cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * math.asin(math.sqrt(a));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 59, 156, 235),
          title: Row(
            children: [
              Image.asset(
                'assets/delhi-metro-logo.png',
                fit: BoxFit.cover,
                height: 32,
              ),
              const SizedBox(width: 10),
              const Text(
                'Delhi Metro',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            ],
          )),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  //gradine color

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.blue.withOpacity(0.8),
                        Colors.blue.withOpacity(0.7),
                        Colors.blue.withOpacity(0.4),
                        Colors.blue.withOpacity(0.1),
                      ],
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 240,
                  width: double.infinity,
                  color: Colors.blue.withOpacity(0.7),
                  child: const Image(
                    image: AssetImage('assets/21288.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Plan Your Journey',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SizedBox(
                  height: 170,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 170,
                        //color: Colors.black,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(_createRoute())
                                      .then((value) => setState(() {
                                            log('value: $value');
                                            _sourceStation = value;
                                          }));
                                },
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              'From',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 17,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              _sourceStation ??
                                                  'Select Station',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 10,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(_createRoute())
                                      .then((value) => setState(() {
                                            log('value: $value');
                                            _destinationStation = value;
                                          }));
                                },
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              'To',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 17,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              _destinationStation ??
                                                  'Select Station',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                final temp = _sourceStation;
                                _sourceStation = _destinationStation;
                                _destinationStation = temp;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.swap_vert,
                                color: Colors.black,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: InkWell(
                    onTap: () async {
                      if (_sourceStation == null ||
                          _destinationStation == null) {
                        Fluttertoast.showToast(
                          msg: 'Select Source and Destination',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }
                      final response = await http.get(
                        Uri.parse(
                            'https://us-central1-delhimetroapi.cloudfunctions.net/route-get?from=$_sourceStation&to=$_destinationStation'),
                      );
                      log(response.body);
                      final data = jsonDecode(response.body);
                      if (data['status'] == 200) {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RouteScreen(
                              sourceName: _sourceStation!,
                              destinationName: _destinationStation!,
                              data: data,
                            ),
                          ),
                        );
                      } else if (data['status'] == 204) {
                        Fluttertoast.showToast(
                          msg: 'Same Station Selected',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else if (data['status'] == 400) {
                        Fluttertoast.showToast(
                          msg: 'Undefined Station Selected',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else if (data['status'] == 4061) {
                        Fluttertoast.showToast(
                          msg: 'Invalid Source Station',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else if (data['status'] == 4062) {
                        Fluttertoast.showToast(
                          msg: 'Invalid Destination Station',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Something went wrong',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: Text(
                          'Search Route',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                SearchScreen(detailed: true)));
                      },
                      child: Container(
                        height: 140,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage('assets/search.png'),
                              height: 110,
                              width: 140,
                            ),
                            Text(
                              'Search Station',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        bool serviceEnabled =
                            await Geolocator.isLocationServiceEnabled();
                        if (!serviceEnabled) {
                          // Location services are not enabled don't continue
                          // accessing the position and request users of the
                          // App to enable the location services.
                          Fluttertoast.showToast(
                            msg: 'Location Services Disabled',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }
                        setState(() {
                          _isLoading = true;
                        });
                        Position pos = await _determinePosition();

                        log(pos.toString());
                        double lat1 = pos.latitude;
                        double lon1 = pos.longitude;

                        double? nearestDistance;
                        double distance = 1000000;
                        StationModel? nearestStation;
                        for (int i = 0; i < stationData.length; i++) {
                          double lat2 = stationData[i]['details']['latitude'];
                          double lon2 = stationData[i]['details']['longitude'];
                          double currDistance =
                              calculateDistance(lat1, lon1, lat2, lon2);
                          if (currDistance < distance) {
                            distance = currDistance;
                            nearestDistance = currDistance;
                            nearestStation =
                                StationModel.fromJson(stationData[i]);
                          }
                        }
                        setState(() {
                          _isLoading = false;
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              station: nearestStation!,
                            ),
                          ),
                        );
                        log(nearestDistance.toString());
                        log(nearestStation!.stationName);
                      },
                      child: Container(
                        height: 140,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  image: AssetImage('assets/station.png'),
                                  height: 110,
                                  width: 140,
                                ),
                                Text(
                                  'Nearest Station',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                            if (_isLoading)
                              Container(
                                height: 140,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue.withOpacity(0.4),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PdfApp()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 140,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/metro_map.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'Metro Map',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Quick Contact',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    SizedBox(width: 20),
                    Icon(
                      Icons.phone,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'DMRC Helpline No.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: InkWell(
                    onTap: () {
                      // ignore: deprecated_member_use
                      launch('tel://155370');
                    },
                    child: const Text(
                      '155370',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    SizedBox(width: 20),
                    Icon(
                      Icons.phone,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'CISF Helpline No.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: InkWell(
                    onTap: () {
                      // ignore: deprecated_member_use
                      launch('tel://155655');
                    },
                    child: const Text(
                      '155655',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
