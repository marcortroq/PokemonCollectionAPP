import 'package:flutter/material.dart';
import 'package:pokemonapp/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class NavBar extends StatefulWidget {
  final Function(String) onProfileImageSelected;
  final double xpPer; // Agregamos xpPer como un parámetro al constructor
  final int level;
  

  NavBar({required this.onProfileImageSelected, required this.xpPer, required this.level});

  @override
  _NavBarState createState() => _NavBarState();

}

class _NavBarState extends State<NavBar> {
  String _selectedImage = '';

  // Método para mostrar el pop-up con las imágenes de perfil y permitir la selección
  void _showProfilePhotosPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          title: Text("Choose Profile Photo"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Botón para seleccionar la primera imagen
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedImage == 'assets/grow.png'
                        ? Color.fromRGBO(179, 179, 179, 1) // Cambia el color del botón seleccionado a negro
                        : null,
                    elevation: _selectedImage == 'assets/grow.png' ? 8.0 : 0.0, // Añade elevación al botón seleccionado
                  ),
                  onPressed: () {
                    // Aquí puedes manejar la lógica cuando el usuario selecciona la primera imagen
                    setState(() {
                      _selectedImage = 'assets/grow.png';
                    });
                    widget.onProfileImageSelected('assets/grow.png'); // Aquí pasas la ruta de la imagen seleccionada
                    Navigator.pop(context, 'assets/grow.png');
                  },
                  child: Image.asset('assets/grow.png'),
                ),
                SizedBox(height: 20), // Espacio vertical entre las imágenes
                // Botón para seleccionar la segunda imagen
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedImage == 'assets/meowth.png'
                        ? Color.fromRGBO(179, 179, 179, 1)
                        : null,
                    elevation: _selectedImage == 'assets/meowth.png' ? 8.0 : 0.0, // Añade elevación al botón seleccionado
                  ),
                  onPressed: () {
                    // Aquí puedes manejar la lógica cuando el usuario selecciona la segunda imagen
                    setState(() {
                      _selectedImage = 'assets/meowth.png';
                    });
                    widget.onProfileImageSelected('assets/meowth.png'); // Aquí pasas la ruta de la imagen seleccionada
                    Navigator.pop(context, 'assets/meowth.png');
                  },
                  child: Image.asset('assets/meowth.png'),
                ),
                SizedBox(height: 20), // Espacio vertical entre las imágenes
                // Botón para seleccionar la tercera imagen
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedImage == 'assets/Slowbro.png'
                        ? Color.fromRGBO(179, 179, 179, 1)
                        : null,
                    elevation: _selectedImage == 'assets/Slowbro.png' ? 8.0 : 0.0, // Añade elevación al botón seleccionado
                  ),
                  onPressed: () {
                    // Aquí puedes manejar la lógica cuando el usuario selecciona la tercera imagen
                    setState(() {
                      _selectedImage = 'assets/Slowbro.png';
                    });
                    widget.onProfileImageSelected('assets/Slowbro.png');
                    Navigator.pop(context, 'assets/Slowbro.png');
                  },
                  child: Image.asset('assets/Slowbro.png'),
                ),
                SizedBox(height: 20), // Espacio vertical entre las imágenes
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedImage == 'assets/Sandshrew.png'
                        ? Color.fromRGBO(179, 179, 179, 1)
                        : null,
                    elevation: _selectedImage == 'assets/Sandshrew.png' ? 8.0 : 0.0, // Añade elevación al botón seleccionado
                  ),
                  onPressed: () {
                    // Aquí puedes manejar la lógica cuando el usuario selecciona la tercera imagen
                    setState(() {
                      _selectedImage = 'assets/Sandshrew.png';
                    });
                    widget.onProfileImageSelected('assets/Sandshrew.png');
                    Navigator.pop(context, 'assets/Sandshrew.png');
                  },
                  child: Image.asset('assets/Sandshrew.png'),
                ),
                SizedBox(height: 20), // Espacio vertical entre las imágenes
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedImage == 'assets/Blastoise.png'
                        ? Color.fromRGBO(179, 179, 179, 1)
                        : null,
                    elevation: _selectedImage == 'assets/Blastoise.png' ? 8.0 : 0.0, // Añade elevación al botón seleccionado
                  ),
                  onPressed: () {
                    // Aquí puedes manejar la lógica cuando el usuario selecciona la tercera imagen
                    setState(() {
                      _selectedImage = 'assets/Blastoise.png';
                    });
                    widget.onProfileImageSelected('assets/Blastoise.png');
                    Navigator.pop(context, 'assets/Blastoise.png');
                  },
                  child: Image.asset('assets/Blastoise.png'),
                ),
                SizedBox(height: 20), // Espacio vertical entre las imágenes
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedImage == 'assets/Marowak.png'
                        ? Color.fromRGBO(179, 179, 179, 1)
                        : null,
                    elevation: _selectedImage == 'assets/Marowak.png' ? 8.0 : 0.0, // Añade elevación al botón seleccionado
                  ),
                  onPressed: () {
                    // Aquí puedes manejar la lógica cuando el usuario selecciona la tercera imagen
                    setState(() {
                      _selectedImage = 'assets/Marowak.png';
                    });
                    widget.onProfileImageSelected('assets/Marowak.png');
                    Navigator.pop(context, 'assets/Marowak.png');
                  },
                  child: Image.asset('assets/Marowak.png'),
                ),
                // Puedes agregar más botones para las otras imágenes según sea necesario
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double xpPer = widget.xpPer;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 250, // Ajusta la altura del DrawerHeader según sea necesario
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(224, 17, 17, 1),
                  Color.fromRGBO(224, 17, 17, 1),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20), // Ajusta el espacio entre el borde superior y el texto
                Text(
                  'POKEMON PROFILE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "sarpanch",
                  ),
                  textAlign: TextAlign.center, // Centra el texto horizontalmente
                ),
                Image.asset(
                  'assets/foto_entrenadores.png', // Ruta de la imagen de logout
                  width: 100, // Ajusta el tamaño de la imagen según sea necesario
                  height: 150,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                    title: Text(
                      'Level :  ${widget.level}',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 19,
                        fontFamily: "sarpanch",
                      ),
                    ),
                    subtitle: Container(
                       padding: const EdgeInsets.only(top: 8.0),
                      width: MediaQuery.of(context).size.width / 4,
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width / 1.6,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2500,
                        percent: xpPer,
                        center: Text(
                              '${(xpPer * 100).toStringAsFixed(0)}%', // Muestra el porcentaje en el centro de la barra
                              style: TextStyle(
                                color: Colors.black, // Puedes ajustar el color del texto según sea necesario
                                fontSize: 16, // Puedes ajustar el tamaño de fuente según sea necesario
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: const Color.fromRGBO(229, 166, 94, 1),
                        backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                  ),
                ListTile(
                  title: Text(
                    'PokePhoto',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 19,
                      fontFamily: "sarpanch",
                    ),
                  ),
                  onTap: () {
                    // Llama al método para mostrar el pop-up de las imágenes de perfil
                    _showProfilePhotosPopup(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Collection %',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 19,
                      fontFamily: "sarpanch",
                    ),
                  ),
                  onTap: () {
                    // Aquí puedes agregar la lógica para manejar el tap en el segundo ítem del Drawer
                  },
                ),
                ListTile(
  title: Text(
    'Medals',
    style: TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 19,
      fontFamily: "sarpanch",
    ),
  ),
),
// Agrega dos columnas paralelas con texto e imagen para cada medal
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            
            Text(
              '- Soul Badge',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "sarpanch",
               
              ),
            ),
            Image.asset(
              'assets/MedallaAlma.png', // Ruta de la imagen de la medalla
              width: 24, // Ajusta el tamaño de la imagen según sea necesario
              height: 24,
            ),
            SizedBox(width: 6), // Ajusta el espacio entre la imagen y el texto
          ],
        ),
        Row(
          children: [
            
            Text(
              '- Rainbow Badge',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "sarpanch",
                
              ),
            ),
            Image.asset(
              'assets/MedallaArcoiris.png', // Ruta de la imagen de la medalla
              width: 24, // Ajusta el tamaño de la imagen según sea necesario
              height: 24,
            ),
            SizedBox(width: 6), // Ajusta el espacio entre la imagen y el texto
          ],
        ),
        Row(
          children: [
            
            Text(
              '- Cascade Badge',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "sarpanch",
                
              ),
            ),
            Image.asset(
              'assets/MedallaCascada.png', // Ruta de la imagen de la medalla
              width: 24, // Ajusta el tamaño de la imagen según sea necesario
              height: 24,
            ),
            SizedBox(width: 6), // Ajusta el espacio entre la imagen y el texto
          ],
        ),
        Row(
          children: [
            
            Text(
              '- Marsh Badge',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "sarpanch",
                
              ),
            ),
            Image.asset(
              'assets/MedallaPantano.png', // Ruta de la imagen de la medalla
              width: 24, // Ajusta el tamaño de la imagen según sea necesario
              height: 24,
            ),
            SizedBox(width: 6), // Ajusta el espacio entre la imagen y el texto
          ],
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            
            Text(
              '- Boulder Badge',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "sarpanch",
               
              ),
            ),
            Image.asset(
              'assets/MedallaRoca.png', // Ruta de la imagen de la medalla
              width: 24, // Ajusta el tamaño de la imagen según sea necesario
              height: 24,
            ),
            SizedBox(width: 6), // Ajusta el espacio entre la imagen y el texto
          ],
        ),
        Row(
          children: [
            
            Text(
              '- Earth Badge',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "sarpanch",
               
              ),
            ),
            Image.asset(
              'assets/MedallaTierra.png', // Ruta de la imagen de la medalla
              width: 24, // Ajusta el tamaño de la imagen según sea necesario
              height: 24,
            ),
            SizedBox(width: 6), // Ajusta el espacio entre la imagen y el texto
          ],
        ),
        Row(
          children: [
            
            Text(
              '- Thunder Badge',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "sarpanch",
                
              ),
            ),
            Image.asset(
              'assets/MedallaTrueno.png', // Ruta de la imagen de la medalla
              width: 24, // Ajusta el tamaño de la imagen según sea necesario
              height: 24,
            ),
            SizedBox(width: 6), // Ajusta el espacio entre la imagen y el texto
          ],
        ),
        Row(
          children: [
             // Ajusta el espacio entre la imagen y el texto
            Text(
              '- Volcano Badge',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "sarpanch",
                
              ),
            ),
            Image.asset(
              'assets/MedallaVolcan.png', // Ruta de la imagen de la medalla
              width: 24, // Ajusta el tamaño de la imagen según sea necesario
              height: 24,
            ),
            SizedBox(width: 6),
          ],
        ),
      ],
    ),
  ],
),
            
          
        ],
      ),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Text(
                  'Log out',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 19,
                    fontFamily: "sarpanch",
                  ),
                ),
                 // Ajusta el espacio entre el texto y la imagen
                Image.asset(
                  'assets/logout_icon.png', // Ruta de la imagen de logout
                  width: 24, // Ajusta el tamaño de la imagen según sea necesario
                  height: 24,
                ),
              ],
            ),
            onTap: () {
                Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
        ],
      ),
    );
  }
}