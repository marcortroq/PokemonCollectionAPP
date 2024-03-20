import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = Color.fromARGB(255, 179, 37, 37)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0 * 0.3762500, 0 * 0.3020000);
    path_0.lineTo(550 * 0.7487500, 0 * 0.3020000);
    path_0.lineTo(550 * 0.7487500, 450 * 0.7040000);
    path_0.lineTo(370 * 0.5637500, 450 * 0.9040000);
    path_0.lineTo(0 * 0.3762500, 450 * 0.7020000);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 300, // Ajusta la posición del rectángulo como desees
            left: 0, // Ajusta la posición del rectángulo como desees
            child: Container(
              width: 500, // Ancho del rectángulo
              height: 5750, // Altura del rectángulo
              color: Colors.green, // Color del rectángulo
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(400, 500), // Tamaño del pentágono
              painter: RPSCustomPainter(),
            ),
          ),
          Positioned(
            left: 290, // Ajusta la posición izquierda según lo necesites
            top: 227, // Ajusta la posición superior según lo necesites
            child: Transform.rotate(
              angle: 65 * 3.14 / 180, // Convierte grados a radianes
              child: Container(
                width: 30, // Ancho del rectángulo
                height: 270, // Alto del rectángulo
                color: Color.fromRGBO(29, 30, 29, 1), // Color del rectángulo
              ),
            ),
          ),
          Positioned(
            left: 60, // Ajusta la posición izquierda según lo necesites
            top: 215, // Ajusta la posición superior según lo necesites
            child: Transform.rotate(
              angle: 295 * 3.14 / 180, // Convierte grados a radianes
              child: Container(
                width: 30, // Ancho del rectángulo
                height: 270, // Alto del rectángulo
                color: Color.fromRGBO(29, 30, 29, 1), // Color del rectángulo
              ),
            ),
          ),
          Positioned(
            left: 0, // Ajusta la posición izquierda según lo necesites
            top: 60, // Ajusta la posición superior según lo necesites
            child: Image.asset(
              'assets/hexMedallas.png', // Ruta de la imagen
              width: 420, // Ancho de la imagen
              height: 420, // Alto de la imagen
              fit: BoxFit
                  .contain, // Ajusta el tamaño de la imagen según el contenedor
            ),
          ),
          // Agrega aquí el resto de tu contenido de la pantalla Menu
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Menu(),
  ));
}
