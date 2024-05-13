import 'package:flutter/material.dart';
import 'package:pokemonapp/game/battle/components/battle_actions.dart';
import 'package:pokemonapp/game/battle/components/battle_enemy_side.dart';
import 'package:pokemonapp/game/battle/components/battle_player_side.dart';

class BattleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Game/background-grass.png"),
              fit: BoxFit.fitHeight, // Ajusta la imagen para adaptarse a la altura de la pantalla
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BattleEnemySide(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  BattlePlayerSide(),
                  BattleActions(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
