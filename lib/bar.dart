import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokemonapp/usuario_provider.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    int usuarioXp = 500;
    double xpLevel = 100.0;
    int level = 1;

    while (usuarioXp >= xpLevel) {
      xpLevel *= 2.25;
      level += 1;
    }

    double xpPer = usuarioXp / xpLevel;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Row(
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width / 4,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2500,
                        percent: xpPer,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: const Color.fromRGBO(229, 166, 94, 1),
                        backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                    // Alineación para centrar la imagen sobre la barra de progreso
                    Positioned(
                      top: 20, // Ajusta la posición vertical de la imagen
                      right: (MediaQuery.of(context).size.width / 4 - MediaQuery.of(context).size.width * 0.25) / 2, // Centra horizontalmente la imagen sobre la barra de progreso
                      child: Image.asset(
                        'assets/xpStar.png',
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                    ),
                    Positioned(
                      top: 44,
                      left: 97,
                      child: Text(
                        level.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8), // Espacio entre la barra de experiencia y la siguiente imagen
              ],
            ),
          ),
          Image.asset(
            'assets/barramoneda.png',
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          Image.asset(
            'assets/barrapremium.png',
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.13,
          ),
        ],
      ),
    );
  }
}
