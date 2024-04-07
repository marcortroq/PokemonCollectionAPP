import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Packs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/fondosec.png'), // Reemplaza 'assets/background_image.jpg' con la ruta de tu imagen
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, String imagePath, BuildContext context) {
    return Stack(
        // Coloca aquí el contenido que desees sobre el fondo de pantalla
        );
  }
}

void main() {
  runApp(MaterialApp(
    home: Packs(),
  ));
}
