import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:pokemonapp/register.dart';
import 'menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _counter = 0;
  bool _isKeyboardVisible = false;
  bool _isObscure = true;
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
            /*AnimatedOpacity(
              opacity: _isKeyboardVisible ? 0.0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: Center(
                child: _buildTitulo('assets/title.png'),
              ),
            ),*/
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: _isKeyboardVisible
                  ? SizedBox.shrink()
                  : Center(
                      key: Key('center_key'),
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
          _buildTextField('Email Address / Username', _usernameController),
          SizedBox(height: 20),
          _buildTextFieldContrasena('Password', _passwordController,
              obscureText: _isObscure),
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
          suffixIcon:
              obscureText // Aquí se cambia el icono en función de la visibilidad del texto
                  ? IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.visibility_off),
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

  Widget _buildSignInButton() {
    return SizedBox(
      width: 305,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          _signIn();
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
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navegar a la nueva ventana
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
          ),
        ],
      ),
    );
  }

  void _signIn() async {
    String NOMBRE_USUARIO = _usernameController.text;
    String CONTRASENA = _passwordController.text;

    if (NOMBRE_USUARIO.isNotEmpty && CONTRASENA.isNotEmpty) {
      var response = await http.get(
        Uri.parse('http://51.141.92.127:5000/usuario/$NOMBRE_USUARIO'),
      );

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        String contrasenaServidor = userData['Usuario']['CONTRASENA'];

        if (CONTRASENA == contrasenaServidor) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Menu()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid username or password.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Failed to fetch user data.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in both username and password fields.'),
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
