import 'dart:async';
import 'package:flutter/material.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Timer _timer;
  late DateTime _fechaApertura;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    // Inicializar la fecha de apertura y la duración del temporizador
    _fechaApertura = DateTime(2024, 5, 14, 16, 31, 31);
    _duration = Duration(hours: 24);

    // Configurar el temporizador para que se actualice cada segundo
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Calcular el tiempo restante restando la fecha actual de la fecha de apertura
        var difference = DateTime.now().difference(_fechaApertura);
        // Si el tiempo restante es menor o igual a cero, detener el temporizador
        if (difference >= _duration) {
          _timer.cancel();
        }
        // Actualizar la duración restante del temporizador
        _duration = Duration(hours: 24) - difference;
      });
    });
  }

  @override
  void dispose() {
    // Detener el temporizador cuando se elimina el widget
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mi Aplicación'),
        ),
        body: Center(
          child: _buildButton(
            'Mi Botón',
            "assets/incubadora.png",
            true,
            context,
            topLeftRadius: 20,
            topRightRadius: 20,
            bottomLeftRadius: 20,
            bottomRightRadius: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    String imagePath,
    bool activate,
    BuildContext context, {
    double? topLeftRadius,
    double? topRightRadius,
    double? bottomLeftRadius,
    double? bottomRightRadius,
  }) {
    return Stack(
      children: [
        Container(
          width: 110,
          height: 148,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius ?? 25),
              topRight: Radius.circular(topRightRadius ?? 25),
              bottomLeft: Radius.circular(bottomLeftRadius ?? 25),
              bottomRight: Radius.circular(bottomRightRadius ?? 25),
            ),
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(207, 72, 72, 1),
                Color.fromRGBO(224, 17, 17, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 113,
                left: 10,
                right: 10,
                height: 1,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 4,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 35,
                child: Image.asset(
                  imagePath,
                  width: 67,
                  height: 90,
                ),
              ),
              Positioned(
                bottom: 60,
                child: Text(
                  // Mostrar la duración restante del temporizador
                  '${_duration.inHours.toString().padLeft(2, '0')}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeftRadius ?? 25),
                topRight: Radius.circular(topRightRadius ?? 25),
                bottomLeft: Radius.circular(bottomLeftRadius ?? 25),
                bottomRight: Radius.circular(bottomRightRadius ?? 25),
              ),
              onTap: () {
                if (activate == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Vuelve más tarde para abrir la incubadora.'),
                    ),
                  );
                } else {
                  // Acción cuando se toca el botón y está activo
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
