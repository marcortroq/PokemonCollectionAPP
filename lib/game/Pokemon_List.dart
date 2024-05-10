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
  @override
  Widget build(BuildContext context) {
    final usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);
    final usuario = usuarioProvider.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pokémon'),
      ),
      body: usuario == null
          ? Center(child: CircularProgressIndicator())
          : _buildPokemonList(usuario),
    );
  }

  Widget _buildPokemonList(Usuario usuario) {
    return FutureBuilder(
      future: _fetchPokemonList(usuario.idUsuario),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<dynamic> pokemonList = snapshot.data ?? [];
          return ListView.builder(
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = pokemonList[index];
              return Column(
                children: [
                  Image.network(pokemon['foto_pokemon']),
                  Text(
                    pokemon['nombre_pokemon'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20), // Espacio entre los Pokémon
                ],
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
