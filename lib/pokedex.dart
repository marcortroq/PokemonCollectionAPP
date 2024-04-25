import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  int inicio =1;

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
            child: Stack(
              children: [
                Image.asset(
                  'assets/barramoneda.png',
                  width: screenSize.width * 0.5,
                  height: screenSize.height * 0.13,
                ),
                Positioned(
                  top: 43,
                  left: 92,
                  child: FutureBuilder<int>(
                    future: obtenerNumeroMonedas(context), // Llama a la función asíncrona aquí
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Muestra un indicador de carga mientras espera
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Muestra un mensaje de error si algo sale mal
                      } else {
                        // Aquí puedes devolver el Text widget con el valor obtenido
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),           
          Positioned(
            top: screenSize.height * 0.005, 
            left: (screenSize.width - -80) / 2, 
            child: Stack(
              children: [
                Image.asset(
                  'assets/barrapremium.png',
                  width: screenSize.width * 0.5,
                  height: screenSize.height * 0.13,
                ),
                Positioned(
                  top: 43,
                  left: 92,
                  child: FutureBuilder<int>(
                    future: obtenerNumeroMonedasPremium(context), // Llama a la función asíncrona aquí
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Muestra un indicador de carga mientras espera
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Muestra un mensaje de error si algo sale mal
                      } else {
                        // Aquí puedes devolver el Text widget con el valor obtenido
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
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

Future<int> obtenerNumeroMonedas(BuildContext context) async {
  final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
  final usuario = usuarioProvider.usuario;
  int idUsuario = usuario?.idUsuario ?? 0;

  try {
    Map<String, dynamic> data = await fetchUserCoins(idUsuario);
    int monedasNormales = data['monedas'] ?? 0;
    return monedasNormales;
  } catch (error) {
    print(error);
    return 0; // o lanzar una excepción, dependiendo del caso
  }
}

Future<int> obtenerNumeroMonedasPremium(BuildContext context) async {
  final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
  final usuario = usuarioProvider.usuario;
  int idUsuario = usuario?.idUsuario ?? 0;

  try {
    Map<String, dynamic> data = await fetchUserCoins(idUsuario);
    int monedasEspeciales = data['cantidad_pokecoins'] ?? 0;
    return monedasEspeciales;
  } catch (error) {
    print(error);
    return 0; // o lanzar una excepción, dependiendo del caso
  }
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
                    _showPopUp(context, imageUrl,duplicatesCount);

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




Future<Map<String, dynamic>> fetchUserCoins(int userId) async {
    final response = await http.get(
        Uri.parse('http://20.162.113.208:5000/api/tienda/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user coins');
    }
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

  Future<void> _showPopUp(BuildContext context, String imageUrl, int duplicatesCount) async {
  int currentCount = 1; // Inicialmente, siempre mostrará 1

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              width: 300.0,
              height: 430.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(178, 168, 168, 1),
                    const Color.fromRGBO(255, 255, 255, 1),
                    const Color.fromRGBO(255, 255, 255, 1),
                  ],
                  stops: [0.0, 0.4, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(29, 30, 29, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(29, 30, 29, 1),
                          width: 1.0,
                        ),
                      ),
                    ),
                    height: 60,
                    child: Center(
                      child: Text(
                        'SELL DUPLICATE',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 173, 172, 172),
                          fontSize: 24.0,
                          fontFamily: 'sarpanch',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    height: 280,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          const Color.fromRGBO(208, 56, 56, 1),
                          const Color.fromRGBO(255, 91, 91, 1),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[                      
                        SizedBox(
                          height: 200,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'x$currentCount', // Siempre mostrará el valor actual del contador
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontFamily: 'sarpanch',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    width: 260,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              // Acción al presionar el botón de resta
                              if (currentCount > 1) {
                                setState(() {
                                  currentCount--; // Reducir solo si no hemos alcanzado el mínimo
                                });
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(Size(40, 40)),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Icon(Icons.remove),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 150,
                          child: TextButton(
                            onPressed: () {
                              // Acción al presionar el botón
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/monedaPremium.png'),
                                SizedBox(width: 5.0),
                                Text(
                                  '1000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'sarpanch',
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Image.asset('assets/monedaPremium.png'),
                              ],
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(29, 30, 29, 1),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              // Acción al presionar el botón de suma
                              if (currentCount < duplicatesCount) {
                                setState(() {
                                  currentCount++; // Incrementar solo si no hemos alcanzado el máximo
                                });
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(Size(40, 40)),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: EdgeInsets.zero,
          );
        },
      );
    },
  );
}
}