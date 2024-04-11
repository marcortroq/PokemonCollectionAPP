import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importante: Importa esto para acceder a SystemChrome

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Oculta la barra de navegación al iniciar la aplicación
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(MaterialApp(
    home: Incubadora(),
  ));
}

class Incubadora extends StatefulWidget {
  const Incubadora({Key? key}) : super(key: key);

  @override
  State<Incubadora> createState() => _StateIncubadora();
}

class _StateIncubadora extends State<Incubadora> {
    

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            _buildIncubadora('assets/incubadora1.png', 250, screenWidth),
            _buildCarta1('assets/PortadaColor.png', 250, screenWidth)
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/fondoNormal.png"), // Aquí cambia la ruta a la ubicación de tu imagen
          fit: BoxFit.cover,
        ),
      ),      
    );
  }

  Widget _buildIncubadora(String imagePath, double size, double screenWidth) {
  return Positioned(
    top: screenWidth * 0.7, // Ajusta la posición vertical de la imagen
    left: (screenWidth * 1 - size) / 2, // Centra la imagen horizontalmente
    child: Image.asset(
      imagePath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    ),
  );
}

   Widget _buildCarta1(String imagePath, double size, double screenWidth) {
  return Positioned(
    top: screenWidth * 0.7, // Ajusta la posición vertical de la imagen
    left: (screenWidth * 1 - size) / 2, // Centra la imagen horizontalmente
    child: Image.asset(
      imagePath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    ),
  );
}

}
