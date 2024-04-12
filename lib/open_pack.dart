import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemonapp/menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(MaterialApp(
    home: open_pack(),
  ));
}

class open_pack extends StatefulWidget {
  const open_pack({Key? key}) : super(key: key);

  @override
  State<open_pack> createState() => _StateOpenPack();
}

class _StateOpenPack extends State<open_pack> {
  bool showImages = false;
  int clickedImages = 0;
  int totalImages = 4; // Cambia esto al número total de imágenes que tienes

  List<bool> imageStates = [false, false, false, false];
  List<bool> imageTapped = [false, false, false, false]; // Lista para rastrear si una imagen ha sido tocada

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return GestureDetector(
      onTap: () {
        if (showImages && imageStates.every((state) => state)) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Menu()), // Reemplaza 'NewScreen()' con la pantalla que desees mostrar
          );
        }
        setState(() {
          showImages = true; // Al hacer clic, mostrar las imágenes
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            if (!showImages) _buildIncubadora('assets/incubadora1.png', 275, screenWidth),
            if (showImages)_buildIncubadora2('assets/incubadora1.png', 275, screenWidth,0.5),            
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 0.45, 0.5, 'Mensaje 1', 0),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 1.05, 0.5, 'Mensaje 2', 1),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 0.65, 1.5, 'Mensaje 3', 2),
            if (showImages)
              _buildItem('assets/PortadaColor.png', 175, screenWidth, 1.25, 1.5, 'Mensaje 4', 3),
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

  Widget _buildIncubadora2(String imagePath, double size, double screenWidth, double opacity) {
  return Positioned(
    top: screenWidth * 0.7,
    left: (screenWidth * 1 - size) / 2,
    child: Opacity(
      opacity: opacity,
      child: Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    ),
  );
}


  Widget _buildItem(String imagePath, double size, double screenWidth, double top, double left, String message, int index) {
    return Positioned(
      top: screenWidth * top,
      left: (screenWidth * left - size) / 2,
      child: GestureDetector(
        onTap: () {
          if (!imageTapped[index]) {
            setState(() {
               _showCenteredImage(context, imagePath, index);
              // Cambia el estado de la imagen en la posición 'index' para mostrar una nueva imagen
              imageStates[index] = !imageStates[index];
              imageTapped[index] = true; // Marca la imagen como tocada
            });
          } else {
            _showCenteredImage(context, imagePath, index);
          }
        },
        child: Transform.rotate(
          angle: imageStates[index] ? 0 : 0, // Girar la imagen si está tocada
          child: Image.asset(
            // Utiliza el estado correspondiente para mostrar la imagen correcta
            imageStates[index] ? 'assets/pack.png' : imagePath,
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  // Método para mostrar la imagen centrada y aumentada
  void _showCenteredImage(BuildContext context, String imagePath, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SizedBox(
            width: 250,
            height: 500,
            child: Image.asset(
              imageStates[index] ? 'assets/pack.png' : imagePath, // Usa 'assets/pack.png' cuando se amplíe
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    },
  );
}

  }

