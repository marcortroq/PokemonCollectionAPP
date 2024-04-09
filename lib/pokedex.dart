import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Pokedex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/fondosec.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: _labels(context),
      ),
    );
  }

  Widget _labels(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            // Acción a realizar cuando se toque la etiqueta 1
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Text(
              "COLLECTION",
              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontFamily: 'sarpanch'),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Acción a realizar cuando se toque la etiqueta 2
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(8),
            child: Text(
              "DUPLICATES",
              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontFamily: 'sarpanch'),
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Pokedex(),
  ));
}
