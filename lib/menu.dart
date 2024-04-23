import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokemonapp/countdown_timer.dart';
import 'package:percent_indicator/circular_percent_indicator';
import 'package:pokemonapp/incubadora.dart';
import 'package:pokemonapp/main_ocr.dart';
import 'package:pokemonapp/nav_bar.dart';
import 'package:pokemonapp/pokedex.dart';
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
      ..moveTo(0 * 0.3762500, 0 * 0.4020000)
      ..lineTo(650 * 0.7487500, 0 * 0.3020000)
      ..lineTo(650 * 0.7487500, 550 * 0.7040000)
      ..lineTo(470 * 0.5637500, 550 * 0.9040000)
      ..lineTo(0 * 0.3762500, 550 * 0.7020000);

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
    final double offsetY = 12.0;
    final path = Path()
      ..moveTo(size.width * 0, size.height * 0.3116667 + offsetY)
      ..lineTo(size.width * 0.5, size.height * 0.51)
      ..lineTo(size.width * 1, size.height * 0.316667 + offsetY)
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

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  late String _selectedProfileImage = '';
  late AnimationController _animationController;
  late Animation<double> _animator;
  bool _drawerVisible = false;
  double _extraHeight = 0.0;
  late Size _screen;
  double _maxSlide = 200.0;
  double _startingPos = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animator = _animationController.drive(
      CurveTween(curve: Curves.easeInOut),
    );
    _animationController.addListener(() {
      setState(() {
        _extraHeight = (_screen.height - _screen.width) * _animator.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screen = MediaQuery.of(context).size; // Inicialización de _screen
  }

  @override
  Widget build(BuildContext context) {
    late final Size screenSize = MediaQuery.of(context).size;

    // Calcula el tamaño de la imagen del fondo
    double backgroundWidth = screenSize.width * 1.2;
    double backgroundHeight = screenSize.height * 1.2;

    // Calcula el tamaño y la posición de otros elementos
    double imageWidth = screenSize.width * 0.25;
    double imageHeight = screenSize.width * 0.25;
    double buttonWidth = screenSize.width * 0.35;
    double buttonHeight = screenSize.height * 0.1;
    double iconSize = screenSize.width * 0.1;

    return Scaffold(drawer: NavBar(
      // Pasa una función que actualice _selectedProfileImage a NavBar
      onProfileImageSelected: (String imagePath) {
        setState(() {
          _selectedProfileImage = imagePath;
        });
      },
    ), body: Builder(
        // Usamos un Builder para obtener un contexto que contenga el Scaffold
        builder: (BuildContext context) {
      return Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: RPSCustomPainter(),
            ),
          ),
          Positioned(
            left: -backgroundWidth * 0.05,
            bottom: screenSize.height * 0.06,
            child: Image.asset(
              _selectedProfileImage.isNotEmpty
                  ? _selectedProfileImage
                  : 'assets/grow.png',
              width: backgroundWidth,
              height: backgroundHeight,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: screenSize.width * 0.0,
            bottom: screenSize.height * 0.15,
            child: CustomPaint(
              size: Size(screenSize.width, screenSize.width * 1.5),
              painter: RPSCustomPainter2(),
            ),
          ),
          Positioned(
            right: screenSize.width * 0.0,
            bottom: screenSize.height * 0.44,
            child: Transform.rotate(
              angle: 65 * math.pi / 180,
              child: Container(
                width: screenSize.width * 0.065,
                height: screenSize.height * 0.316,
                color: Color.fromRGBO(29, 30, 29, 1),
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0.0,
            bottom: screenSize.height * 0.44,
            child: Transform.rotate(
              angle: -65 * math.pi / 180,
              child: Container(
                width: screenSize.width * 0.065,
                height: screenSize.height * 0.316,
                color: Color.fromRGBO(29, 30, 29, 1),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.005,
            left: (screenSize.width - 180) / 2,
            child: Image.asset(
              'assets/barramoneda.png', // Ruta de tu imagen
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.13,
            ),
          ),
          Positioned(
            top: screenSize.height * 0.005,
            left: (screenSize.width - -70) / 2,
            child: Image.asset(
              'assets/barrapremium.png', // Ruta de tu imagen
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.13,
            ),
          ),
          /*
          Positioned(
            top: screenSize.height * 0.005,
            left: (screenSize.width - screenSize.width * 1.15) / 2,
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer(); // Abre el Drawer
              },
              child: Image.asset(
                'assets/experiencia.png',
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.13,
              ),
            ),
          ),
          */
          Positioned(
            top: screenSize.height * 0.005,
            left: (screenSize.width - screenSize.width * 1.15) / 2,
            child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer(); // Abre el Drawer
                },
                child: LinearPercentIndicator(
                  lineHeight: 40,
                )),
          ),
          Positioned(
            left: screenSize.width * 0.23,
            top: screenSize.height * 0.6,
            child: _buildRectangularButton("NUEVO BOTÓN", () {
              print("Botón rectangular presionado");
            }),
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
                            padding:
                                EdgeInsets.only(top: screenSize.height * 0.05),
                            child: _buildButton(
                                "PACKS", "assets/pack.png", Packs(), context,
                                topLeftRadius: 0, bottomRightRadius: 0)),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: screenSize.height * 0.09),
                          child: Stack(
                            children: [
                              _buildButton("COLLECT", "assets/incubadora.png",
                                  Incubadora(), context), // INCUBADORA
                              CountdownTimer(), // Contador de cuenta atrás de 12 horas
                            ],
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(top: screenSize.height * 0.05),
                            child: _buildButton("POKEDEX",
                                "assets/pokeball.png", Pokedex(), context,
                                topRightRadius: 0,
                                bottomLeftRadius: 0) //POKEDEX
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.42,
            top: MediaQuery.of(context).size.height * 0.9,
            child: GestureDetector(
              onTap: () {
                // Navegar a la otra pestaña al hacer clic en la imagen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              child: Image.asset(
                'assets/OCR.png', // Reemplaza 'ruta/de/la/imagen.png' con la ruta de tu imagen
              ),
            ),
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width * 0.4) / 2,
            top: (MediaQuery.of(context).size.height * 0.28) / 2,
            child: Stack(
              children: [
                Image.asset(
                  'assets/hexMedallas.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.6,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.17,
                  top: MediaQuery.of(context).size.height * 0.21,
                  child: Image.asset(
                    'assets/MedallaRoca.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.17,
                  top: MediaQuery.of(context).size.height * 0.21,
                  child: Image.asset(
                    'assets/medallaRocaOut.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.17,
                  top: MediaQuery.of(context).size.height * 0.35,
                  child: Image.asset(
                    'assets/MedallaVolcan.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.17,
                  top: MediaQuery.of(context).size.height * 0.35,
                  child: Image.asset(
                    'assets/medallaVolcanOut.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.245,
                  top: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset(
                    'assets/MedallaAlma.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.245,
                  top: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset(
                    'assets/medallaAlmaout.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.4,
                  top: MediaQuery.of(context).size.height * 0.285,
                  child: Image.asset(
                    'assets/MedallaPantano.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.4,
                  top: MediaQuery.of(context).size.height * 0.285,
                  child: Image.asset(
                    'assets/medallaPantanoOut.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.32,
                  top: MediaQuery.of(context).size.height * 0.21,
                  child: Image.asset(
                    'assets/MedallaCascada.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.32,
                  top: MediaQuery.of(context).size.height * 0.21,
                  child: Image.asset(
                    'assets/medallaCascadaOut.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.25,
                  top: MediaQuery.of(context).size.height * 0.315,
                  child: Image.asset(
                    'assets/MedallaArcoiris.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.25,
                  top: MediaQuery.of(context).size.height * 0.315,
                  child: Image.asset(
                    'assets/medallaArcoirisout.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.285,
                  child: Image.asset(
                    'assets/MedallaTrueno.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.285,
                  child: Image.asset(
                    'assets/medallaTruenoOut.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.32,
                  top: MediaQuery.of(context).size.height * 0.35,
                  child: Image.asset(
                    'assets/MedallaTierra.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.32,
                  top: MediaQuery.of(context).size.height * 0.35,
                  child: Image.asset(
                    'assets/medallaTierraOut.png',
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }));
  }

  // Esta función genérica acepta cualquier tipo de pantalla como parámetro y navega a ella.
  void navigateToScreen<T>(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Widget _buildButton(
    String text,
    String imagePath,
    Widget screen,
    BuildContext context, {
    double? topLeftRadius,
    double? topRightRadius,
    double? bottomLeftRadius,
    double? bottomRightRadius,
  }) {
    return Stack(
      children: [
        Container(
          width: 110,
          height: 148,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius ??
                  25), // Usar el valor proporcionado o el predeterminado
              topRight: Radius.circular(topRightRadius ?? 25),
              bottomLeft: Radius.circular(bottomLeftRadius ?? 25),
              bottomRight: Radius.circular(bottomRightRadius ?? 25),
            ),
            border: Border.all(
              color: Colors.black,
              width: 1.5,
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
                topLeft: Radius.circular(topLeftRadius ?? 25),
                topRight: Radius.circular(topRightRadius ?? 25),
                bottomLeft: Radius.circular(bottomLeftRadius ?? 25),
                bottomRight: Radius.circular(bottomRightRadius ?? 25),
              ),
              onTap: () {
                // Aquí llamamos a la función navigateToScreen con la pantalla proporcionada.
                navigateToScreen(context, screen);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRectangularButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 215,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromRGBO(66, 9, 9, 1),
                const Color.fromRGBO(160, 0, 0, 1),
                const Color.fromRGBO(221, 19, 19, 1),
                const Color.fromRGBO(160, 0, 0, 1),
                const Color.fromRGBO(66, 9, 9, 1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(13.0),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Play',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Pokemon-Solid',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Menu(),
  ));
}
