import 'package:flutter/material.dart';
import 'package:pokemonapp/game/main.dart'; // Importa el archivo de la pantalla MyAppGame

class BattleActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Game/background_text.png'),
            fit: BoxFit.fill,
            alignment: Alignment.bottomLeft,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10), // Ajusta el espaciado vertical y horizontal
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 25), // Espacio antes de "Attack 1"
            GestureDetector(
              onTap: () {},
              child: Text(
                "ATTACK 1",
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
            SizedBox(height: 20), // Espacio entre "Attack 1" y "Attack 2"
            GestureDetector(
              onTap: () {},
              child: Text(
                "ATTACK 2",
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
            SizedBox(height: 20), // Espacio antes de "Huir" ajustado
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navega a MyAppGame cuando se haga clic en "Huir"
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
    );
  }
}
