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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _moverFondo(){
    print("Hola");
    setState(() {
      // Cambiar el color del contenedor
      _primerContainerColor = Colors.white;
      _segundoContainerColor= const Color.fromRGBO(136, 136, 136, 1); // Cambia a cualquier color que desees
    });
  }
  Color _primerContainerColor = const Color.fromRGBO(255, 22, 22, 1);
  Color _segundoContainerColor =  Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            key: Key('primer_container'),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_primerContainerColor, _segundoContainerColor],                
              ),
            ),
          ),
          Positioned(
            left: 0, // Ajusta la posición izquierda según lo necesites
            top: 60, // Ajusta la posición superior según lo necesites
            child: Image.asset(
              'assets/Charizard.png', // Ruta de la imagen
              width: 420, // Ancho de la imagen
              height: 420, // Alto de la imagen
              fit: BoxFit
                  .contain, // Ajusta el tamaño de la imagen según el contenedor
            ),
          ),
          Positioned(
            left: 70, // Ajusta la posición izquierda según lo necesites
            top: 7, // Ajusta la posición superior según lo necesites
            child: Transform.rotate(
              angle: 58 * 3.14 / 180, // Convierte grados a radianes
              child: Container(
                width: 22, // Ancho del rectángulo
                height: 900, // Alto del rectángulo
                color: Color.fromRGBO(29, 30, 29, 1), // Color del rectángulo
              ),
            ),
          ),
          CustomPaint(
            size: Size.infinite,
            painter: TrianglePainter(),
          ),
          Positioned(
            left: 0, // Ajusta la posición izquierda según lo necesites
            top: 220, // Ajusta la posición superior según lo necesites
            child: Image.asset(
              'assets/title.png', // Ruta de la segunda imagen
              width: 400, // Ancho de la segunda imagen
              height: 400, // Alto de la segunda imagen
              fit: BoxFit
                  .contain, // Ajusta el tamaño de la imagen según el contenedor
            ),
          ),
          Positioned(
            left: 50, // Ajusta la posición izquierda según lo necesites
            bottom: 50, // Ajusta la posición inferior según lo necesites
            child: Column(
              children: [
                SizedBox(
                  width: 305,
                  height: 52, // Ancho del TextField
                  child: TextField(
                    onTap: _moverFondo,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(13.0), // Bordes redondeados
                      ),
                      filled: true, // Habilitar el relleno
                      fillColor: Colors.white, // Color de fondo
                      labelText: 'Email Address / Username',
                    ),
                  ),
                ),
                SizedBox(height: 20), // Espacio entre los TextField
                SizedBox(
                  width: 305,
                  height: 52, // Ancho del TextField
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(13.0), // Bordes redondeados
                      ),
                      filled: true, // Habilitar el relleno
                      fillColor: Colors.white,
                      
                      focusedBorder: OutlineInputBorder(                        
                        borderSide: BorderSide(                          
                            color: Colors.black,
                            width: 2), // Borde oscuro cuando está seleccionado
                        borderRadius:
                            BorderRadius.circular(13.0), // Bordes redondeados
                      ), // Color de fondo
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: 48), // Espacio entre los TextField
                SizedBox(
                  width: 305,
                  height: 52, // Alto del botón
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción a realizar al presionar el botón
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(13.0), // Bordes redondeados
                      ),
                      padding: EdgeInsets.zero,
                      elevation: 0,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromRGBO(66, 9, 9,
                                1), // Color oscuro en el lado izquierdo
                            const Color.fromRGBO(160, 0, 0,
                                1), // Color más claro en el lado izquierdo
                            const Color.fromRGBO(
                                221, 19, 19, 1), // Color rojo en el centro
                            const Color.fromRGBO(160, 0, 0,
                                1), // Color más claro en el lado derecho
                            const Color.fromRGBO(
                                66, 9, 9, 1), // Color oscuro en el lado derecho
                          ],
                          begin: Alignment
                              .centerLeft, // Comienza en el centro-izquierda
                          end: Alignment
                              .centerRight, // Termina en el centro-derecha
                        ),
                        borderRadius:
                            BorderRadius.circular(13.0), // Bordes redondeados
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white, // Color del texto del botón
                            fontSize: 20, // Tamaño de la fuente
                            fontFamily: 'RubikOne', // Familia de la fuente
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 7), // Espacio entre el botón y el texto
                RichText(
                  text: TextSpan(
                    text: "I’m a new user. ",
                    style: TextStyle(
                      color: Colors.black, // Color del texto principal (negro)
                      fontSize: 18, // Tamaño de la fuente
                      fontFamily: 'Roboto', // Familia de la fuente
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: Colors.red, // Color de "Sign Up" (rojo)
                          fontWeight: FontWeight.bold,
                          fontFamily:
                              'Roboto', // Opcional: negrita para enfatizar
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();
    path.moveTo(-560, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 260);
    path.close();
    paint.shader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color.fromRGBO(136, 136, 136, 1),
        const Color.fromRGBO(136, 136, 136, 1),
        Colors.white,
        Colors.white,
      ],
      stops: [0.2, 0.2, 0.9, 1.0],
    ).createShader(path.getBounds());
    paint.style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
