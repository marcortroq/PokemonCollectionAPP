import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../usuario.dart';
import '../usuario_provider.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  List<dynamic> _selectedPokemon = [];
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);
    final usuario = usuarioProvider.usuario;

    return Scaffold(
      body: Column(
        children: [
          CustomPaint(
            painter: RPSCustomPainter2(),
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
                      color: Colors.white, // Cambia el color del texto según tu preferencia
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'de ${usuario?.nombreUsuario ?? ''}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Cambia el color del texto según tu preferencia
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar por nombre',
                      prefixIcon: Icon(Icons.search, color: Colors.white), // Cambia el color del ícono de búsqueda según tu preferencia
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3), // Cambia el color del fondo del TextField según tu preferencia
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none, // Elimina el borde del TextField
                      ),
                    ),
                    onChanged: (value) {
                      // Implementa la lógica de búsqueda aquí
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: CustomPaint(
              painter: RPSCustomPainter(),
              child: _buildPokemonList(usuario),
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
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = pokemonList[index];
              String imageUrl =
                  'http://20.162.113.208/' + pokemon['foto_pokemon'];
              bool isSelected = _selectedPokemon.contains(pokemon);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedPokemon.remove(pokemon);
                    } else {
                      if (_selectedPokemon.length < 6) {
                        _selectedPokemon.add(pokemon);
                      } else {
                        // Si se intenta seleccionar más de 6, muestra un mensaje
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('¡Ya has seleccionado 6 Pokémon!'),
                          ),
                        );
                      }
                    }
                  });
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 72, // Tamaño de la imagen
                          height: 72, // Tamaño de la imagen
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? Colors.yellow.withOpacity(0.5)
                                : Colors.transparent,
                          ),
                        ),
                        Image.network(
                          imageUrl,
                          width: 72, // Tamaño de la imagen
                          height: 72, // Tamaño de la imagen
                        ),
                      ],
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
        Uri.parse('http://20.162.113.208:5000/api/pokemon/usuario/$userId'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [Color.fromRGBO(255, 22, 22, 1), Colors.black],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final paintFill = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    final path = Path()
      ..moveTo(0 * 0.3762500, 0 * 0.4020000)
      ..lineTo(650 * 0.7487500, 0 * 0.3020000)
      ..lineTo(650 * 0.7487500, 550 * 0.7040000)
      ..lineTo(470 * 0.5637500, 550 * 0.9040000)
      ..lineTo(0 * 0.3762500, 550 * 0.7020000);

    canvas.drawPath(path, paintFill);

    final paintStroke = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double offsetY = 12.0;
    final path = Path()
      ..moveTo(size.width * 0, size.height * 0.3116667 + offsetY)
      ..lineTo(size.width * 0.5, size.height * 0.51)
      ..lineTo(size.width * 1, size.height * 0.316667 + offsetY)
      ..lineTo(size.width * 1, size.height * 1.25)
      ..lineTo(size.width * 0, size.height * 1.25);

    final paintFill = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(179, 179, 179, 1),
          Color.fromARGB(255, 255, 255, 255),
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
