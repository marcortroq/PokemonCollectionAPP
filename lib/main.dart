import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokemonAPP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Ocultar el teclado cuando se toca en cualquier lugar que no sea un campo de texto
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          _isKeyboardVisible = false;
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            _buildImage('assets/Charizard.png', 400),
            CustomPaint(
              size: Size.infinite,
              painter: RectanguloPainter(isKeyboardVisible: _isKeyboardVisible),
            ),
            CustomPaint(
              size: Size.infinite,
              painter: TrianglePainter(isKeyboardVisible: _isKeyboardVisible),
            ),
            _buildLoginForm(),
            AnimatedOpacity(
              opacity: _isKeyboardVisible ? 0.0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: Center(
                child: _buildTitulo('assets/title.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromRGBO(255, 22, 22, 1), Colors.black],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Positioned(
      left: 50,
      bottom: 70,
      child: Column(
        children: [
          SizedBox(height: 30),
          _buildTextField('Email Address / Username'),
          SizedBox(height: 20),
          _buildTextField('Password'),
          SizedBox(height: 38),
          _buildSignInButton(),
          SizedBox(height: 7),
          _buildSignUpText(),
        ],
      ),
    );
  }

  Widget _buildImage(String imagePath, double size) {
    return Positioned(
      top: -30,
      bottom: size == 200 ? 60 : 240,
      child: Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTitulo(String imagePath) {
    return Positioned(
      left: 0,
      top: -150,
      right: 0,
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTextField(String labelText) {
    return SizedBox(
      width: 305,
      height: 52,
      child: TextField(
        onTap: () {
          setState(() {
            _isKeyboardVisible = true;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: 305,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // Acción a realizar al presionar el botón
        },
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
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'RubikOne',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpText() {
    return RichText(
      text: TextSpan(
        text: "I’m a new user. ",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Roboto',
        ),
        children: [
          TextSpan(
            text: "Sign Up",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final bool isKeyboardVisible;

  TrianglePainter({required this.isKeyboardVisible});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    if (isKeyboardVisible) {
      path_0.moveTo(size.width * 0, size.height * 0.42);
    } else {
      path_0.moveTo(size.width * 0, size.height * 0.59500);
    }
    path_0.lineTo(size.width * 1, size.height * 0.3);
    path_0.lineTo(size.width * 1, size.height * 3);
    path_0.lineTo(size.width * 0, size.height * 3);

    canvas.drawPath(path_0, paint_fill_0);

    Paint paint_stroke_0 = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(179, 179, 179, 1), // Rojo
          Color.fromARGB(255, 255, 255, 255), // Verde
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    canvas.drawPath(path_0, paint_stroke_0); // Dibujar con el degradado
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RectanguloPainter extends CustomPainter {
  final bool isKeyboardVisible;

  RectanguloPainter({required this.isKeyboardVisible});

//hola que tal
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_fill_0 = Paint()
      ..color = Color.fromRGBO(29, 30, 29, 1)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    if (isKeyboardVisible) {
      path_0.moveTo(size.width * 0, size.height * 0.39500);
    } else {
      path_0.moveTo(size.width * 0, size.height * 0.57000);
    }
    path_0.lineTo(size.width * 1, size.height * 0.275);
    path_0.lineTo(size.width * 1, size.height * 0.305);
    path_0.lineTo(size.width * 0, size.height * 0.6);

    canvas.drawPath(path_0, paint_fill_0);

    Paint paint_stroke_0 = Paint()
      ..color = Color.fromRGBO(29, 30, 29, 1)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0); // Dibujar con el degradado
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
