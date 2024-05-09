import 'package:flutter/material.dart';

class BattleActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Game/background_text.png'),
          fit: BoxFit.fill,
          alignment: Alignment.bottomLeft,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "What will PIKACHU do?",
            style: TextStyle(
              color: Color(0xfff7f7f7),
              fontFamily: 'PokemonFireRed',
              fontSize: 40,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 1.0,
                  color: Color(0xff685870),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Text(
                  "ATTACK",
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
              Text(
                "BAG",
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
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "POKEMON",
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
              Text(
                "FLEE",
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
            ],
          ),
        ],
      ),
    );
  }
}
