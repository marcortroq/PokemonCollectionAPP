import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemonapp/menu.dart';
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
    
    String baseUrl = 'http://20.162.113.208/FOTOS_CARTAS/091.png'; // Reemplaza 'http://example.com' con la URL base de tu servidor
    String imageUrl = baseUrl ;
    return Positioned(
      
      top: screenWidth * top,
      left: (screenWidth * left - size) / 2,
      child: GestureDetector(
        onTap: () {
          if (!imageTapped[index]) {
            setState(() {
               _showCenteredImage(context, index);
              // Cambia el estado de la imagen en la posición 'index' para mostrar una nueva imagen
              imageStates[index] = !imageStates[index];
              imageTapped[index] = true; // Marca la imagen como tocada
            });
          } else {
            _showCenteredImage(context, index);
          }
        },
        child: Transform.rotate(
          angle: imageStates[index] ? 0 : 0, // Girar la imagen si está tocada
          child: Image.network(
            // Utiliza el estado correspondiente para mostrar la imagen correcta
            imageUrl,
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  // Método para mostrar la imagen centrada y aumentada
 void _showCenteredImage(BuildContext context, int index) {
  fetchRandomCardImage().then((imagePath) {
    if (imagePath != null) {
      String baseUrl = 'http://20.162.113.208'; // Reemplaza 'http://example.com' con la URL base de tu servidor
      String imageUrl = baseUrl + imagePath;

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
    } else {
      // Manejar el caso en el que no se pudo obtener la imagen de la base de datos
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo obtener la imagen de la base de datos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }).catchError((error) {
    // Manejar cualquier error que pueda ocurrir al llamar a fetchRandomCardImage()
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Ocurrió un error al obtener la imagen de la base de datos: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  });
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


