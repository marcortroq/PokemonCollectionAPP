import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'main.dart';
import 'packs.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [Color.fromRGBO(255, 22, 22, 1), Colors.black],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final paintFill = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    final path = Path()
      ..moveTo(0 * 0.3762500, 0 * 0.3020000)
      ..lineTo(550 * 0.7487500, 0 * 0.3020000)
      ..lineTo(550 * 0.7487500, 450 * 0.7040000)
      ..lineTo(370 * 0.5637500, 450 * 0.9040000)
      ..lineTo(0 * 0.3762500, 450 * 0.7020000);

    canvas.drawPath(path, paintFill);

    final paintStroke = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0, size.height * 0.3316667)
      ..lineTo(size.width * 0.4175000, size.height * 0.4166667)
      ..lineTo(size.width * 1, size.height * 0.3316667)
      ..lineTo(size.width * 1, size.height * 1.25)
      ..lineTo(size.width * 0, size.height * 1.25);

    final paintFill = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(179, 179, 179, 1),
          Color.fromARGB(255, 255, 255, 255),
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    canvas.drawPath(path, paintFill);
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
          Positioned.fill(
            child: CustomPaint(
              painter: RPSCustomPainter(),
            ),
          ),
          Positioned(
            left: -20,
            top: 30,
            child: Image.asset(
              'assets/grow.png',
              width: 500,
              height: 500,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: 0,
            top: 125,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.width * 1.5),
              painter: RPSCustomPainter2(),
            ),
          ),
          Positioned(
            left: 290,
            top: 233,
            child: Transform.rotate(
              angle: 65 * math.pi / 180,
              child: Container(
                width: 30,
                height: 270,
                color: Color.fromRGBO(29, 30, 29, 1),
              ),
            ),
          ),
          Positioned(
            left: 60,
            top: 215,
            child: Transform.rotate(
              angle: -65 * math.pi / 180,
              child: Container(
                width: 30,
                height: 270,
                color: Color.fromRGBO(29, 30, 29, 1),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 569),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 90),
                          child:
                              _buildButton('PACKS', 'assets/pack.png', context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 70),
                          child: _buildButton(
                              'COLLECT', 'assets/incubadora.png', context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 90),
                          child: _buildButton(
                              'POKEDEX', 'assets/pokeball.png', context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top:
                              0), // Espacio entre el botón "COLLECT" y la imagen
                      child: GestureDetector(
                        onTap: () {
                          // Navegar a la otra pestaña al hacer clic en la imagen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        },
                        child: Image.asset(
                          'assets/OCR.png', // Reemplaza 'ruta/de/la/imagen.png' con la ruta de tu imagen
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width - 240) / 2,
            top: (MediaQuery.of(context).size.height - 320) / 2,
            child: Image.asset(
              'assets/hexMedallas.png',
              width: 240,
              height: 240,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, String imagePath, BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 110,
          height: 148,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(207, 72, 72, 1),
                Color.fromRGBO(224, 17, 17, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 113,
                left: 10,
                right: 10,
                height: 1,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 4,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 35,
                child: Image.asset(
                  imagePath,
                  width: 67,
                  height: 90,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              onTap: () {
                // Aquí es donde se navega a la pantalla packs al presionar el botón
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Packs()), // Reemplaza 'packs()' con la clase correcta de la pantalla packs
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Menu(),
  ));
}
