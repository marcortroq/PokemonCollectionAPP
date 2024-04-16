import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  List<Map<String, dynamic>>? _pokemonCards;

  @override
  void initState() {
    super.initState();
    _fetchPokemonCardsInRange();
  }

  Future<void> _fetchPokemonCardsInRange() async {
    var url = Uri.parse('http://20.162.90.233:5000/api/cartas');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _pokemonCards = List<Map<String, dynamic>>.from(data['Cartas']);
      });
    } else {
      print('Error al cargar las cartas de Pokémon: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: _pokemonCards != null
          ? ListView.builder(
              itemCount: _pokemonCards!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      'ID Pokemon: ${_pokemonCards![index]['ID_POKEMON']}'),
                  subtitle: _pokemonCards![index]['FOTO_CARTA'] != null
                      ? Image.memory(
                          // Decodificar la imagen en base64 y mostrarla
                          base64Decode(_pokemonCards![index]['FOTO_CARTA']),
                          width: 100,
                          height: 100,
                        )
                      : Text('No hay imagen disponible'),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
