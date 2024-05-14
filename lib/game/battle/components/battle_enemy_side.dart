import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YourClass {
  static int idLiderGimnasio = 0;
}

class BattleEnemySide extends StatelessWidget {
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
                            color: Color(0xff70f8a8),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los datos del líder de gimnasio');
    }
  }
}
