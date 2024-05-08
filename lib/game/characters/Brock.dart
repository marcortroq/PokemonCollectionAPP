import 'package:flutter/material.dart';

class Brock extends StatelessWidget{
  double x;
  double y;
  String location;
  String BrockDirection;

  Brock(this.x, this.y, this.location, this.BrockDirection);

  @override
  Widget build(BuildContext context) {
    if (location == 'pokelab') {
      return Container(
        alignment: Alignment(x,y),
        child: Image.asset(
          'assets/Game/brock' + BrockDirection + '.png',
          width: MediaQuery.of(context).size.width *
              0.75,
          fit: BoxFit.cover,
        ),
      );
    }else {
      return Container();
    }
  }
}