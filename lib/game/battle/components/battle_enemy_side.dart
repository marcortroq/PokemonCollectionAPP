import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YourClass {
  static int idLiderGimnasio = 0;
}

class BattleEnemySide extends StatelessWidget {
  // Variables de instancia
  static int _pokemonEnemyDefense = 0;
  static int _currentEnemyPs = 0;
  static int _maxEnemyPs = 0;
  bool _pokemonEnemyDeath = false;

  // Getters y setters
  int get pokemonEnemyDefense => _pokemonEnemyDefense;
  set pokemonEnemyDefense(int value) {
    _pokemonEnemyDefense = value;
  }

  int get currentEnemyPs => _currentEnemyPs;
  set currentEnemyPs(int value) {
    print('VALUE del Pokémon enemigo: $value');
    print('Vida1 del Pokémon enemigo: $_currentEnemyPs');
    _currentEnemyPs = value;
    _pokemonEnemyDeath = _currentEnemyPs == 0;
    print('Vida2 del Pokémon enemigo: $_currentEnemyPs');
  }

  int get maxEnemyPs => _maxEnemyPs;
  set maxEnemyPs(int value) {
    _maxEnemyPs = value;
  }

  bool get pokemonEnemyDeath => _pokemonEnemyDeath;

  // Función para aplicar el daño del ataque al enemigo
  void applyAttackDamage(int attackDamage) {
    print('Vida antes peleaa del Pokémon enemigo: $currentEnemyPs');
    print('Defensa antes pelea  del Pokémon enemigo: $pokemonEnemyDefense');
    print('daño antes pelea  del Pokémon enemigo: $attackDamage');
    // Calcula el daño después de considerar la defensa del enemigo
    int calculatedDamage = attackDamage - _pokemonEnemyDefense;
    print('daño real  del Pokémon enemigo: $calculatedDamage');
    // Asegúrate de que el daño calculado no sea negativo
    if (calculatedDamage < 0) {
      calculatedDamage = 0;
    }
    // Resta el daño calculado de los puntos de vida del enemigo
    _currentEnemyPs -= calculatedDamage;
    // Verifica si el Pokémon enemigo está muerto
    _pokemonEnemyDeath = _currentEnemyPs <= 0;
    if (_currentEnemyPs <= 0) {
      _pokemonEnemyDeath = true;
    }
    print('Vida final del Pokémon enemigo: $_currentEnemyPs');
  }

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
            final primerPokemon = data['pokemons'][0];
            // Actualizar variables con los datos del JSON
            pokemonEnemyDefense = primerPokemon['defensa'] as int;
            currentEnemyPs = primerPokemon['ps'] as int;
            maxEnemyPs = primerPokemon['ps'] as int;
            print('Vida del Pokémon enemigo: $primerPokemon');
            // Impresión de la vida del Pokémon, su defensa y si está vivo
            print('Vida del Pokémon enemigo: $_currentEnemyPs');
            print('Defensa del Pokémon enemigo: $_pokemonEnemyDefense');
            print('El Pokémon enemigo está vivo: ${!_pokemonEnemyDeath}');

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
                                  '${primerPokemon['nombre_pokemon']}',
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
                            color: _pokemonEnemyDeath
                                ? Colors.red
                                : Colors.grey[300], // Color base
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: 134 *
                                    (_currentEnemyPs /
                                        _maxEnemyPs), // Representa la cantidad actual de puntos de vida del Pokémon enemigo
                                height: 10,
                                decoration: BoxDecoration(
                                  color: _pokemonEnemyDeath
                                      ? Colors.red
                                      : Colors
                                          .green, // Color de puntos de vida restantes
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              Container(
                                width: 134 *
                                    ((_maxEnemyPs - _currentEnemyPs) /
                                        _maxEnemyPs), // Representa la cantidad perdida de puntos de vida del Pokémon enemigo
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
                            'http://20.162.113.208/${primerPokemon['foto_pokemon']}',
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
      final primerPokemon = data['pokemons'][0];
      // Actualizar variables con los datos del JSON
      pokemonEnemyDefense = primerPokemon['defensa'] as int;
      currentEnemyPs = primerPokemon['ps'] as int;
      maxEnemyPs = primerPokemon['ps'] as int;
      return data;
    } else {
      throw Exception('Error al cargar los datos del líder de gimnasio');
    }
  }
}
