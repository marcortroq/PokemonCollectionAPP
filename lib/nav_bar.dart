import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
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
                    Navigator.pop(context, 'assets/grow.png');
                  },
                  child: Image.asset('assets/grow.png'),
                ),
                SizedBox(height: 50), // Espacio vertical entre las imágenes
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
                    Navigator.pop(context, 'assets/meowth.png');
                  },
                  child: Image.asset('assets/meowth.png'),
                ),
                SizedBox(height: 10), // Espacio vertical entre las imágenes
                // Botón para seleccionar la tercera imagen
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedImage == 'assets/Charizard.png'
                        ? Color.fromRGBO(179, 179, 179, 1)
                        : null,
                    elevation: _selectedImage == 'assets/Charizard.png' ? 8.0 : 0.0, // Añade elevación al botón seleccionado
                  ),
                  onPressed: () {
                    // Aquí puedes manejar la lógica cuando el usuario selecciona la tercera imagen
                    setState(() {
                      _selectedImage = 'assets/Charizard.png';
                    });
                    Navigator.pop(context, 'assets/Charizard.png');
                  },
                  child: Image.asset('assets/Charizard.png'),
                ),
                SizedBox(height: 10), // Espacio vertical entre las imágenes
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedImage == 'assets/Rapidash.png'
                        ? Color.fromRGBO(179, 179, 179, 1)
                        : null,
                    elevation: _selectedImage == 'assets/Rapidash.png' ? 8.0 : 0.0, // Añade elevación al botón seleccionado
                  ),
                  onPressed: () {
                    // Aquí puedes manejar la lógica cuando el usuario selecciona la tercera imagen
                    setState(() {
                      _selectedImage = 'assets/Rapidash.png';
                    });
                    Navigator.pop(context, 'assets/Rapidash.png');
                  },
                  child: Image.asset('assets/Rapidash.png'),
                ),
                SizedBox(height: 10), // Espacio vertical entre las imágenes
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
                    Navigator.pop(context, 'assets/Blastoise.png');
                  },
                  child: Image.asset('assets/Blastoise.png'),
                ),
                SizedBox(height: 10), // Espacio vertical entre las imágenes
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedImage == 'assets/Rhydon.png'
                        ? Color.fromRGBO(179, 179, 179, 1)
                        : null,
                    elevation: _selectedImage == 'assets/Rhydon.png' ? 8.0 : 0.0, // Añade elevación al botón seleccionado
                  ),
                  onPressed: () {
                    // Aquí puedes manejar la lógica cuando el usuario selecciona la tercera imagen
                    setState(() {
                      _selectedImage = 'assets/Rhydon.png';
                    });
                    Navigator.pop(context, 'assets/Rhydon.png');
                  },
                  child: Image.asset('assets/Rhydon.png'),
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
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(224, 17, 17, 1),
                  ),
                  child: Text(
                    'POKEMON PROFILE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: "sarpanch",
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Profile photo',
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
                  onTap: () {
                    // Aquí puedes agregar la lógica para manejar el tap en el primer ítem del Drawer
                  },
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
                SizedBox(width: 10), // Ajusta el espacio entre el texto y la imagen
                Image.asset(
                  'assets/logout_icon.png', // Ruta de la imagen de logout
                  width: 24, // Ajusta el tamaño de la imagen según sea necesario
                  height: 24,
                ),
              ],
            ),
            onTap: () {
              // Aquí puedes agregar la lógica para manejar el tap en el botón de logout
              // Por ejemplo, puedes manejar el logout del usuario
            },
          ),
        ],
      ),
    );
  }
}
