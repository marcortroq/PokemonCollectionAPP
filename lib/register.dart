import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemonapp/main.dart';
import 'menu.dart';

void main() {
  runApp(const Register());
}

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _RpasswordController = TextEditingController();
  bool _isKeyboardVisible = false;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          _isKeyboardVisible = false;
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            _buildImage('assets/meowth.png', 400),
            CustomPaint(
              size: Size.infinite,
              painter: RectanguloPainter(isKeyboardVisible: _isKeyboardVisible),
            ),
            CustomPaint(
              size: Size.infinite,
              painter: TrianglePainter(isKeyboardVisible: _isKeyboardVisible),
            ),
            _buildLoginForm(),
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
      bottom: 50,
      child: Column(
        children: [
          SizedBox(height: 100),
          _buildTextField('Email Address', _emailController),
          SizedBox(height: 20),
          _buildTextField('Username', _usernameController),
          SizedBox(height: 20),
          _buildTextFieldContrasena('Password', _passwordController,
              obscureText: _isObscure),
          SizedBox(height: 20),
          _buildTextFieldContrasena('Password', _RpasswordController,
              obscureText: _isObscure),
          SizedBox(height: 30),
          _buildSignInButton(),
          SizedBox(height: 7),
          _buildSignUpText(),
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return SizedBox(
      width: 305,
      height: 52,
      child: TextField(
        controller: controller,
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

  Widget _buildTextFieldContrasena(
      String labelText, TextEditingController controller,
      {bool obscureText = false}) {
    return SizedBox(
      width: 305,
      height: 52,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
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
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
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
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navegar a la nueva ventana
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
          ),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: 305,
      height: 52,
      child: ElevatedButton(
        onPressed: _checkUserExistenceAndRegister,
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
              'Sign Up',
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

  void _checkUserExistenceAndRegister() async {
    String nombreUsuario = _usernameController.text;

    try {
      var response = await http.get(
        Uri.parse('http://51.141.92.127:5000/usuario/$nombreUsuario'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('El usuario ya existe.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        _registerUser();
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al verificar la existencia del usuario.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _registerUser() async {
    try {
      var response = await http.post(
        Uri.parse('http://51.141.92.127:5000/usuario'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nombre_usuario': _usernameController.text,
          'mail': _emailController.text,
          'contrasena': _passwordController.text,
          // Puedes incluir otros campos si es necesario, como 'admin'
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Menu()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Hubo un error en el registro. Por favor, inténtalo de nuevo.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Hubo un error en el registro. Por favor, inténtalo de nuevo.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
      path_0.moveTo(size.width * 1, size.height * 0.345);
    } else {
      path_0.moveTo(size.width * 1, size.height * 0.52);
    }

    path_0.lineTo(size.width * 0, size.height * 0.345);
    path_0.lineTo(size.width * 0, size.height * 3);
    path_0.lineTo(size.width * 1, size.height * 3);

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
      path_0.moveTo(size.width * 1, size.height * 0.32);
    } else {
      path_0.moveTo(size.width * 1, size.height * 0.495);
    }
    path_0.lineTo(size.width * 0, size.height * 0.32);
    path_0.lineTo(size.width * 0, size.height * 0.345);
    path_0.lineTo(size.width * 1, size.height * 0.52);

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
