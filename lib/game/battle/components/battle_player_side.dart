import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemonapp/game/Pokemon_List.dart';
import 'package:pokemonapp/game/battle/components/battle_enemy_side.dart';
import 'package:pokemonapp/game/main.dart'; 

class PokemonInfo {
  final int pokemonId;

  PokemonInfo({required this.pokemonId});

  int get id => pokemonId;
}

class BattlePlayerSide extends StatefulWidget {
  @override
  _BattlePlayerSideState createState() => _BattlePlayerSideState();
}

class _BattlePlayerSideState extends State<BattlePlayerSide> {
  String pokemonName = "";
  String pokemonImage = "";
  bool _pokemonDataLoaded = false;
  List<PokemonInfo> pokemonInfos = [];
  static int currentPokemonId = 0;
  List<String> _attacks = [];
  List<int> _attackDamages = []; // Lista para almacenar el daño de cada ataque
  int currentPs = 100; // Valor predeterminado de puntos de vida actual
  int maxPs = 100; // Valor predeterminado de puntos de vida máximo
  int pokemonDefense = 0; // Variable para almacenar la defensa del Pokémon

  @override
  void initState() {
    super.initState();
    _fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pokemonDataLoaded ? null : _fetchPokemonData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Obteniendo datos del enemigo
          int enemyDefense = BattleEnemySide.pokemonEnemyDefense;
          int enemyCurrentPs = BattleEnemySide.currentEnemyPs;

          // Utiliza los datos del enemigo como desees
          
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          : Container(),
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
                        color: Colors.grey[300], // Color base
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: 131 * (currentPs / maxPs), // Representa la cantidad actual de puntos de vida
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.green, // Color de puntos de vida restantes
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          Container(
                            width: 131 * ((maxPs - currentPs) / maxPs), // Representa la cantidad perdida de puntos de vida
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.red, // Color de puntos de vida perdidos
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Game/background_text.png'),
                      fit: BoxFit.fill,
                      alignment: Alignment.bottomLeft,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      for (var i = 0; i < _attacks.length; i++)
                        GestureDetector(
                          onTap: () {
                            // Aquí puedes usar el daño del ataque seleccionado
                            int damage = _attackDamages[i];
                            // Realiza acciones con el daño, como restar PS al oponente, etc.
                          },
                          child: Text(
                            _attacks[i],
                            style: TextStyle(
                              fontFamily: 'PokemonFireRed',
                              fontSize: 35,
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
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyAppGame()),
                                );
                              },
                              child: Text(
                                "Huir",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'PokemonFireRed',
                                  fontSize: 35,
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> _fetchPokemonData() async {
    try {
      List<int> selectedPokemonIds = PokemonList.getSelectedPokemonIds();
      int pokemonId = selectedPokemonIds.isNotEmpty ? selectedPokemonIds.first : 1;
      String apiUrl = 'http://20.162.113.208:5000/api/pokemon/ataques/$pokemonId';
      final response = await http.get(Uri.parse(apiUrl));
      print('HTTP Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Respuesta JSON: $data');

        setState(() {
          pokemonName = data['nombre_pokemon'];
          String relativeImagePath = data['foto_pokemon_back'];
          pokemonImage = 'http://20.162.113.208/$relativeImagePath';
          _pokemonDataLoaded = true;

          currentPokemonId = pokemonId;

          pokemonInfos.add(PokemonInfo(pokemonId: pokemonId));

          List<dynamic> attacksData = data['ataques'];
          List<String> attacks = [];
          for (var attackData in attacksData) {
            attacks.add(attackData['nombre_ataque'] as String);
            _attackDamages.add(attackData['daño'] as int); // Guarda el daño del ataque
          }
          _attacks = attacks;

          // Obtener y establecer la cantidad actual de puntos de vida (ps), la cantidad máxima posible y la defensa
          currentPs = data['ps'];
          maxPs = data['ps'];
          pokemonDefense = data['defensa'];
        });
      } else {
        throw Exception('Failed to load pokemon data');
      }
    } catch (error) {
      print('Error fetching pokemon data: $error');
    }
  }
}
