import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YourClass {
  static int idLiderGimnasio = 0;
}

class BattleEnemySide extends StatelessWidget {
  static int pokemonEnemyDefense = 0; // Variable para almacenar la defensa del Pokémon enemigo
  static int currentEnemyPs = 0; // Variable para almacenar la vida actual del Pokémon enemigo
  static int maxEnemyPs = 0; // Variable para almacenar la vida máxima del Pokémon enemigo
  static bool pokemonEnemyDeath = false; // Variable para almacenar si el Pokémon enemigo está muerto

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
          if (data != null && data['pokemons'] != null && data['pokemons'].isNotEmpty) {
            final pokemon = data['pokemons'][0];
            currentEnemyPs = pokemon['ps'] as int; // Puntos de vida actuales del Pokémon enemigo
            maxEnemyPs = pokemon['ps'] as int; // Puntos de vida máximos del Pokémon enemigo
            
            // Almacenar la defensa del Pokémon enemigo
            pokemonEnemyDefense = pokemon['defensa'] as int;
            
            // Actualizar el estado del Pokémon enemigo (vivo o muerto)
            pokemonEnemyDeath = currentEnemyPs == 0;

            // Impresión de la vida del Pokémon, su defensa y si está vivo
            print('Vida del Pokémon enemigo: $currentEnemyPs');
            print('Defensa del Pokémon enemigo: $pokemonEnemyDefense');
            print('El Pokémon enemigo está vivo: ${!pokemonEnemyDeath}');
            
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
                            color: pokemonEnemyDeath ? Colors.red : Colors.grey[300], // Color base
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: 134 * (currentEnemyPs / maxEnemyPs), // Representa la cantidad actual de puntos de vida del Pokémon enemigo
                                height: 10,
                                decoration: BoxDecoration(
                                  color: pokemonEnemyDeath ? Colors.red : Colors.green, // Color de puntos de vida restantes
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              Container(
                                width: 134 * ((maxEnemyPs - currentEnemyPs) / maxEnemyPs), // Representa la cantidad perdida de puntos de vida del Pokémon enemigo
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
    final response = await http.get(Uri.parse('http://20.162.113.208:5000/api/lider/Battle/$idLider'));

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
