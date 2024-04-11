import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
  bool showImages = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          showImages = true; // Al hacer clic, mostrar las imágenes
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            if (!showImages) _buildIncubadora('assets/incubadora1.png', 275, screenWidth),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 0.45, 0.5, 'Mensaje 1'),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 1.05, 0.5, 'Mensaje 2'),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 0.65, 1.5, 'Mensaje 3'),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 1.25, 1.5, 'Mensaje 4'),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/fondoNormal.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildIncubadora(String imagePath, double size, double screenWidth) {
    return Positioned(
      top: screenWidth * 0.7,
      left: (screenWidth * 1 - size) / 2,
      child: Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildItem(String imagePath, double size, double screenWidth, double top, double left, String message) {
    return Positioned(
      top: screenWidth * top,
      left: (screenWidth * left - size) / 2,
      child: GestureDetector(
        onTap: () {
          print(message);
        },
        child: Image.asset(
          imagePath,
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
