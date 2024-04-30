import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokemonapp/game/button.dart';
import 'package:pokemonapp/game/characters/boy.dart';
import 'package:pokemonapp/game/maps/littleroot.dart';
import 'package:pokemonapp/main.dart';

void main() {
  runApp(MyAppGame());
}

class MyAppGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*
    VARIABLES
  */

  //littleroot
  double mapx = 1.0;
  double mapy = 0.29999999999999993;

  //boy charcter
  int boySpriteCount = 0;
  String boyDirection = 'Down';

  //gmae stuff
  String currentLocation = 'littleroot';
  double step = 0.25;

  //no mans land for littleroot
  List<List<double>> noMansLandLittleroot = [
    [0.5, 0.5],
    [1.25, -0.20000000000000007],
    [1.25, -0.45000000000000007],
    [1.25, -0.7000000000000001],
    [1.0, -0.7000000000000001],
    [0.75, -0.7000000000000001],
    [0.5, -0.45000000000000007],
    [0.25, -0.7000000000000001],
    [0.25, -0.45000000000000007],
    [0.25, -0.20000000000000007],
    [0.5, -0.20000000000000007],
    [0.75, -0.20000000000000007],
    [1.0, -0.20000000000000007],
    [1.25, -0.20000000000000007],
  ];

  void moveUp() {
    boyDirection = 'Up';
    setState(() {
      mapy += step;
    });
    animateWalk();
  }

  void moveDown() {
    boyDirection = 'Down';
    setState(() {
      mapy -= step;
    });
    animateWalk();
  }

  void moveLeft() {
    boyDirection = 'Left';
    if (currentLocation == 'LittleRoot') {
      setState(() {
        mapx += step;
      });
      animateWalk();
    }
  }

  void moveRight() {
    boyDirection = 'Right';
    setState(() {
      mapx -= step;
    });
    animateWalk();
  }

  void pressedA() {}
  void pressedB() {}

  void animateWalk() {
    print('x: ' + mapx.toString());
    print('y: ' + mapy.toString());

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        boySpriteCount++;
      });
      if (boySpriteCount == 3) {
        boySpriteCount = 0;
        timer.cancel();
      }
    });
  }

  bool canMoveTo(String direction, var noMansLand, double x, doubley) {
    double stepX = 0;
    double stepY = 0;

    if (direction == 'Left') {
      stepX = step;
      stepY = 0;
    } else if (direction == 'Right') {
      stepX = -step;
      stepY = 0;
    } else if (direction == 'Up') {
      stepX = 0;
      stepY = step;
    } else if (direction == 'Down') {
      stepX = 0;
      stepY = -step;
    }

    for (int i = 0; i < noMansLand.length; i++) {
      if ((cleanNum(noMansLand[i][0]) == cleanNum(x + stepX)) &&
          (cleanNum(noMansLand[i][0]) == cleanNum(x + stepY))) {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: Colors.black,
            child: Stack(
              children: [
                LittleRoot(
                  x: mapx,
                  y: mapy,
                  currentMap: currentLocation,
                ),

                // boy character
                Container(
                  alignment: Alignment(0, 0),
                  child: MyBoy(
                    location: currentLocation,
                    boySpriteCount: boySpriteCount,
                    direction: boyDirection,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Container(
          color: Colors.grey[900],
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'G A M E B O Y',
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: '←',
                                Function: moveLeft,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              MyButton(
                                text: '↑',
                                Function: moveUp,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: '↓',
                                Function: moveDown,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: '→',
                                Function: moveRight,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: 'b',
                                Function: pressedB,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              MyButton(
                                text: 'a',
                                Function: pressedA,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'C R E A T E D   B Y  P A U',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
        ))
      ],
    ));
  }

  double cleanNum(double num) {
    return double.parse(num.toStringAsFixed(2));
  }
}
