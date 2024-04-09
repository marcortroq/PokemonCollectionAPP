import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Pokedex extends StatefulWidget {
  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  bool _isCollectionSelected = true;
  List<String> _pokemonCards = [];

  @override
  void initState() {
    super.initState();
    _mostrarColeccion();
  }

  Future<void> _mostrarColeccion() async {
    // Realizar una solicitud HTTP a la API para obtener las cartas de Pokémon
    var url = Uri.parse('https://api.example.com/pokemon/cards');
    var response = await http.get(url);

    // Verificar si la solicitud fue exitosa
    if (response.statusCode == 200) {
      // Decodificar los datos JSON de la respuesta
      var data = jsonDecode(response.body);

      // Obtener las cartas de Pokémon de los datos decodificados
      List<dynamic> cards = data['cards'];

      // Limpiar la lista de cartas existente
      setState(() {
        _pokemonCards.clear();
        // Agregar el nombre de cada carta a la lista _pokemonCards
        for (var card in cards) {
          _pokemonCards.add(card['name']);
        }
      });
    } else {
      // Si la solicitud no fue exitosa, mostrar un mensaje de error
      print('Error al cargar las cartas de Pokémon: ${response.statusCode}');
    }
  }

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
          _showCollection(),
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
                  bottom:
                      2), // Ajusta este valor para cambiar la distancia del subrayado al texto
              decoration: BoxDecoration(
                border: _isCollectionSelected
                    ? Border(
                        bottom: BorderSide(width: 2.0, color: Colors.white))
                    : null,
              ),
              child: Text(
                "COLLECTION",
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'sarpanch'),
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
                  bottom:
                      2), // Ajusta este valor para cambiar la distancia del subrayado al texto
              decoration: BoxDecoration(
                border: !_isCollectionSelected
                    ? Border(
                        bottom: BorderSide(width: 2.0, color: Colors.white))
                    : null,
              ),
              child: Text(
                "DUPLICATES",
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'sarpanch'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showCollection() {
    if (_isCollectionSelected) {
      // Si la opción de colección está seleccionada, mostrar las cartas de Pokémon
      return Positioned(
        top: 150,
        left: 0,
        right: 0,
        child: Column(
          children: [
            Text(
              "Colección de Pokémon",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _pokemonCards.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_pokemonCards[index],
                        style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      // Si la opción de duplicados está seleccionada, mostrar un mensaje de no implementado
      return Positioned(
        top: 150,
        left: 0,
        right: 0,
        child: Center(
          child: Text(
            "Duplicados",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: Pokedex(),
  ));
}