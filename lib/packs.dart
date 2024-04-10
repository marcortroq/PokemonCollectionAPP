import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Packs extends StatefulWidget {
  @override
  _PacksState createState() => _PacksState();
}

class _PacksState extends State<Packs> {
  bool _isCollectionSelected = true;

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
                fit: BoxFit.cover,
              ),
            ),
          ),
          _labels(context),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child:
                _isCollectionSelected ? _pokestoreContent() : _myPacksContent(),
          ),
        ],
      ),
    );
  }

  Widget _labels(BuildContext context) {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isCollectionSelected = true;
              });
            },
            child: Container(
              padding: EdgeInsets.only(
                bottom: 2,
              ),
              decoration: BoxDecoration(
                border: _isCollectionSelected
                    ? Border(
                        bottom: BorderSide(width: 2.0, color: Colors.white),
                      )
                    : null,
              ),
              child: Text(
                "POKESTORE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'sarpanch',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isCollectionSelected = false;
              });
            },
            child: Container(
              padding: EdgeInsets.only(
                bottom: 2,
              ),
              decoration: BoxDecoration(
                border: !_isCollectionSelected
                    ? Border(
                        bottom: BorderSide(width: 2.0, color: Colors.white),
                      )
                    : null,
              ),
              child: Text(
                "MY PACKS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
    return Column(
      children: [
        Text(
          'Contenido de POKESTORE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'sarpanch',
          ),
        ),
        SizedBox(height: 20), // Espacio entre el texto y la imagen
        Image.asset(
          'assets/bandera.png', // Ruta de la imagen en tus assets
          width: 200, // Ancho deseado de la imagen
          height: 200, // Alto deseado de la imagen
          fit: BoxFit.contain, // Ajuste de la imagen dentro del contenedor
        ),
        // Aquí puedes agregar más widgets que quieres mostrar cuando se selecciona "POKESTORE"
      ],
    );
  }

  Widget _myPacksContent() {
    return Column(
      children: [
        Text(
          'Contenido de MY PACKS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'sarpanch',
          ),
        ),
        // Aquí puedes agregar más widgets que quieres mostrar cuando se selecciona "MY PACKS"
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Packs(),
  ));
}
