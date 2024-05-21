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
                            width: 131 *
                                (currentPs /
                                    maxPs), // Representa la cantidad actual de puntos de vida
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors
                                  .green, // Color de puntos de vida restantes
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          Container(
                            width: 131 *
                                ((maxPs - currentPs) /
                                    maxPs), // Representa la cantidad perdida de puntos de vida
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors
                                  .red, // Color de puntos de vida perdidos
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
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
                            // Aquí se imprime el daño del ataque seleccionado
                            int attackIndex = i;
                            int damage = _attackDamages[attackIndex];
                            int enemyDefense =
                                BattleEnemySide.pokemonEnemyDefense;
                            // Calcula el daño neto después de tomar en cuenta la defensa del enemigo
                            int netDamage = damage - enemyDefense;
                            // Asegúrate de que el daño neto no sea negativo
                            if (netDamage < 0) {
                              netDamage = 0;
                            }
                            // Resta el daño neto de la vida del enemigo
                            BattleEnemySide.currentEnemyPs -= netDamage;
                            // Asegúrate de que la vida del enemigo no sea negativa
                            if (BattleEnemySide.currentEnemyPs < 0) {
                              BattleEnemySide.currentEnemyPs = 0;
                            }
                            // Imprime el nuevo valor de la vida del enemigo
                            print('Daño del ataque: $damage');
                            print(
                                'Daño final después de la defensa del enemigo: $netDamage');
                            print(
                                'Vida del enemigo después del ataque: ${BattleEnemySide.currentEnemyPs}');
                            setState(() {});
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
                                  MaterialPageRoute(
                                      builder: (context) => MyAppGame()),
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
      int pokemonId =
          selectedPokemonIds.isNotEmpty ? selectedPokemonIds.first : 1;
      String apiUrl =
          'http://20.162.113.208:5000/api/pokemon/ataques/$pokemonId';
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
            _attackDamages
                .add(attackData['daño'] as int); // Guarda el daño del ataque
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

class YourClass {
  static int idLiderGimnasio = 0;
}

class BattleEnemySide extends StatelessWidget {
  static int pokemonEnemyDefense =
      0; // Variable para almacenar la defensa del Pokémon enemigo
  static int currentEnemyPs =
      0; // Variable para almacenar la vida actual del Pokémon enemigo
  static int maxEnemyPs =
      0; // Variable para almacenar la vida máxima del Pokémon enemigo
  static bool pokemonEnemyDeath =
      false; // Variable para almacenar si el Pokémon enemigo está muerto

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: obtenerDatosLider(YourClass.idLiderGimnasio),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final data = snapshot.data;
          if (data != null &&
              data['pokemons'] != null &&
              data['pokemons'].isNotEmpty) {
            final pokemon = data['pokemons'][0];
            currentEnemyPs = pokemon['ps']
                as int; // Puntos de vida actuales del Pokémon enemigo
            maxEnemyPs = pokemon['ps']
                as int; // Puntos de vida máximos del Pokémon enemigo

            // Almacenar la defensa del Pokémon enemigo
            pokemonEnemyDefense = pokemon['defensa'] as int;

            // Actualizar el estado del Pokémon enemigo (vivo o muerto)
            pokemonEnemyDeath = currentEnemyPs == 0;

            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                margin: EdgeInsets.only(left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 279,
                          margin: EdgeInsets.only(left: kToolbarHeight),
                          child: Image.asset(
                            'assets/Game/enemy_ui.png',
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topRight,
                          ),
                        ),
                        Container(
                          width: 264,
                          margin: EdgeInsets.only(left: 60),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 15),
                                child: Text(
                                  '${pokemon['nombre_pokemon']}',
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
                              Container(
                                height: 20,
                                margin: EdgeInsets.only(top: 12),
                                child: Image.asset(
                                  'assets/Game/female.png',
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment.topRight,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Container(
                          width: 134,
                          height: 10,
                          margin: EdgeInsets.only(top: 46, left: 163),
                          decoration: BoxDecoration(
                            color: pokemonEnemyDeath
                                ? Colors.red
                                : Colors.grey[300], // Color base
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: 134 *
                                    (currentEnemyPs /
                                        maxEnemyPs), // Representa la cantidad actual de puntos de vida del Pokémon enemigo
                                height: 10,
                                decoration: BoxDecoration(
                                  color: pokemonEnemyDeath
                                      ? Colors.red
                                      : Colors
                                          .green, // Color de puntos de vida restantes
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              Container(
                                width: 134 *
                                    ((maxEnemyPs - currentEnemyPs) /
                                        maxEnemyPs), // Representa la cantidad perdida de puntos de vida del Pokémon enemigo
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors
                                      .red, // Color de puntos de vida perdidos
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 284,
                          child: Image.asset(
                            'assets/Game/grass-enemy.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Container(
                          height: 120,
                          margin: EdgeInsets.only(bottom: 25),
                          child: Image.network(
                            'http://20.162.113.208/${pokemon['foto_pokemon']}',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No se encontraron datos'));
          }
        }
      },
    );
  }

  Future<Map<String, dynamic>> obtenerDatosLider(int idLider) async {
    print('ID del líder de gimnasio: $idLider');
    final response = await http
        .get(Uri.parse('http://20.162.113.208:5000/api/lider/Battle/$idLider'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Actualiza las variables con los datos del primer Pokémon en la lista de pokemons
      final primerPokemon = data['pokemons'][0];
      currentEnemyPs = primerPokemon['ps'] as int;
      maxEnemyPs = primerPokemon['ps'] as int;
      pokemonEnemyDefense = primerPokemon['defensa'] as int;
      return data;
    } else {
      throw Exception('Error al cargar los datos del líder de gimnasio');
    }
  }
}
