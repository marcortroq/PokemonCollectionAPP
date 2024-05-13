import 'package:flutter/material.dart';

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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
