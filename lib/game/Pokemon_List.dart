import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemonapp/game/battle/main.dart';
import 'package:provider/provider.dart';
import '../usuario.dart';
import '../usuario_provider.dart';
import 'package:pokemonapp/game/battle/screens/battle_screen.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  static List<int> _selectedPokemonIds = []; // Variable estática para almacenar los IDs de los Pokémon seleccionados
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);
    final usuario = usuarioProvider.usuario;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: CustomPaint(
              painter: CustomContainerPainter(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 22, 22, 1), // Color rojo
                    Color.fromRGBO(46, 4, 4, 1), // Color negro
                  ],
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Biblioteca de Pokémon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .white, // Cambia el color del texto según tu preferencia
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'de ${usuario?.nombreUsuario ?? ''}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors
                            .white, // Cambia el color del texto según tu preferencia
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black, // Color de fondo negro
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30, // Altura deseada del contenedor
              child: Container(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    //hintText: 'Buscar por nombre',
                    prefixIcon: Icon(Icons.search,
                        color: Colors
                            .white), // Cambia el color del ícono de búsqueda según tu preferencia
                    filled: true,
                    fillColor: Colors.white.withOpacity(
                        0.3), // Cambia el color del fondo del TextField según tu preferencia
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide.none, // Elimina el borde del TextField
                    ),
                  ),
                  onChanged: (value) {
                    // Implementa la lógica de búsqueda aquí
                    setState(
                        () {}); // Para actualizar la lista al cambiar el texto de búsqueda
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomPaint(
              painter: CustomContainerPainter(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(179, 179, 179, 1), // Color gris
                    Colors.white, // Color blanco
                  ],
                ),
              ),
              child: _buildPokemonList(usuario),
            ),
          ),
          if (_selectedPokemonIds.length == 6)
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Llama a la función que abre la pantalla de batalla
                  _navigateToBattleScreen(context);
                },
                child: Text('→'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPokemonList(Usuario? usuario) {
    return FutureBuilder(
      future: _fetchPokemonList(usuario?.idUsuario ?? 0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<dynamic> pokemonList = snapshot.data ?? [];

          // Filtrar la lista de Pokémon basado en el texto de búsqueda
          final filteredPokemonList = pokemonList.where((pokemon) {
            final pokemonName =
                pokemon['nombre_pokemon'].toString().toLowerCase();
            final searchValue = _searchController.text.toLowerCase();
            return pokemonName.contains(searchValue);
          }).toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: filteredPokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = filteredPokemonList[index];
              String imageUrl =
                  'http://20.162.113.208/' + pokemon['foto_pokemon'];
              bool isSelected = _selectedPokemonIds
                  .contains(pokemon['id_pokemon']);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    print(
                        'Pokemon seleccionado: ${pokemon['nombre_pokemon']}');
                    if (_selectedPokemonIds
                        .contains(pokemon['id_pokemon'])) {
                      _selectedPokemonIds
                          .remove(pokemon['id_pokemon']);
                    } else {
                      if (_selectedPokemonIds.length < 6) {
                        _selectedPokemonIds
                            .add(pokemon['id_pokemon']);
                      } else {
                        // Si se intenta seleccionar más de 6, muestra un mensaje
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '¡Ya has seleccionado 6 Pokémon!'),
                          ),
                        );
                      }
                    }
                  });
                },
                child: Column(
                  children: [
                    Container(
                      width: 72, // Tamaño del contenedor
                      height: 72, // Tamaño del contenedor
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? Colors.yellow
                            : Colors
                                .white, // Cambia el color del círculo
                      ),
                      child: Center(
                        child: ClipOval(
                          child: Image.network(
                            imageUrl,
                            width: 60, // Tamaño de la imagen
                            height: 60, // Tamaño de la imagen
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      pokemon['nombre_pokemon'],
                      style: TextStyle(
                        fontSize: 14, // Ajusta el tamaño del nombre aquí
                        fontWeight: FontWeight.bold,
                        fontFamily:
                            'Pokemon-Solid', // Usa la fuente personalizada
                        color: isSelected ? Colors.green : Colors.black,
                      ),
                    ),
                    SizedBox(height: 20), // Espacio entre los Pokémon
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<List<dynamic>> _fetchPokemonList(int userId) async {
    final response = await http.get(
        Uri.parse(
            'http://20.162.113.208:5000/api/pokemon/usuario/$userId'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }

  // Función para navegar a la pantalla de batalla
  void _navigateToBattleScreen(BuildContext context) {
    if (_selectedPokemonIds.length == 6) {
      // Almacena los IDs de los 6 Pokémon seleccionados en la variable estática
      _PokemonListState._selectedPokemonIds = List.from(_selectedPokemonIds);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyBattle()),
      );
    } else {
      // Si no se han seleccionado 6 Pokémon, muestra un mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selecciona 6 Pokémon para continuar.'),
        ),
      );
    }
  }
}

class CustomContainerPainter extends CustomPainter {
  final LinearGradient gradient;

  CustomContainerPainter({required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
