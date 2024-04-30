import 'package:flutter/material.dart';

class MyBoy extends StatelessWidget {
  final int boySpriteCount;
  final String direction;
  final String location;
  double height = 15;
  
  MyBoy({required this.boySpriteCount, required this.direction, required this.location});

  @override
  Widget build(BuildContext context) {
    if (location == 'littleroot') {
      height = 15;      
    }else if (location == 'pokelab'){
      height = 20;
    }else if (location == 'battlefinishedscreen' || location == 'attackoptions' || location == 'battlefinishedscreen'){
      height = 0;
    }

    return Container(
      height: height,
      child: Image.asset(
        'assets/Game/boy' + direction + boySpriteCount.toString() + '.png',
        fit: BoxFit.cover,
      ),
    );
  }
}