import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:pokemonapp/usuario.dart';
import 'usuario_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: Pokedex(),
  ));
}

class Pokedex extends StatefulWidget {
  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Aquí podrías inicializar _pokemonIds con las IDs de los Pokémon del usuario
  }

  @override
  Widget build(BuildContext context) {
    late final Size screenSize = MediaQuery.of(context).size;

    // Calcula el tamaño de la imagen del fondo
    double backgroundWidth = screenSize.width * 1.2;
    double backgroundHeight = screenSize.height * 1.2;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/fondosec.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
           Positioned(
            top: screenSize.height * 0.005, 
            left: (screenSize.width - 200) / 2, 
            child: Image.asset(
              'assets/barramoneda.png', // Ruta de tu imagen
              width: screenSize.width * 0.5, 
              height: screenSize.height * 0.13, 
            ),
          ),
          Positioned(
            top: screenSize.height * 0.005, 
            left: (screenSize.width - -80) / 2, 
            child: Image.asset(
              'assets/barrapremium.png', // Ruta de tu imagen
              width: screenSize.width * 0.5, 
              height: screenSize.height * 0.13, 
            ),
          ),
          _labels(context),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                _pokedexContent(),
                _duplicatesContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _labels(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: MediaQuery.of(context).size.height * 0.12,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              _pageController.animateToPage(0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            child: Container(
              padding: EdgeInsets.only(
                bottom: 2,
              ),
              decoration: BoxDecoration(
                border: _currentPageIndex == 0
                    ? Border(
                        bottom: BorderSide(width: 2.0, color: Colors.white),
                      )
                    : null,
              ),
              child: Text(
                "POKEDEX",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontFamily: 'sarpanch',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _pageController.animateToPage(1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            child: Container(
              padding: EdgeInsets.only(
                bottom: 2,
              ),
              decoration: BoxDecoration(
                border: _currentPageIndex == 1
                    ? Border(
                        bottom: BorderSide(width: 2.0, color: Colors.white),
                      )
                    : null,
              ),
              child: Text(
                "DUPLICATES",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontFamily: 'sarpanch',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pokedexContent() {
    final usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);
    final usuario = usuarioProvider.usuario;
    int idUsuario = usuario?.idUsuario ?? 0;

    return FutureBuilder<List<dynamic>>(
      future: fetchUserCards(idUsuario), // Cambia 1 por el ID del usuario
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null) {
          // Agregar verificación de nulidad aquí
          return Center(child: Text('No se encontraron cartas de usuario.'));
        } else {
          List<dynamic> userCards = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemCount: 151, // Mostrar 151 cartas
            itemBuilder: (context, index) {
              bool userHasCard = userHasCardAtIndex(index, userCards);
              String imageUrl;
              if (userHasCard) {
                String baseUrl = 'http://20.162.113.208';
                String imagePath =
                    '/FOTOS_CARTAS/${index + 1}.png'; // La imagen sigue el formato de ID de Pokémon
                imageUrl = baseUrl + imagePath;
              } else {
                // Si el usuario no tiene la carta, cargar la imagen estática desde assets
                imageUrl = 'assets/ContraPortada.png';
              }
              return GestureDetector(
                onTap: () {
                  // Mostrar la imagen centrada y aumentada al hacer clic
                  if (userHasCard) {
                    _showCenteredImage(context, imageUrl);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: userHasCard
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.fitHeight,
                        )
                      : Image.asset(
                          imageUrl,
                          fit: BoxFit.fitHeight,
                        ),
                ),
              );
            },
          );
        }
      },
    );
  }

  bool userHasCardAtIndex(int index, List<dynamic> userCards) {
    // Verificar si el JSON contiene una carta con el ID del Pokémon correspondiente al índice
    bool hasCard = userCards.any((card) => card['id_pokemon'] == index + 1);
    return hasCard;
  }

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




  Widget _duplicatesContent() {
  final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
  final usuario = usuarioProvider.usuario;
  int idUsuario = usuario?.idUsuario ?? 0;

  return FutureBuilder<List<dynamic>>(
    future: fetchDuplicateCards(idUsuario),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (snapshot.data == null) {
        return Center(child: Text('No se encontraron cartas duplicadas.'));
      } else {
        List<dynamic> duplicateCards = snapshot.data!;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          itemCount: duplicateCards.length,
          itemBuilder: (context, index) {
            String imageUrl = duplicateCards[index]['foto_carta'];
            int duplicatesCount = (duplicateCards[index]['cantidad_repetidas'] ?? 0) - 1;

            // Verificar si ya es una URL completa
            if (!imageUrl.startsWith('http')) {
              // Si no es una URL completa, construir la URL completa
              imageUrl = 'http://20.162.113.208$imageUrl';
            }

            return Stack(
              alignment: Alignment.center, // Alineación a la derecha
              children: [
                GestureDetector(
                  onTap: () {
                    _showCenteredImage(context, imageUrl);

                  },
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                if (duplicatesCount > 1) // Mostrar redonda solo si duplicatesCount es mayor que 0
                  Positioned(
                    top: 100,
                    right: 50,
                    child: Container(
                      width: 25,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(244, 67, 54, 0.685),
                      ),
                      child: Align(
            alignment: Alignment.center,
            child: Text(
              duplicatesCount.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 9,
              ),
            ),
                    ),
                  ),
                  )
              ],
            );
          },
        );
      }
    },
  );
}







  Future<List<dynamic>> fetchDuplicateCards(int userId) async {
    final response = await http.get(
        Uri.parse('http://20.162.113.208:5000/api/cartas/usuario/dupes/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load duplicate cards');
    }
  }

  Future<List<dynamic>> fetchUserCards(int userId) async {
    print("PRUEBA PARA SABER SI HACE LA LLAMADA");
    final response = await http.get(
        Uri.parse('http://20.162.113.208:5000/api/cartas/usuario/$userId'));
    print("TIENE RESPUESTA");

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      List<dynamic> userCards = json.decode(response.body);

      while (!json.encode(userCards).contains(']')) {
        await Future.delayed(Duration(
            seconds: 1)); // Esperar un segundo antes de verificar nuevamente
        final updatedResponse = await http.get(
            Uri.parse('http://20.162.113.208:5000/api/cartas/usuario/$userId'));
        print("TIENE RESPUESTA");

        if (updatedResponse.statusCode == 200) {
          print(json.decode(updatedResponse.body));
          userCards = json.decode(updatedResponse.body);
        } else {
          throw Exception('Failed to load user cards');
        }
      }

      return userCards;
    } else {
      throw Exception('Failed to load user cards');
    }
  }
}
