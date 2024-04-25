import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Importa la clase CustomNavBar
import 'package:pokemonapp/bar.dart'; // Reemplaza "ruta_hacia_tu_archivo_customNavBar.dart" con la ruta real de tu archivo CustomNavBar.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); // Oculta la barra de navegación
  runApp(MaterialApp(
    home: open_pack(),
  ));
}

class open_pack extends StatefulWidget {
  const open_pack({Key? key}) : super(key: key);

  @override
  State<open_pack> createState() => _StateOpen_pack();
}

class _StateOpen_pack extends State<open_pack> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return WillPopScope(
      onWillPop: () async {
        // Devuelve false para evitar que la acción de retroceso tenga efecto
        return false;
      },
      child: GestureDetector(
        onTap: () {},
        child: Scaffold(
          body: Stack(
            children: [
              
              // Aquí agregamos el CustomNavBar
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CustomNavBar(
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}