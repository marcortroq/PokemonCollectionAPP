import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemonapp/usuario.dart';
import 'open_pack.dart';
import 'usuario.dart';

class Packs extends StatefulWidget {
  @override
  _PacksState createState() => _PacksState();
}

class _PacksState extends State<Packs> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  Usuario user = Usuario(
      idUsuario: 1,
      nombreUsuario: 'marcortroq',
      mail: 'marcortroq',
      contrasena: 'contrasena',
      admin: 1,
      sobres: 7);

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
                _myPacksContent(user),
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
        images: ['assets/buy.png', 'assets/buy.png'],
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
    return Stack(
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
    );
  }

  Widget _myPacksContent(Usuario usuario) {
    int mypacks = usuario.sobres;
    List<Widget> images = _generateImagesList(
        mypacks); // Inicialmente mostramos todas las imágenes

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          // Centrar la bandera
          Center(child: _banderaImage("MIS SOBRES", 11, 80)),
          // Mostrar las imágenes en dos columnas
          Padding(
            padding: EdgeInsets.only(top: 0.0), // Eliminar el espacio superior
            child: GridView.count(
              crossAxisCount: 2, // Dos columnas
              crossAxisSpacing: 10.0, // Espacio entre columnas
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // Deshabilitar el scroll del GridView
              children: images.map((image) {
                return GestureDetector(
                  onTap: () {
                    usuario.sobres -= 1;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OpenPack()),
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
