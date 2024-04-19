import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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
  int totalImages = 4; // Cambia esto al número total de imágenes que tienes

  List<String> cardImages = []; // Lista para almacenar las URLs de las imágenes de cartas

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return GestureDetector(
      onTap: () {
        if (!showImages) {
          _handleIncubadoraTap();
        }
      }, // Llama a la función para manejar el tap solo si las imágenes no están mostradas
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            _buildPortadaColor('assets/PortadaColor.png', 275, screenWidth),
            if (showImages)
              _buildCardImages(screenWidth),
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

  Widget _buildPortadaColor(String imagePath, double size, double screenWidth) {
    return Positioned(
      top: screenWidth * 0.7,
      left: (screenWidth * 1 - size) / 2,
      child: GestureDetector(
        onTap: () {
          if (!showImages) {
            _handleIncubadoraTap();
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

  Widget _buildCardImages(double screenWidth) {
    return Stack(
      children: [
        for (int i = 0; i < totalImages; i++)
          Positioned(
            top: _getImageTopPosition(i, screenWidth),
            left: _getImageLeftPosition(i, screenWidth),
            child: _buildCardImage(i),
          ),
      ],
    );
  }

  double _getImageTopPosition(int index, double screenWidth) {
    // Define la posición vertical de cada imagen basada en su índice
    switch (index) {
      case 0:
        return screenWidth * 1.25; // Ajusta estas posiciones según tu preferencia
      case 1:
        return screenWidth * 0.5;
      case 2:
        return screenWidth * 0.3;
      case 3:
        return screenWidth * 1.05;
      default:
        return 0;
    }
  }

  double _getImageLeftPosition(int index, double screenWidth) {
    // Define la posición horizontal de cada imagen basada en su índice
    switch (index) {
      case 0:
        return screenWidth * 0.6; // Ajusta estas posiciones según tu preferencia
      case 1:
        return screenWidth * 0.6;
      case 2:
        return screenWidth * 0.035;
      case 3:
        return screenWidth * 0.035;
      default:
        return 0;
    }
  }

  void _handleIncubadoraTap() async {
    if (!showImages) {
      // Cargar las imágenes de las cartas
      try {
        for (int i = 0; i < totalImages; i++) {
          final imageUrl = await fetchRandomCardImage();
          final completeUrl = 'http://20.162.113.208$imageUrl'; // Agregar la dirección base a la URL de la imagen
          cardImages.add(completeUrl);
        }
        setState(() {
          showImages = true; // Mostrar las imágenes cargadas
        });
      } catch (e) {
        print("Error al cargar las imágenes de las cartas: $e");
      }
    }
  }

  Future<String> fetchRandomCardImage() async {
    final random = Random();
    final pokemonId = random.nextInt(151) + 1;
    final response = await http.get(Uri.parse('http://20.162.113.208:5000/api/cartas/$pokemonId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final fotoCarta = jsonData['foto_carta'];

      if (fotoCarta != null) {
        return fotoCarta;
      } else {
        throw Exception('La imagen de la carta no está disponible');
      }
    } else {
      throw Exception('Fallo al cargar la imagen de la carta: ${response.statusCode}');
    }
  }

  Widget _buildCardImage(int index) {
    if (index < cardImages.length) {
      return GestureDetector(
        onTap: () {
          _showCenteredImage(context, cardImages[index]);
        },
        child: Image.network(cardImages[index], height: 195),
      );
    } else {
      return SizedBox(height: 400); // Placeholder si no hay suficientes imágenes
    }
  }

  // Método para mostrar la imagen centrada y aumentada
  void _showCenteredImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              height: 400,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
