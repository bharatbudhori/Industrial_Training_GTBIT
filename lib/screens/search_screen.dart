import 'package:dmrc_delhi_metro/data/data.dart';
import 'package:dmrc_delhi_metro/models/station_model.dart';
import 'package:dmrc_delhi_metro/screens/map_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  bool detailed;

  SearchScreen({super.key, required this.detailed});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<StationModel> stations = [];
  List<StationModel> result = [];
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < stationData.length; i++) {
      stations.add(StationModel.fromJson(stationData[i]));
    }
    result = stations;
    setState(() {});
  }

  void search(String query) {
    if (query.isEmpty) {
      result = stations;
      setState(() {});
      return;
    }
    if (query.isNotEmpty) {
      List<StationModel> results = [];
      for (var element in stations) {
        if (element.stationName.toLowerCase().contains(query.toLowerCase())) {
          results.add(element);
        }
      }
      result = results;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 70,
              color: const Color.fromARGB(255, 183, 210, 231),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          search(value);
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(40.0)),
                          focusColor: Colors.black,
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              //searchController.text = '';
                              search(searchController.text);
                            },
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.text = '';
                              search(searchController.text);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        !widget.detailed
                            ? Navigator.pop(context, result[index].stationName)
                            : Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MapScreen(
                                      station: stations[index],
                                    )));
                      },
                      title: Text(
                        result[index].stationName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (int i = 0;
                              i < result[index].stationLines.length;
                              i++)
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 5, left: 5, top: 10, bottom: 12),
                              padding: const EdgeInsets.all(5),
                              height: 30,
                              decoration: BoxDecoration(
                                color: result[index].stationLines[i].contains('Red')
                                    ? Colors.red.withOpacity(0.5)
                                    : (result[index].stationLines[i].contains('Blue')
                                        ? Colors.blue.withOpacity(0.5)
                                        : (result[index]
                                                .stationLines[i]
                                                .contains('Green')
                                            ? Colors.green.withOpacity(0.5)
                                            : (result[index]
                                                    .stationLines[i]
                                                    .contains('Yellow')
                                                ? Colors.yellow.withOpacity(0.5)
                                                : (result[index]
                                                        .stationLines[i]
                                                        .contains('Violet')
                                                    ? Colors.purple
                                                        .withOpacity(0.5)
                                                    : (result[index]
                                                            .stationLines[i]
                                                            .contains('Pink')
                                                        ? Colors.pink
                                                            .withOpacity(0.3)
                                                        : (result[index]
                                                                .stationLines[i]
                                                                .contains('Magenta')
                                                            ? Colors.purpleAccent.withOpacity(0.3)
                                                            : Colors.orange.withOpacity(0.3))))))),
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  width: 2,
                                  color: result[index]
                                          .stationLines[i]
                                          .contains('Red')
                                      ? Colors.red
                                      : (result[index]
                                              .stationLines[i]
                                              .contains('Blue')
                                          ? Colors.blue
                                          : (result[index]
                                                  .stationLines[i]
                                                  .contains('Green')
                                              ? Colors.green
                                              : (result[index]
                                                      .stationLines[i]
                                                      .contains('Yellow')
                                                  ? Colors.yellow
                                                  : (result[index]
                                                          .stationLines[i]
                                                          .contains('Violet')
                                                      ? Colors.purple
                                                      : (result[index]
                                                              .stationLines[i]
                                                              .contains('Pink')
                                                          ? Colors.pink
                                                          : (result[index]
                                                                  .stationLines[
                                                                      i]
                                                                  .contains('Magenta')
                                                              ? Colors.purpleAccent
                                                              : Colors.orange)))))),
                                ),
                              ),
                              child: Text(
                                result[index].stationLines[i],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
