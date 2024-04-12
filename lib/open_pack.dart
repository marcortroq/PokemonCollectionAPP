import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(MaterialApp(
    home: OpenPack(),
  ));
}

class OpenPack extends StatefulWidget {
  const OpenPack({Key? key}) : super(key: key);

  @override
  State<OpenPack> createState() => _StateOpenPack();
}

class _StateOpenPack extends State<OpenPack> {
  bool showImages = false;
  int clickedImages = 0;
  int totalImages = 4; // Cambia esto al número total de imágenes que tienes

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
            if (!showImages)
              _buildIncubadora('assets/pack.png', 275, screenWidth),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 0.45, 0.5,
                  'Mensaje 1'),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 1.05, 0.5,
                  'Mensaje 2'),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 0.65, 1.5,
                  'Mensaje 3'),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 1.25, 1.5,
                  'Mensaje 4'),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/fondoPack.png"),
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

  Widget _buildItem(String imagePath, double size, double screenWidth,
      double top, double left, String message) {
    return Positioned(
      top: screenWidth * top,
      left: (screenWidth * left - size) / 2,
      child: GestureDetector(
        onTap: () {
          setState(() {
            clickedImages++; // Incrementa el contador cuando se hace clic en una imagen
          });

          print(message);

          if (clickedImages >= totalImages) {
            // Si todas las imágenes han sido clicadas, muestra el mensaje final
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Todas las cartas han sido clicadas'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cerrar'),
                    ),
                  ],
                );
              },
            );
          }
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
