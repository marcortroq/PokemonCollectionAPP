import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemonapp/bar.dart';
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
  int _currentIndex = 0;

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
          Positioned(
            left: 0,
            right: 0,
            top: 20,
            child: CustomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
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
        title: 'PREMIUM PACKS',
        images: ['assets/sobrepremium.png', 'assets/sobrepremium.png'],
        prices: ['550', '1000'],
      ),
      PackData(
        title: 'BASICS PACKS',
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
        String moneda = '';
        String pack = '';
        if (imagePath == 'assets/sobrepremium.png') {
          moneda = 'assets/monedaPremium.png';
          pack = "PREMIUM PACK";
        } else {
          moneda = 'assets/moneda.png';
          pack = "BASIC PACK";
        }
        _showPopUp(context, text, moneda, pack);
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

  Future<void> _showPopUp(
      BuildContext context, String numero, String moneda, String pack) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            width: 300.0,
            height: 230.0, // Ajusta la altura total del AlertDialog
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
                      pack,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontFamily: 'sarpanch',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  height: 80,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // Bordes redondeados
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color.fromRGBO(208, 56, 56, 1), // Color inicial
                        const Color.fromRGBO(255, 91, 91, 1), // Color final
                      ],
                    ),
                    border: Border.all(
                        color: Colors.black, width: 1.0), // Borde negro
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Contains:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'sarpanch',
                          ),
                        ),
                        SizedBox(width: 5.0),
                        SizedBox(
                          height: 60,
                          child: Image.asset(
                            'assets/PortadaColor.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'x4',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontFamily: 'sarpanch',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0), // Espacio adicional si es necesario
                Container(
                  width: 150,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => open_pack()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(moneda),
                        SizedBox(width: 5.0),
                        Text(
                          numero,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'sarpanch',
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Image.asset(moneda),
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
              ],
            ),
          ),
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