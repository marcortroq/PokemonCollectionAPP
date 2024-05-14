import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemonapp/game/Pokemon_List.dart';

class BattlePlayerSide extends StatefulWidget {
  @override
  _BattlePlayerSideState createState() => _BattlePlayerSideState();
}

class _BattlePlayerSideState extends State<BattlePlayerSide> {
  String pokemonName = "";
  String pokemonImage = "";
  bool _pokemonDataLoaded = false; // Variable para verificar si los datos del Pokémon ya se han cargado

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pokemonDataLoaded ? null : _fetchPokemonData(), // Solo ejecutar la solicitud si los datos del Pokémon no se han cargado todavía
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(
            child: Container(
              margin: EdgeInsets.only(right: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 276,
                        margin: EdgeInsets.only(left: 20),
                        child: Image.asset(
                          'assets/Game/grass-player.png',
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                      Container(
                        height: 120,
                        margin: EdgeInsets.only(left: 20),
                        child: pokemonImage.isNotEmpty
                            ? Image.network(
                                pokemonImage,
                                fit: BoxFit.fitHeight,
                                alignment: Alignment.bottomLeft,
                              )
                            : Container(), // Handle the case when there is no image
                      ),
                    ],
                  ),
                  SizedBox(height: 0),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 281,
                        child: Image.asset(
                          'assets/Game/pokemon_info_ui.png',
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                      Container(
                        width: 281,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 40),
                              child: Text(
                                pokemonName,
                                style: TextStyle(
                                  fontFamily: 'PokemonFireRed',
                                  fontSize: 20,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 1.0,
                                      color: Color(0xffd8d0b0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        width: 131,
                        height: 10,
                        margin: EdgeInsets.only(top: 45, left: 129),
                        decoration: BoxDecoration(
                          color: Color(0xff70f8a8),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _fetchPokemonData() async {
    try {
      // Obtener los IDs de los Pokémon seleccionados
      List<int> selectedPokemonIds = PokemonList.getSelectedPokemonIds();

      // Escoger el primer Pokémon seleccionado
      int pokemonId =
          selectedPokemonIds.isNotEmpty ? selectedPokemonIds.first : 1;

      // Hacer la solicitud HTTP para obtener los datos del Pokémon
      String apiUrl =
          'http://20.162.113.208:5000/api/pokemon/ataques/$pokemonId';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          // Asignar el nombre del Pokémon
          pokemonName = data['nombre_pokemon'];
          // Formar la URL completa de la imagen del Pokémon
          String relativeImagePath = data['foto_pokemon_back'];
          pokemonImage = 'http://20.162.113.208/$relativeImagePath';
          _pokemonDataLoaded = true; // Marcar que los datos del Pokémon se han cargado
        });
      } else {
        throw Exception('Failed to load pokemon data');
      }
    } catch (error) {
      print('Error fetching pokemon data: $error');
    }
  }
}
