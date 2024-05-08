import 'dart:async';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pokemonapp/game/button.dart';
import 'package:pokemonapp/game/characters/Brock.dart';
import 'package:pokemonapp/game/characters/boy.dart';
import 'package:pokemonapp/game/maps/bluehouse.dart';
import 'package:pokemonapp/game/maps/littleroot.dart';
import 'package:pokemonapp/game/maps/pinkhouse.dart';
import 'package:pokemonapp/game/maps/pokelab.dart';
import 'package:pokemonapp/game/maps/upbluehouse.dart';
import 'package:pokemonapp/game/maps/uppinkhouse.dart';
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

  //pokelab
  double lapMapx = 0;
  double lapMapy = 0;

  //houseBlue
  double BluMapx = 0;
  double BluMapy = 0;
  double upBluMapx = 0;
  double upBluMapy = 0;

  //HousePink
  double PinkMapx = 0;
  double PinkMapy = 0;
  double upPinkMapx = 0;
  double upPinkMapy = 0;

  //battle 1
  String BrockDirection = 'Down';
  static double BrockX = 0.1;
  static double BrockY = 0.9;
  bool chatStarted = false;
  int countPressingA = -1;

  //battle 2

  //battle 3

  //battle 4

  //battle 5

  //battle 6

  //battle 7

  //battle 8


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
    [1.25, -0.45000000000000007],
    [1.0, -0.45000000000000007],
    [0.75, -0.45000000000000007],
    [0.5, -0.45000000000000007],
    [0.25, -0.45000000000000007],
    [0.25, -0.20000000000000007],
    [0.75, -0.7000000000000001],
    [0.5, -0.20000000000000007],
    [0.75, -0.20000000000000007],
    [1.0, -0.20000000000000007],
    [1.25, -0.20000000000000007],
    [-1.0, -0.20000000000000007],
    [-0.75, 1.5499999999999998],
    [-1.0, 1.5499999999999998],
    [-1.25, 1.5499999999999998],
    [-1.5, 1.5499999999999998],
    [-1.75, 1.5499999999999998],
    [-1.75, 1.2999999999999998],
    [-2.0, 1.2999999999999998],
    [0.5, 0.5499999999999999],
    [0.75, 0.5499999999999999],
    [1.0, 0.5499999999999999],
    [1.25, 0.5499999999999999],
    [1.5, 0.5499999999999999],
    [1.5, 0.7999999999999999],
    [1.25, 0.7999999999999999],
    [1.0, 0.7999999999999999],
    [0.75, 0.7999999999999999],
    [-0.5, 0.5499999999999998],
    [-0.75, 0.5499999999999998],
    [-1.0, 0.5499999999999998],
    [-1.25, 0.5499999999999998],
    [-1.25, 0.7999999999999998],
    [-1.0, 0.7999999999999998],
    [-0.75, 0.7999999999999998],
    [-0.25, 2.05],
    [0.0, 2.05],
    [-0.75, 1.7999999999999998],
    [-2.25, 1.0499999999999998],
    [-2.25, 0.7999999999999998],
    [-2.25, 0.5499999999999998],
    [-2.25, 0.2999999999999998],
    [-2.25, 0.04999999999999982],
    [-2.25, -0.20000000000000018],
    [-2.25, -0.4500000000000002],
    [-2.0, -0.7000000000000002],
    [-1.75, -0.7000000000000002],
    [-1.5, -0.9500000000000002],
    [-1.5, -1.2000000000000002],
    [-1.5, -1.4500000000000002],
    [-1.25, -1.4500000000000002],
    [-1.0, -1.4500000000000002],
    [-0.75, -1.4500000000000002],
    [-0.5, -1.4500000000000002],
    [-0.25, -1.4500000000000002],
    [0.0, -1.4500000000000002],
    [0.25, -1.4500000000000002],
    [0.5, -1.4500000000000002],
    [0.75, -1.4500000000000002],
    [1.0, -1.4500000000000002],
    [1.25, -1.4500000000000002],
    [1.5, -1.4500000000000002],
    [1.75, -1.2000000000000002],
    [2.0, -0.9500000000000002],
    [2.25, -0.9500000000000002],
    [2.25, -0.7000000000000002],
    [2.25, -0.4500000000000002],
    [2.25, -0.20000000000000018],
    [2.25, 0.04999999999999982],
    [2.25, 0.2999999999999998],
    [2.25, 0.5499999999999998],
    [2.25, 0.7999999999999998],
    [2.25, 1.0499999999999998],
    [2.25, 1.2999999999999998],
    [2.0, 1.2999999999999998],
    [1.75, 1.2999999999999998],
    [1.75, 1.5499999999999998],
    [1.5, 1.5499999999999998],
    [1.25, 1.5499999999999998],
    [1.0, 1.5499999999999998],
    [0.75, 1.5499999999999998],
    [0.5, 1.5499999999999998],
    [0.25, 1.5499999999999998],
    [0.25, 1.5499999999999998],
  ];

  List<List<double>> noMansLandPokelab = [
    [0.25, -2.95],
    [0.5, -2.95],
    [0.75, -2.95],
    [1.0, -2.95],
    [1.25, -2.95],
    [1.5, -2.95],
    [1.75, -2.95],
    [2.0, -2.95],
    [2.25, -2.95],
    [2.5, -2.95],
    [2.75, -2.95],
    [3.0, -2.95],
    [3.0, -2.7],
    [3.0, -2.45],
    [3.0, -2.2],
    [3.0, -1.9500000000000002],
    [3.0, -1.7000000000000002],
    [3.0, -1.4500000000000002],
    [3.0, -1.2000000000000002],
    [3.0, -0.9500000000000002],
    [3.0, -0.7000000000000002],
    [3.0, -0.4500000000000002],
    [3.0, -0.20000000000000018],
    [3.0, 0.04999999999999982],
    [3.0, 0.2999999999999998],
    [3.0, 0.5499999999999998],
    [3.0, 0.7999999999999998],
    [3.0, 1.0499999999999998],
    [3.0, 1.2999999999999998],
    [3.0, 1.5499999999999998],
    [3.0, 1.7999999999999998],
    [3.0, 2.05],
    [3.0, 2.3],
    [2.75, 2.3],
    [2.5, 2.3],
    [2.25, 2.3],
    [2.0, 2.3],
    [1.75, 2.3],
    [1.5, 2.3],
    [1.25, 2.3],
    [1.0, 2.3],
    [0.75, 2.3],
    [0.5, 2.3],
    [0.25, 2.3],
    [0.0, 2.3],
    [-0.25, 2.3],
    [-0.5, 2.3],
    [-0.75, 2.3],
    [-1.0, 2.3],
    [-1.25, 2.3],
    [-1.5, 2.3],
    [-1.75, 2.3],
    [-2.0, 2.3],
    [-2.25, 2.3],
    [-2.5, 2.3],
    [-2.75, 2.3],
    [-3.0, 2.3],
    [-3.0, 2.05],
    [-3.0, 1.7999999999999998],
    [-3.0, 1.5499999999999998],
    [-3.0, 1.2999999999999998],
    [-3.0, 1.0499999999999998],
    [-3.0, 0.7999999999999998],
    [-3.0, 0.5499999999999998],
    [-3.0, 0.2999999999999998],
    [-3.0, 0.04999999999999982],
    [-3.0, -0.20000000000000018],
    [-3.0, -0.4500000000000002],
    [-3.0, -0.7000000000000002],
    [-3.0, -0.9500000000000002],
    [-3.0, -1.2000000000000002],
    [-3.0, -1.4500000000000002],
    [-3.0, -1.7000000000000002],
    [-3.0, -1.9500000000000002],
    [-3.0, -2.2],
    [-3.0, -2.45],
    [-3.0, -2.7],
    [1.5, -2.7],
    [1.25, -2.7],
    [2.25, -2.2],
    [2.25, -1.9500000000000002],
    [2.25, -1.7000000000000002],
    [2.25, -1.4500000000000002],
    [2.25, -1.2000000000000002],
    [2.75, -0.20000000000000018],
    [2.5, -0.20000000000000018],
    [2.25, -0.20000000000000018],
    [2.0, -0.20000000000000018],
    [1.75, -0.20000000000000018],
    [1.5, -0.20000000000000018],
    [1.25, -0.20000000000000018],
    [1.25, 0.04999999999999982],
    [1.25, 0.2999999999999998],
    [1.25, 0.5499999999999998],
    [1.5, 0.5499999999999998],
    [1.75, 0.5499999999999998],
    [2.0, 0.5499999999999998],
    [2.25, 0.5499999999999998],
    [2.5, 0.5499999999999998],
    [2.75, 0.5499999999999998],
    [2.75, 1.5499999999999998],
    [2.75, 1.7999999999999998],
    [2.75, 2.05],
    [2.5, 2.05],
    [2.25, 2.3],
    [2.0, 2.3],
    [1.75, 2.05],
    [1.5, 2.3],
    [1.25, 2.3],
    [1.0, 2.3],
    [0.75, 2.3],
    [0.0, 2.3],
    [-0.25, 2.3],
    [-0.5, 2.3],
    [-0.75, 2.3],
    [-1.0, 2.3],
    [-1.25, 2.3],
    [-1.25, 1.2999999999999998],
    [-1.25, 1.0499999999999998],
    [-1.5, 1.0499999999999998],
    [-1.75, 1.0499999999999998],
    [-1.75, 1.2999999999999998],
    [-1.75, 1.5499999999999998],
    [-1.75, 0.2999999999999998],
    [-1.75, 0.04999999999999982],
    [-1.75, -0.20000000000000018],
    [-2.0, -0.20000000000000018],
    [-2.0, 0.2999999999999998],
    [-2.25, 0.04999999999999982],
    [-2.25, -0.20000000000000018],
    [-2.5, -0.20000000000000018],
    [-2.75, -0.20000000000000018],
    [-2.75, -1.2000000000000002],
    [-2.5, -1.2000000000000002],
    [-2.25, -1.2000000000000002],
    [-2.0, -1.2000000000000002],
    [-2.0, -1.4500000000000002],
    [-2.0, -1.7000000000000002],
    [-2.0, -1.9500000000000002],
    [-2.0, -2.2],
    [-2.25, -2.2],
    [-2.5, -2.2],
    [-2.75, -2.2],
  ];

  List<List<double>> noMansLandPinkHouse = [
    [2.75, 0.7999999999999998],
    [2.5, 0.7999999999999998],
    [2.25, 0.7999999999999998],
    [2.0, 0.7999999999999998],
    [2.0, 1.0499999999999998],
    [1.75, 1.0499999999999998],
    [1.5, 1.0499999999999998],
    [1.25, 1.0499999999999998],
    [1.0, 1.0499999999999998],
    [1.0, 0.7999999999999998],
    [0.75, 0.7999999999999998],
    [0.75, 1.0499999999999998],
    [0.5, 1.0499999999999998],
    [0.25, 1.0499999999999998],
    [0.0, 1.0499999999999998],
    [-0.25, 1.0499999999999998],
    [-0.5, 1.0499999999999998],
    [-0.75, 1.0499999999999998],
    [-0.75, 0.7999999999999998],
    [-1.0, 0.7999999999999998],
    [-1.25, 0.7999999999999998],
    [-1.5, 0.7999999999999998],
    [-1.75, 0.7999999999999998],
    [-2.0, 0.7999999999999998],
    [-2.25, 0.7999999999999998],
    [-2.5, 0.7999999999999998],
    [-2.75, 0.7999999999999998],
    [-3.0, 0.7999999999999998],
    [-3.0, 0.5499999999999998],
    [-3.0, 0.2999999999999998],
    [-3.0, 0.04999999999999982],
    [-3.0, -0.20000000000000018],
    [-3.0, -0.4500000000000002],
    [-3.0, -0.7000000000000002],
    [-3.0, -0.9500000000000002],
    [-3.0, -1.2000000000000002],
    [-3.0, -1.4500000000000002],
    [-2.75, -1.4500000000000002],
    [-2.5, -1.4500000000000002],
    [-2.25, -1.4500000000000002],
    [-2.0, -1.4500000000000002],
    [-1.75, -1.4500000000000002],
    [-1.5, -1.4500000000000002],
    [-1.25, -1.4500000000000002],
    [-1.0, -1.4500000000000002],
    [-0.75, -1.4500000000000002],
    [-0.5, -1.4500000000000002],
    [-0.25, -1.4500000000000002],
    [0.0, -1.4500000000000002],
    [0.25, -1.4500000000000002],
    [0.5, -1.4500000000000002],
    [0.75, -1.4500000000000002],
    [1.0, -1.4500000000000002],
    [1.25, -1.4500000000000002],
    [1.5, -1.4500000000000002],
    [1.75, -1.4500000000000002],
    [2.0, -1.4500000000000002],
    [2.25, -1.4500000000000002],
    [2.5, -1.4500000000000002],
    [2.75, -1.4500000000000002],
    [2.75, -1.2000000000000002],
    [2.75, -0.9500000000000002],
    [2.75, -0.7000000000000002],
    [2.75, -0.4500000000000002],
    [2.75, -0.20000000000000018],
    [2.75, 0.04999999999999982],
    [2.75, 0.2999999999999998],
    [2.75, 0.5499999999999998],
    [2.75, 0.7999999999999998],
    [-0.5, -0.4500000000000002],
    [-0.75, -0.4500000000000002],
    [-1.0, -0.4500000000000002],
    [-1.0, -0.7000000000000002],
    [-1.0, -0.9500000000000002],
    [-0.75, -0.9500000000000002],
    [-0.5, -0.9500000000000002],
    [-0.5, -0.7000000000000002],
    [-0.5, -0.4500000000000002],
    [-0.5, 0.04999999999999982],
    [-0.75, 0.04999999999999982],
    [-1.0, 0.04999999999999982],
    [-1.25, 0.04999999999999982],
    [-1.5, 0.04999999999999982],
    [-1.75, 0.04999999999999982],
  ];

  List<List<double>> noMansLandBlueHouse = [
    [-3.0, -1.4500000000000002],
    [-2.75, -1.4500000000000002],
    [-2.5, -1.4500000000000002],
    [-2.25, -1.4500000000000002],
    [-2.0, -1.4500000000000002],
    [-1.75, -1.4500000000000002],
    [-1.5, -1.4500000000000002],
    [-1.25, -1.4500000000000002],
    [-1.0, -1.4500000000000002],
    [-0.75, -1.4500000000000002],
    [-0.5, -1.4500000000000002],
    [-0.25, -1.4500000000000002],
    [0.0, -1.4500000000000002],
    [0.25, -1.4500000000000002],
    [0.5, -1.4500000000000002],
    [0.75, -1.4500000000000002],
    [1.0, -1.4500000000000002],
    [1.25, -1.4500000000000002],
    [1.5, -1.4500000000000002],
    [1.75, -1.4500000000000002],
    [2.0, -1.4500000000000002],
    [2.25, -1.4500000000000002],
    [2.5, -1.4500000000000002],
    [2.75, -1.4500000000000002],
    [3.0, -1.4500000000000002],
    [3.0, -1.2000000000000002],
    [3.0, -0.9500000000000002],
    [3.0, -0.7000000000000002],
    [3.0, -0.4500000000000002],
    [3.0, -0.20000000000000018],
    [3.0, 0.04999999999999982],
    [3.0, 0.2999999999999998],
    [3.0, 0.5499999999999998],
    [3.0, 0.7999999999999998],
    [2.75, 0.7999999999999998],
    [2.5, 0.7999999999999998],
    [2.25, 0.7999999999999998],
    [2.0, 0.7999999999999998],
    [1.75, 0.7999999999999998],
    [1.5, 0.7999999999999998],
    [1.25, 0.7999999999999998],
    [1.0, 0.7999999999999998],
    [0.75, 0.7999999999999998],
    [0.5, 0.7999999999999998],
    [0.5, 1.0499999999999998],
    [0.25, 1.0499999999999998],
    [0.0, 1.0499999999999998],
    [-0.25, 1.0499999999999998],
    [-0.5, 1.0499999999999998],
    [-0.75, 1.0499999999999998],
    [-0.75, 0.7999999999999998],
    [-1.0, 0.7999999999999998],
    [-1.0, 1.0499999999999998],
    [-1.25, 1.0499999999999998],
    [-1.5, 1.0499999999999998],
    [-1.75, 1.0499999999999998],
    [-2.0, 1.0499999999999998],
    [-2.0, 0.7999999999999998],
    [-2.25, 0.7999999999999998],
    [-2.5, 0.7999999999999998],
    [-2.75, 0.7999999999999998],
    [-2.75, 0.5499999999999998],
    [-2.75, 0.2999999999999998],
    [-2.75, 0.04999999999999982],
    [-2.75, -0.20000000000000018],
    [-2.75, -0.4500000000000002],
    [-2.75, -0.7000000000000002],
    [-2.75, -0.9500000000000002],
    [-2.75, -1.2000000000000002],
    [-2.75, -1.4500000000000002],
    [0.5, -0.9500000000000002],
    [0.75, -0.9500000000000002],
    [1.0, -0.9500000000000002],
    [1.25, -0.9500000000000002],
    [0.25, -0.9500000000000002],
    [0.25, -0.7000000000000002],
    [0.25, -0.4500000000000002],
    [0.5, -0.4500000000000002],
    [0.75, -0.4500000000000002],
    [1.0, -0.4500000000000002],
    [1.25, -0.4500000000000002],
    [1.5, 0.04999999999999982],
    [1.25, 0.04999999999999982],
    [1.0, 0.04999999999999982],
    [0.5, 0.04999999999999982],
  ];

  List<List<double>> noMansLandupBlueHouse = [
    [-2.5, 1.2999999999999998],
    [-2.75, 1.2999999999999998],
    [-2.25, 1.2999999999999998],
    [-2.25, 1.5499999999999998],
    [-2.25, 1.7999999999999998],
    [-2.0, 1.7999999999999998],
    [-1.75, 1.7999999999999998],
    [-1.5, 1.7999999999999998],
    [-1.5, 1.5499999999999998],
    [-1.5, 1.2999999999999998],
    [-1.25, 1.2999999999999998],
    [-1.0, 1.2999999999999998],
    [-0.75, 1.2999999999999998],
    [-0.5, 1.2999999999999998],
    [-0.25, 1.2999999999999998],
    [-0.25, 1.0499999999999998],
    [0.0, 1.0499999999999998],
    [0.25, 1.0499999999999998],
    [0.5, 1.0499999999999998],
    [0.75, 1.0499999999999998],
    [0.75, 1.2999999999999998],
    [1.0, 1.2999999999999998],
    [1.25, 1.2999999999999998],
    [1.5, 1.2999999999999998],
    [1.75, 1.2999999999999998],
    [1.75, 1.0499999999999998],
    [2.0, 1.0499999999999998],
    [2.25, 1.0499999999999998],
    [2.5, 1.0499999999999998],
    [2.75, 1.0499999999999998],
    [2.75, 0.7999999999999998],
    [2.75, 0.5499999999999998],
    [2.75, 0.2999999999999998],
    [2.75, 0.04999999999999982],
    [2.75, -0.20000000000000018],
    [2.75, -0.4500000000000002],
    [2.75, -0.7000000000000002],
    [2.75, -0.9500000000000002],
    [2.75, -1.2000000000000002],
    [2.75, -1.4500000000000002],
    [2.75, -1.7000000000000002],
    [2.5, -1.7000000000000002],
    [2.25, -1.7000000000000002],
    [2.0, -1.7000000000000002],
    [1.75, -1.7000000000000002],
    [1.5, -1.7000000000000002],
    [1.25, -1.7000000000000002],
    [1.0, -1.7000000000000002],
    [0.75, -1.7000000000000002],
    [0.5, -1.7000000000000002],
    [0.25, -1.7000000000000002],
    [0.0, -1.7000000000000002],
    [-0.25, -1.7000000000000002],
    [-0.5, -1.7000000000000002],
    [-0.75, -1.7000000000000002],
    [-1.0, -1.7000000000000002],
    [-1.25, -1.7000000000000002],
    [-1.5, -1.7000000000000002],
    [-1.75, -1.7000000000000002],
    [-2.0, -1.7000000000000002],
    [-2.25, -1.7000000000000002],
    [-2.5, -1.7000000000000002],
    [-2.75, -1.7000000000000002],
    [-2.75, -1.4500000000000002],
    [-2.75, -1.2000000000000002],
    [-2.75, -0.9500000000000002],
    [-2.75, -0.7000000000000002],
    [-2.75, -0.4500000000000002],
    [-2.75, -0.20000000000000018],
    [-2.75, 0.04999999999999982],
    [-2.75, 0.2999999999999998],
    [-2.75, 0.5499999999999998],
    [-2.75, 0.7999999999999998],
    [-2.75, 1.0499999999999998],
    [-2.75, 1.2999999999999998],
    [1.5, -0.4500000000000002],
    [1.5, -0.20000000000000018],
    [1.5, 0.04999999999999982],
    [1.75, 0.04999999999999982],
    [2.0, 0.04999999999999982],
    [2.0, -0.20000000000000018],
    [2.0, -0.4500000000000002],
    [1.75, -0.4500000000000002],
    [1.5, -0.4500000000000002],
  ];

  List<List<double>> noMansLandupPinkHouse = [
    [2.75, 1.2999999999999998],
    [2.5, 1.2999999999999998],
    [2.25, 1.2999999999999998],
    [2.25, 1.5499999999999998],
    [2.0, 1.5499999999999998],
    [1.75, 1.5499999999999998],
    [1.5, 1.5499999999999998],
    [1.5, 1.2999999999999998],
    [1.25, 1.2999999999999998],
    [1.0, 1.2999999999999998],
    [0.75, 1.2999999999999998],
    [0.25, 1.2999999999999998],
    [0.5, 1.2999999999999998],
    [0.25, 1.2999999999999998],
    [0.25, 1.0499999999999998],
    [0.0, 1.0499999999999998],
    [-0.25, 1.0499999999999998],
    [-0.5, 1.0499999999999998],
    [-0.75, 1.0499999999999998],
    [-0.75, 1.2999999999999998],
    [-1.0, 1.2999999999999998],
    [-1.25, 1.2999999999999998],
    [-1.5, 1.2999999999999998],
    [-1.75, 1.2999999999999998],
    [-2.0, 1.2999999999999998],
    [-2.25, 1.2999999999999998],
    [-2.5, 1.2999999999999998],
    [-2.75, 1.2999999999999998],
    [-2.75, 0.7999999999999998],
    [-2.75, 0.5499999999999998],
    [-2.75, 0.2999999999999998],
    [-2.75, 0.04999999999999982],
    [-2.75, -0.20000000000000018],
    [-2.75, -0.4500000000000002],
    [-2.75, -0.7000000000000002],
    [-2.75, -0.9500000000000002],
    [-2.75, -1.2000000000000002],
    [-2.75, -1.4500000000000002],
    [-2.75, -1.7000000000000002],
    [-2.5, -1.7000000000000002],
    [-2.25, -1.7000000000000002 ],
    [-2.0, -1.7000000000000002],
    [-1.75, -1.7000000000000002],
    [-1.5, -1.7000000000000002],
    [-1.25, -1.7000000000000002],
    [-1.0, -1.7000000000000002],
    [-0.75, -1.7000000000000002],
    [-0.5, -1.7000000000000002],
    [-0.25, -1.7000000000000002],
    [0.0, -1.7000000000000002],
    [0.25, -1.7000000000000002],
    [0.5, -1.7000000000000002],
    [0.75, -1.7000000000000002],
    [1.0, -1.7000000000000002],
    [1.25, -1.7000000000000002],
    [1.5, -1.7000000000000002],
    [1.75, -1.7000000000000002],
    [2.0, -1.7000000000000002],
    [2.25, -1.7000000000000002],
    [2.5, -1.7000000000000002],
    [2.75, -1.7000000000000002],
    [2.75, -1.4500000000000002],
    [2.75, -1.2000000000000002],
    [2.75, -0.9500000000000002],
    [2.75, -0.7000000000000002],
    [2.75, -0.4500000000000002],
    [2.75, -0.20000000000000018],
    [2.75, 0.04999999999999982],
    [2.75, 0.2999999999999998],
    [2.75, 0.5499999999999998],
    [2.75, 0.7999999999999998],
    [2.75, 1.0499999999999998],
    [-1.5, 0.04999999999999982],
    [-1.5, -0.20000000000000018],
    [-1.5, -0.4500000000000002],
    [-1.75, -0.4500000000000002],
    [-2.0, -0.4500000000000002],
    [-2.25, -0.4500000000000002],
    [-2.25, -0.20000000000000018],
    [-2.25, 0.04999999999999982],
    [-2.0, 0.04999999999999982],
    [-1.75, 0.04999999999999982],
    [-1.5, 0.04999999999999982],
  ];

  void moveUp() {
    boyDirection = 'Up';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapx, mapy)) {
        setState(() {
          mapy += step;
        });

        //enter pokelab
        if (double.parse((mapx).toStringAsFixed(4)) == 0.5 &&
            (mapy >= -0.7002 && mapy <= -0.6999)) {
          setState(() {
            currentLocation = 'pokelab';
            lapMapx = -0.25;
            lapMapy = -2.45;
          });
        }

        // Entrar a la casa rosa
        if (mapx >= -1.05 && mapx <= -1.0 && mapy >= 0.299 && mapy <= 0.300) {
          setState(() {
            currentLocation = 'pinkhouse';
            PinkMapx = 1.75; // Corregido
            PinkMapy = -0.9500000000000002; // Corregido
          });
        }

        // Entrar a la casa azul
        if (mapx >= 0.95 && mapx <= 1.05 && mapy >= 0.299 && mapy <= 0.300) {
          setState(() {
            currentLocation = 'bluehouse';
            BluMapx = -1.75;
            BluMapy = -0.9500000000000002;
          });
        }
      }
      animateWalk();
    }
    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandPokelab, lapMapx, lapMapy)) {
        setState(() {
          lapMapy += step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'pinkhouse') {
      if (canMoveTo(boyDirection, noMansLandPinkHouse, PinkMapx, PinkMapy)) {
        setState(() {
          PinkMapy += step;
        });
        // segundo piso
        if (PinkMapx >= 1.4 &&
            PinkMapx <= 1.6 &&
            PinkMapy >= 0.7 &&
            PinkMapy <= 0.9) {
          setState(() {
            currentLocation = 'uppinkhouse';
            upPinkMapx = 1.75;
            upPinkMapy = 0.5499999999999998;
            boyDirection = 'Down';
          });
        }
      }
      animateWalk();
    }

    if (currentLocation == 'uppinkhouse') {
      if (canMoveTo(
          boyDirection, noMansLandupPinkHouse, upPinkMapx, upPinkMapy)) {
        setState(() {
          upPinkMapy += step;
        });
      }
      // primer piso
      if (upPinkMapx >= 1.7 &&
          upPinkMapx <= 1.8 &&
          upPinkMapy >= 1.0 &&
          upPinkMapy <= 1.1) {
        setState(() {
          currentLocation = 'pinkhouse';
          PinkMapx = 1.5;
          PinkMapy = 0.7999999999999998;
          boyDirection = 'Down';
        });
      }
      animateWalk();
    }

    if (currentLocation == 'bluehouse') {
      if (canMoveTo(boyDirection, noMansLandBlueHouse, BluMapx, BluMapy)) {
        setState(() {
          BluMapy += step;
        });
        // segundo piso
        if (BluMapx >= -1.55 &&
            BluMapx <= -1.45 &&
            BluMapy >= 0.799 &&
            BluMapy <= 0.801) {
          setState(() {
            currentLocation = 'upbluehouse';
            upBluMapx = -1.75;
            upBluMapy = 1.0499999999999998;
            boyDirection = 'Down';
          });
        }
      }
      animateWalk();
    }
    if (currentLocation == 'upbluehouse') {
      if (canMoveTo(
          boyDirection, noMansLandupBlueHouse, upBluMapx, upBluMapy)) {
        setState(() {
          upBluMapy += step;
        });
        // primer piso
        if (upBluMapx >= -1.76 &&
            upBluMapx <= -1.74 &&
            upBluMapy >= 0.799 &&
            upBluMapy <= 0.801) {
          setState(() {
            currentLocation = 'bluehouse';
            BluMapx = -1.5;
            BluMapy = 0.7999999999999998;
            boyDirection = 'Down';
          });
        }
      }
      animateWalk();
    }
  }

  void moveDown() {
    boyDirection = 'Down';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapx, mapy)) {
        setState(() {
          mapy -= step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandPokelab, lapMapx, lapMapy)) {
        setState(() {
          lapMapy -= step;
        });
      }
      if (double.parse((lapMapx).toStringAsFixed(4)) == -0.25 &&
          double.parse((lapMapy).toStringAsFixed(4)) == -2.7) {
        setState(() {
          currentLocation = 'littleroot';
          mapx = 0.5;
          mapy = -0.7000000000000002;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'pinkhouse') {
      if (canMoveTo(boyDirection, noMansLandPinkHouse, PinkMapx, PinkMapy)) {
        setState(() {
          PinkMapy -= step;
        });

        // Verificar si el personaje está en la ubicación de transición
        if (PinkMapx >= 1.74 &&
            PinkMapx <= 1.76 &&
            PinkMapy >= -1.201 &&
            PinkMapy <= -1.199) {
          setState(() {
            currentLocation = 'littleroot';
            mapx = -1.0;
            mapy = 0.29999999999999993;
          });
        }
      }
      animateWalk();
    }
    if (currentLocation == 'bluehouse') {
      if (canMoveTo(boyDirection, noMansLandBlueHouse, BluMapx, BluMapy)) {
        setState(() {
          BluMapy -= step;
        });

        // Verificar si el personaje está en la ubicación de transición
        if (BluMapx >= -1.76 &&
            BluMapx <= -1.74 &&
            BluMapy >= -1.201 &&
            BluMapy <= -1.199) {
          setState(() {
            currentLocation = 'littleroot';
            mapx = 1.0;
            mapy = 0.29999999999999993;
          });
        }
      }
      animateWalk();
    }
    if (currentLocation == 'upbluehouse') {
      if (canMoveTo(
          boyDirection, noMansLandupBlueHouse, upBluMapx, upBluMapy)) {
        setState(() {
          upBluMapy -= step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'uppinkhouse') {
      if (canMoveTo(
          boyDirection, noMansLandupPinkHouse, upPinkMapx, upPinkMapy)) {
        setState(() {
          upPinkMapy -= step;
        });
      }
      animateWalk();
    }
  }

  void moveLeft() {
    boyDirection = 'Left';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapx, mapy)) {
        setState(() {
          mapx += step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandPokelab, lapMapx, lapMapy)) {
        setState(() {
          lapMapx += step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'pinkhouse') {
      if (canMoveTo(boyDirection, noMansLandPinkHouse, PinkMapx, PinkMapy)) {
        setState(() {
          PinkMapx += step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'bluehouse') {
      if (canMoveTo(boyDirection, noMansLandBlueHouse, BluMapx, BluMapy)) {
        setState(() {
          BluMapx += step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'upbluehouse') {
      if (canMoveTo(
          boyDirection, noMansLandupBlueHouse, upBluMapx, upBluMapy)) {
        setState(() {
          upBluMapx += step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'uppinkhouse') {
      if (canMoveTo(
          boyDirection, noMansLandupPinkHouse, upPinkMapx, upPinkMapy)) {
        setState(() {
          upPinkMapx += step;
        });
      }
      animateWalk();
    }
  }

  void moveRight() {
    boyDirection = 'Right';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapx, mapy)) {
        setState(() {
          mapx -= step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandPokelab, lapMapx, lapMapy)) {
        setState(() {
          lapMapx -= step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'pinkhouse') {
      if (canMoveTo(boyDirection, noMansLandPinkHouse, PinkMapx, PinkMapy)) {
        setState(() {
          PinkMapx -= step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'bluehouse') {
      if (canMoveTo(boyDirection, noMansLandBlueHouse, BluMapx, BluMapy)) {
        setState(() {
          BluMapx -= step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'upbluehouse') {
      if (canMoveTo(
          boyDirection, noMansLandupBlueHouse, upBluMapx, upBluMapy)) {
        setState(() {
          upBluMapx -= step;
        });
      }
      animateWalk();
    }
    if (currentLocation == 'uppinkhouse') {
      if (canMoveTo(
          boyDirection, noMansLandupPinkHouse, upPinkMapx, upPinkMapy)) {
        setState(() {
          upPinkMapx -= step;
        });
      }
      animateWalk();
    }
  }

  void pressedA() {}
  void pressedB() {}

  void animateWalk() {
    print('x: ' + upPinkMapx.toString());
    print('y: ' + upPinkMapy.toString());

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        boySpriteCount++;
      });
      if (boySpriteCount == 3) {
        boySpriteCount = 0;
        timer.cancel();
      }
    });
    setState(() {});
  }

  bool canMoveTo(String direction, var noMansLand, double x, double y) {
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
          (cleanNum(noMansLand[i][1]) == cleanNum(y + stepY))) {
        // Corrección aquí
        return false;
      }
    }
    return true; // Cambiado de false a true
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
                //little root
                LittleRoot(
                  x: mapx,
                  y: mapy,
                  currentMap: currentLocation,
                ),

                //pokelab
                MyPokeLab(
                  x: lapMapx,
                  y: lapMapy,
                  currentMap: currentLocation,
                ),

                //houseBlue
                bluehouse(
                  x: BluMapx,
                  y: BluMapy,
                  currentMap: currentLocation,
                ),

                //uphouseBlue
                upbluehouse(
                  x: upBluMapx,
                  y: upBluMapy,
                  currentMap: currentLocation,
                ),

                //HousePink
                pinkhouse(
                  x: PinkMapx,
                  y: PinkMapy,
                  currentMap: currentLocation,
                ),

                //upHousePink
                uppinkhouse(
                  x: upPinkMapx,
                  y: upPinkMapy,
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

                //Brock
                Container(
                  alignment: Alignment(0, 0),
                  child: Brock(
                    x: lapMapx,
                    y: lapMapx - 0.05,
                    location: currentLocation,
                    BrockDirection: BrockDirection,
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
