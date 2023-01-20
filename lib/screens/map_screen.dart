import 'dart:developer';

import 'package:dmrc_delhi_metro/models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  StationModel station;
  MapScreen({super.key, required this.station});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          title: Row(
            children: [
              const Image(
                image: AssetImage("assets/metro_logo (1).png"),
                height: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.station.stationName,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=${widget.station.latitude},${widget.station.longitude}';

                try {
                  await launch(googleUrl);
                } catch (e) {
                  log(e.toString());
                }
              },
              icon: const Icon(Icons.navigation),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          )),*/
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 140,
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/station_board.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Center(
                            child: Text(
                              widget.station.stationName,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              for (int i = 0; i < widget.station.stationLines.length; i++)
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: widget.station.stationLines[i].contains('Red')
                        ? Colors.red.withOpacity(0.3)
                        : (widget.station.stationLines[i].contains('Blue')
                            ? Colors.blue.withOpacity(0.3)
                            : (widget.station.stationLines[i].contains('Green')
                                ? Colors.green.withOpacity(0.3)
                                : (widget.station.stationLines[i]
                                        .contains('Yellow')
                                    ? Colors.yellow.withOpacity(0.3)
                                    : (widget.station.stationLines[i]
                                            .contains('Violet')
                                        ? Colors.purple.withOpacity(0.3)
                                        : (widget.station.stationLines[i]
                                                .contains('Pink')
                                            ? Colors.pink.withOpacity(0.3)
                                            : (widget.station.stationLines[i]
                                                    .contains('Magenta')
                                                ? Colors.purpleAccent
                                                    .withOpacity(0.3)
                                                : Colors.orange
                                                    .withOpacity(0.3))))))),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: widget.station.stationLines[i].contains('Red')
                          ? Colors.red
                          : (widget.station.stationLines[i].contains('Blue')
                              ? Colors.blue
                              : (widget.station.stationLines[i]
                                      .contains('Green')
                                  ? Colors.green
                                  : (widget.station.stationLines[i]
                                          .contains('Yellow')
                                      ? Colors.yellow
                                      : (widget.station.stationLines[i]
                                              .contains('Violet')
                                          ? Colors.purple
                                          : (widget.station.stationLines[i]
                                                  .contains('Pink')
                                              ? Colors.pink
                                              : (widget.station.stationLines[i]
                                                      .contains('Magenta')
                                                  ? Colors.purpleAccent
                                                  : Colors.orange
                                                      .withOpacity(0.3))))))),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.train_outlined,
                        color: widget.station.stationLines[i].contains('Red')
                            ? Colors.red
                            : (widget.station.stationLines[i].contains('Blue')
                                ? const Color.fromARGB(255, 4, 132, 236)
                                : (widget.station.stationLines[i]
                                        .contains('Green')
                                    ? Colors.green
                                    : (widget.station.stationLines[i]
                                            .contains('Yellow')
                                        ? const Color.fromARGB(255, 187, 169, 3)
                                        : (widget.station.stationLines[i]
                                                .contains('Violet')
                                            ? Colors.purple
                                            : (widget.station.stationLines[i]
                                                    .contains('Pink')
                                                ? Colors.pink
                                                : (widget
                                                        .station.stationLines[i]
                                                        .contains('Magenta')
                                                    ? Colors.purpleAccent
                                                    : Colors.orange
                                                        .withOpacity(0.3))))))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Line',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: widget.station.stationLines[i].contains('Red')
                                    ? Colors.red
                                    : (widget.station.stationLines[i].contains('Blue')
                                        ? const Color.fromARGB(255, 4, 132, 236)
                                        : (widget.station.stationLines[i].contains('Green')
                                            ? Colors.green
                                            : (widget.station.stationLines[i]
                                                    .contains('Yellow')
                                                ? const Color.fromARGB(
                                                    255, 187, 169, 3)
                                                : (widget.station.stationLines[i]
                                                        .contains('Violet')
                                                    ? Colors.purple
                                                    : (widget.station.stationLines[i]
                                                            .contains('Pink')
                                                        ? Colors.pink
                                                        : (widget.station.stationLines[i]
                                                                .contains('Magenta')
                                                            ? Colors.purpleAccent
                                                            : Colors.orange.withOpacity(0.3)))))))),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '   ${widget.station.stationLines[i]}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: widget.station.stationLines[i].contains('Red')
                                  ? Colors.red
                                  : (widget.station.stationLines[i].contains('Blue')
                                      ? const Color.fromARGB(255, 4, 132, 236)
                                      : (widget.station.stationLines[i].contains('Green')
                                          ? Colors.green
                                          : (widget.station.stationLines[i]
                                                  .contains('Yellow')
                                              ? const Color.fromARGB(
                                                  255, 187, 169, 3)
                                              : (widget.station.stationLines[i]
                                                      .contains('Violet')
                                                  ? Colors.purple
                                                  : (widget.station
                                                          .stationLines[i]
                                                          .contains('Pink')
                                                      ? Colors.pink
                                                      : (widget.station
                                                              .stationLines[i]
                                                              .contains('Magenta')
                                                          ? Colors.purpleAccent
                                                          : Colors.orange.withOpacity(0.3))))))),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      const Text('Normal Service'),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              Card(
                elevation: 10,
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 200,
                  child: Stack(
                    children: [
                      GoogleMap(
                        //Map widget from google_maps_flutter package
                        zoomGesturesEnabled: true,
                        markers: {
                          Marker(
                            markerId: const MarkerId("1"),
                            position: LatLng(widget.station.latitude,
                                widget.station.longitude),
                            draggable: true,
                          )
                        },
                        //enable Zoom in, out on map
                        initialCameraPosition: CameraPosition(
                          //innital position in map
                          target: LatLng(widget.station.latitude,
                              widget.station.longitude), //initial position
                          zoom: 14.0, //initial zoom level
                        ),
                        mapType: MapType.normal, //map type
                        onMapCreated: (controller) {
                          //method called when map is created
                        },
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          onPressed: () async {
                            String googleUrl =
                                'https://www.google.com/maps/search/?api=1&query=${widget.station.latitude},${widget.station.longitude}';

                            try {
                              // ignore: deprecated_member_use
                              await launch(googleUrl);
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          icon: const Icon(
                            Icons.navigation,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Station Details',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: const [
                    Icon(
                      Icons.wheelchair_pickup,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Divyang Friendly Station',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: const [
                    Icon(
                      Icons.elevator_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Lift/Escalator Available',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              widget.station.parking == 1
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.car_crash_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Parking Available',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              widget.station.parking == 1
                  ? const SizedBox(
                      height: 5,
                    )
                  : const SizedBox(),
              widget.station.stationLines.length > 1
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.change_circle_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Interchange Available',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              widget.station.stationLines.length > 1
                  ? const SizedBox(
                      height: 5,
                    )
                  : const SizedBox(),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Contact Details',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.phone_android_outlined,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // ignore: deprecated_member_use
                        launch('tel://8800793133');
                      },
                      child: const Text(
                        '8800793133',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    const Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // ignore: deprecated_member_use
                        launch('tel://011-23415849');
                      },
                      child: const Text(
                        '011-23415849',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
