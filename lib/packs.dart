import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemonapp/usuario.dart';
import 'package:provider/provider.dart';
import 'open_pack.dart';
import 'usuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'usuario_provider.dart'; // Importa el UsuarioProvider

class Packs extends StatefulWidget {
  @override
  _PacksState createState() => _PacksState();
}

class _PacksState extends State<Packs> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
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
          _labels(context),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom:
                0, // Ajuste para ocupar todo el espacio menos el área de los labels
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                _pokestoreContent(),
                _myPacksContent(),
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
      top: MediaQuery.of(context).size.height *
          0.12, // 10% del alto de la pantalla
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
                "POKESTORE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth *
                      0.05, // Tamaño de fuente relativo al ancho de la pantalla
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
                "MY PACKS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth *
                      0.05, // Tamaño de fuente relativo al ancho de la pantalla
                  fontFamily: 'sarpanch',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pokestoreContent() {
    final List<PackData> packData = [
      PackData(
        title: 'SOBRES PREMIUM',
        images: ['assets/sobrepremium.png', 'assets/sobrepremium.png'],
        prices: ['550', '1000'],
      ),
      PackData(
        title: 'SOBRES',
        images: ['assets/sobre.png', 'assets/sobre.png'],
        prices: ['1000', '1600'],
      ),
      PackData(
        title: 'MONEDAS',
        images: ['assets/buy.png', 'assets/buy.png'],
        prices: ['4.99€', '9.99€'],
      ),
      PackData(
        title: 'MONEDAS PREMIUM',
        images: ['assets/buyPremium.png', 'assets/buyPremium.png'],
        prices: ['4.99€', '9.99€'],
      ),
    ];

    return ListView.builder(
      itemCount: packData.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            _banderaImage(packData[index].title, 11, 80),
            SizedBox(height: 20),
            _buildImageWithTextRows(packData[index]),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildImageWithTextRows(PackData packData) {
    List<Widget> rows = [];
    for (int i = 0; i < packData.prices.length; i += 2) {
      Widget row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _imageWithText(packData.images[0], packData.prices[i]),
          SizedBox(width: 20),
          if (i + 1 < packData.prices.length)
            _imageWithText(packData.images[1], packData.prices[i + 1]),
        ],
      );
      rows.add(row);
    }
    return Column(children: rows);
  }

  Widget _banderaImage(String text, double top, double left) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/bandera.png',
          width: 362,
          fit: BoxFit.contain,
        ),
        Positioned(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'sarpanch',
            ),
            textAlign: TextAlign.center, // Alineación central del texto
          ),
          top: top,
          left: left,
          right: left, // Ajuste para centrar horizontalmente
        ),
      ],
    );
  }

  Widget _imageWithText(String imagePath, String text) {
    return GestureDetector(
      onTap: () {
        _showPopUp(context);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 170,
            fit: BoxFit.contain,
          ),
          Positioned(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'sarpanch',
              ),
            ),
            top: 110,
            left: 63,
          ),
        ],
      ),
    );
  }

  Future<void> _showPopUp(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: Container(
            width: 300.0, // Ancho del contenedor
            height: 200.0, // Alto del contenedor
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(20.0), // Agrega bordes redondeados
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(178, 168, 168, 1),
                  const Color.fromRGBO(255, 255, 255, 1)
                ], // Define el degradado de blanco a gris
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.all(20.0), // Ajusta el relleno del contenedor
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Pop Up ejemplo',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Este es un Pop Up simple.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double
                      .infinity, // Ancho del contenedor igual al del AlertDialog
                  height: 50.0, // Altura del contenedor
                  color: Colors.grey, // Color del contenedor gris
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cerrar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Establece un tamaño específico para el AlertDialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          // Ajusta el tamaño del AlertDialog
          contentPadding: EdgeInsets.zero,
        );
      },
    );
  }

  Widget _myPacksContent() {
    final usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);
    final usuario = usuarioProvider.usuario;
    int idUsuario = usuario?.idUsuario ?? 0;

    return FutureBuilder<int>(
      future: obtenerSobresUsuario(idUsuario),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int mypacks = snapshot.data ?? 0;
          List<Widget> images = _generateImagesList(mypacks);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                // Centrar la bandera
                Center(child: _banderaImage("MIS SOBRES", 11, 80)),
                // Mostrar las imágenes en dos columnas
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: images.map((image) {
                      return GestureDetector(
                        onTap: () {
                          mypacks -= 1;
                          _restarSobre(idUsuario);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => open_pack()),
                          );
                        },
                        child: image,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(); // Devuelve un contenedor vacío mientras se espera la respuesta
        }
      },
    );
  }

  Future<int> obtenerSobresUsuario(int idUsuario) async {
    final url = 'http://20.162.113.208:5000/api/usuario/$idUsuario';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // La solicitud fue exitosa, parsea la respuesta JSON
        final Map<String, dynamic> data = json.decode(response.body);
        final int sobres = data['sobres'] as int;
        return sobres;
      } else {
        // La solicitud no fue exitosa, maneja el error según sea necesario
        print(
            'Error al obtener los sobres. Código de estado: ${response.statusCode}');
        return -1; // Retornar un valor por defecto o manejar el error de otra manera
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      return -1;
    }
  }

  Future<void> _restarSobre(int idUsuario) async {
    final url =
        'http://20.162.113.208:5000/api/usuario/restar_sobres/$idUsuario';

    try {
      final response = await http.post(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes manejar la respuesta aquí si es necesario
        final Map<String, dynamic> data = json.decode(response.body);
        print('Sobres restados exitosamente. Nuevo estado de sobres:');
        print('ID de usuario: ${data['id_usuario']}');
        print('Nombre de usuario: ${data['nombre_usuario']}');
        print('Sobres: ${data['sobres']}');
        // Puedes imprimir o utilizar otros campos de la respuesta según tus necesidades
      } else {
        // La solicitud no fue exitosa, maneja el error según sea necesario
        print(
            'Error al restar sobres. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      // Error al realizar la solicitud, maneja el error según sea necesario
      print('Error en la solicitud: $e');
    }
  }

  List<Widget> _generateImagesList(int number) {
    List<Widget> images = [];
    // Aquí agregamos todas las imágenes que queremos mostrar inicialmente
    for (int i = 0; i < number; i++) {
      images.add(
        Image.asset("assets/mypacks.png"),
      );
    }
    return images;
  }
}

class PackData {
  final String title;
  final List<String> images;
  final List<String> prices;

  PackData({
    required this.title,
    required this.images,
    required this.prices,
  });
}

void main() {
  runApp(MaterialApp(
    home: Packs(),
  ));
}
