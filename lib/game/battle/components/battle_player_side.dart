import 'package:flutter/material.dart';

class BattlePlayerSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 40,
              width: 276,
              margin: EdgeInsets.only(left: kToolbarHeight),
              child: Image.asset(
                'assets/Game/grass-player.png',
                fit: BoxFit.fitHeight,
                alignment: Alignment.bottomLeft,
              ),
            ),
            Container(
              height: 120,
              margin: EdgeInsets.only(left: kToolbarHeight),
              child: Image.asset(
                'assets/Game/pikachu.png',
                fit: BoxFit.fitHeight,
                alignment: Alignment.bottomLeft,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Stack(
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
                        "PIKACHU",
                        style: TextStyle(
                          fontFamily: 'PokemonFireRed',
                          fontSize: 27,
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
                        'assets/Game/male.png',
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.topRight,
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 20),
                      child: Text(
                        "Lv5",
                        style: TextStyle(
                          fontFamily: 'PokemonFireRed',
                          fontSize: 27,
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
              Container(
                margin: EdgeInsets.only(top: 60, left: 208),
                child: Text(
                  "20 / 20",
                  style: TextStyle(
                    fontFamily: 'PokemonFireRed',
                    fontSize: 25,
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
        ),
      ],
    );
  }
}
