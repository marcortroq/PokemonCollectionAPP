import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final Function(String) onProfileImageSelected; // Define el parámetro onProfileImageSelected

  NavBar({required this.onProfileImageSelected});
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
                    widget.onProfileImageSelected('assets/Charizard.png');
                    Navigator.pop(context, 'assets/Charizard.png');
                  },
                  child: Image.asset('assets/Charizard.png'),
                ),
                SizedBox(height: 20), // Espacio vertical entre las imágenes
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
                    widget.onProfileImageSelected('assets/Rapidash.png');
                    Navigator.pop(context, 'assets/Rapidash.png');
                  },
                  child: Image.asset('assets/Rapidash.png'),
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
                    widget.onProfileImageSelected('assets/Rhydon.png');
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
                 // Ajusta el espacio entre el texto y la imagen
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