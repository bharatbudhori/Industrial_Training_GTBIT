import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RouteScreen extends StatelessWidget {
  String sourceName;
  String destinationName;
  dynamic data;
  RouteScreen(
      {super.key,
      required this.data,
      required this.sourceName,
      required this.destinationName});

  bool changed = false;

  bool changed2 = false;

  bool changed3 = false;

  int calcCost() {
    if (data['path'].length <= 3) {
      return 10;
    }
    if (data['path'].length <= 9) {
      return 20;
    }
    if (data['path'].length <= 16) {
      return 30;
    }
    if (data['path'].length <= 25) {
      return 40;
    }
    if (data['path'].length <= 35) {
      return 50;
    }

    return 60;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$sourceName ⇄ $destinationName'),
          elevation: 0,
        ),
        body: Column(children: [
          Container(
            padding:const  EdgeInsets.all(10),
            color: Colors.grey[400],
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                   const  CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(Icons.currency_rupee_sharp),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Fare',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                   const  SizedBox(
                      height: 3,
                    ),
                    Text(
                      calcCost().toString(),
                      style:const  TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(Icons.timer),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                   const  Text('Time', style: TextStyle(fontWeight: FontWeight.w600)),
                   const  SizedBox(
                      height: 3,
                    ),
                    Text('${data['time'].toInt()} min',
                        style:const  TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(Icons.train_outlined),
                    ),
                   const  SizedBox(
                      height: 5,
                    ),
                   const  Text('Stations',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(data['path'].length.toString(),
                        style:const  TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(Icons.multiple_stop_sharp),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Interchanges',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(data['interchange'].length.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics:const  ScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemCount: data['path'].length,
              itemBuilder: (context, index) {
                if (data['interchange'].isEmpty) {
                  Color color = data['line1'][0].contains('red')
                      ? Colors.red
                      : data['line1'][0].contains('green')
                          ? Colors.green
                          : data['line1'][0].contains('blue')
                              ? Colors.blue
                              : data['line1'][0].contains('yellow')
                                  ? const Color.fromARGB(255, 216, 195, 5)
                                  : data['line1'][0].contains('orange')
                                      ? Colors.orange
                                      : data['line1'][0].contains('pink')
                                          ? Colors.pink
                                          : data['line1'][0].contains('violet')
                                              ? Colors.purple
                                              : Colors.grey;
                  return SingleTile(
                    index: index + 1,
                    name: data['path'][index],
                    color: color,
                  );
                } else if (data['interchange'].length == 1) {
                  Color col1 = data['line1'][0].contains('red')
                      ? Colors.red
                      : data['line1'][0].contains('green')
                          ? Colors.green
                          : data['line1'][0].contains('blue')
                              ? Colors.blue
                              : data['line1'][0].contains('yellow')
                                  ? const Color.fromARGB(255, 216, 195, 5)
                                  : data['line1'][0].contains('orange')
                                      ? Colors.orange
                                      : data['line1'][0].contains('pink')
                                          ? Colors.pink
                                          : data['line1'][0].contains('violet')
                                              ? Colors.purple
                                              : Colors.grey;
                  Color col2 = data['line2'][0].contains('red')
                      ? Colors.red
                      : data['line2'][0].contains('green')
                          ? Colors.green
                          : data['line2'][0].contains('blue')
                              ? Colors.blue
                              : data['line2'][0].contains('yellow')
                                  ? const Color.fromARGB(255, 216, 195, 5)
                                  : data['line2'][0].contains('orange')
                                      ? Colors.orange
                                      : data['line2'][0].contains('pink')
                                          ? Colors.pink
                                          : data['line2'][0].contains('violet')
                                              ? Colors.purple
                                              : Colors.grey;

                  if (data['interchange'][0] == data['path'][index]) {
                    changed = true;
                  }
                  if (!changed) {
                    return SingleTile(
                      index: index + 1,
                      name: data['path'][index],
                      color: col1,
                    );
                  } else {
                    return SingleTile(
                      index: index + 1,
                      name: data['path'][index],
                      color: col2,
                    );
                  }
                } else if (data['interchange'].length == 2) {
                  Color col1 = data['line1'][0].contains('red')
                      ? Colors.red
                      : data['line1'][0].contains('green')
                          ? Colors.green
                          : data['line1'][0].contains('blue')
                              ? Colors.blue
                              : data['line1'][0].contains('yellow')
                                  ? const Color.fromARGB(255, 216, 195, 5)
                                  : data['line1'][0].contains('orange')
                                      ? Colors.orange
                                      : data['line1'][0].contains('pink')
                                          ? Colors.pink
                                          : data['line1'][0].contains('violet')
                                              ? Colors.purple
                                              : Colors.grey;
                  Color col2 = data['line2'][0].contains('red')
                      ? Colors.red
                      : data['line2'][0].contains('green')
                          ? Colors.green
                          : data['line2'][0].contains('blue')
                              ? Colors.blue
                              : data['line2'][0].contains('yellow')
                                  ? const Color.fromARGB(255, 216, 195, 5)
                                  : data['line2'][0].contains('orange')
                                      ? Colors.orange
                                      : data['line2'][0].contains('pink')
                                          ? Colors.pink
                                          : data['line2'][0].contains('violet')
                                              ? Colors.purple
                                              : Colors.grey;
                  Color col3 = data['line2'][1].contains('red')
                      ? Colors.red
                      : data['line2'][1].contains('green')
                          ? Colors.green
                          : data['line2'][1].contains('blue')
                              ? Colors.blue
                              : data['line2'][1].contains('yellow')
                                  ? const Color.fromARGB(255, 216, 195, 5)
                                  : data['line2'][1].contains('orange')
                                      ? Colors.orange
                                      : data['line2'][1].contains('pink')
                                          ? Colors.pink
                                          : data['line2'][1].contains('violet')
                                              ? Colors.purple
                                              : Colors.grey;
                  if (data['interchange'][0] == data['path'][index]) {
                    changed = true;
                  }
                  if (data['interchange'][1] == data['path'][index]) {
                    changed2 = true;
                  }
                  if (!changed && !changed2) {
                    return SingleTile(
                      index: index + 1,
                      name: data['path'][index],
                      color: col1,
                    );
                  } else if (changed && !changed2) {
                    return SingleTile(
                      index: index + 1,
                      name: data['path'][index],
                      color: col2,
                    );
                  } else {
                    return SingleTile(
                      index: index + 1,
                      name: data['path'][index],
                      color: col3,
                    );
                  }
                } else if (data['interchange'].length == 3) {
                  Color col1 = data['line1'][0].contains('red')
                      ? Colors.red
                      : data['line1'][0].contains('green')
                          ? Colors.green
                          : data['line1'][0].contains('blue')
                              ? Colors.blue
                              : data['line1'][0].contains('yellow')
                                  ? const Color.fromARGB(255, 216, 195, 5)
                                  : data['line1'][0].contains('orange')
                                      ? Colors.orange
                                      : data['line1'][0].contains('pink')
                                          ? Colors.pink
                                          : data['line1'][0].contains('violet')
                                              ? Colors.purple
                                              : Colors.grey;
                  Color col2 = data['line2'][0].contains('red')
                      ? Colors.red
                      : data['line2'][0].contains('green')
                          ? Colors.green
                          : data['line2'][0].contains('blue')
                              ? Colors.blue
                              : data['line2'][0].contains('yellow')
                                  ? const Color.fromARGB(255, 216, 195, 5)
                                  : data['line2'][0].contains('orange')
                                      ? Colors.orange
                                      : data['line2'][0].contains('pink')
                                          ? Colors.pink
                                          : data['line2'][0].contains('violet')
                                              ? Colors.purple
                                              : Colors.grey;
                  Color col3 = data['line2'][1].contains('red')
                      ? Colors.red
                      : data['line2'][1].contains('green')
                          ? Colors.green
                          : data['line2'][1].contains('blue')
                              ? Colors.blue
                              : data['line2'][1].contains('yellow')
                                  ? const Color.fromARGB(255, 216, 195, 5)
                                  : data['line2'][1].contains('orange')
                                      ? Colors.orange
                                      : data['line2'][1].contains('pink')
                                          ? Colors.pink
                                          : data['line2'][1].contains('violet')
                                              ? Colors.purple
                                              : Colors.grey;
                  Color col4 = data['line2'][2].contains('red')
                      ? Colors.red
                      : data['line2'][2].contains('green')
                          ? Colors.green
                          : data['line2'][2].contains('blue')
                              ? Colors.blue
                              : data['line2'][2].contains('yellow')
                                  ? const Color.fromARGB(255, 216, 195, 5)
                                  : data['line2'][2].contains('orange')
                                      ? Colors.orange
                                      : data['line2'][2].contains('pink')
                                          ? Colors.pink
                                          : data['line2'][2].contains('violet')
                                              ? Colors.purple
                                              : Colors.grey;

                  if (data['interchange'][0] == data['path'][index]) {
                    changed = true;
                  }
                  if (data['interchange'][1] == data['path'][index]) {
                    changed2 = true;
                  }
                  if (data['interchange'][2] == data['path'][index]) {
                    changed3 = true;
                  }
                  if (!changed && !changed2 && !changed3) {
                    return SingleTile(
                      index: index + 1,
                      name: data['path'][index],
                      color: col1,
                    );
                  } else if (changed && !changed2 && !changed3) {
                    return SingleTile(
                      index: index + 1,
                      name: data['path'][index],
                      color: col2,
                    );
                  } else if (changed && changed2 && !changed3) {
                    return SingleTile(
                      index: index + 1,
                      name: data['path'][index],
                      color: col3,
                    );
                  } else {
                    return SingleTile(
                      index: index + 1,
                      name: data['path'][index],
                      color: col4,
                    );
                  }
                }
                return SingleTile(
                  index: index + 1,
                  name: data['path'][index],
                  color: Colors.green,
                );
              },
            ),
          ),
        ]));
  }
}

// ignore: must_be_immutable
class SingleTile extends StatelessWidget {
  int index;
  String name;
  Color color;
  SingleTile(
      {super.key,
      required this.index,
      required this.name,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Column(
          children: [
            Container(
              height: 20,
              width: 2,
              color: color,
            ),
            Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )),
            Container(
              height: 9,
              width: 2,
              color: color,
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style:const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            Text(
              name,
              style:const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
