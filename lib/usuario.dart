import 'dart:convert';
import 'package:http/http.dart' as http;

class Usuario {
  late int _idUsuario;
  late String _nombreUsuario;
  late String _mail;
  late String _contrasena;
  late int _admin;
  late int _sobres;

  Usuario({
    required int idUsuario,
    required String nombreUsuario,
    required String mail,
    required String contrasena,
    required int admin,
    required int sobres,
  }) {
    _idUsuario = idUsuario;
    _nombreUsuario = nombreUsuario;
    _mail = mail;
    _contrasena = contrasena;
    _admin = admin;
    _sobres = sobres;
  }

  int get idUsuario => _idUsuario;
  String get nombreUsuario => _nombreUsuario;
  String get mail => _mail;
  String get contrasena => _contrasena;
  int get admin => _admin;
  int get sobres => _sobres;

  set nombreUsuario(String nombreUsuario) {
    _nombreUsuario = nombreUsuario;
  }

  set mail(String mail) {
    _mail = mail;
  }

  set contrasena(String contrasena) {
    _contrasena = contrasena;
  }

  set admin(int admin) {
    _admin = admin;
  }

  set sobres(int sobres) {
    _sobres = sobres;
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json['ID_USUARIO'],
      nombreUsuario: json['NOMBRE_USUARIO'],
      contrasena: json['CONTRASEÑA'],
      mail: json['MAIL'],
      admin: json['ADMIN'],
      sobres: json['SOBRES'],
    );
  }

  Future<bool> verificarPokemonRegistrado(int idPokemon) async {
    try {
      final apiUrl = 'http://20.162.90.233:5000/api/pokedex/user/$_idUsuario';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> pokedexEntries = json.decode(response.body);

        // Verificar si el idPokemon ya está registrado en la Pokédex del usuario
        bool isPokemonRegistered =
            pokedexEntries.any((entry) => entry['id_pokemon'] == idPokemon);

        return isPokemonRegistered;
      } else {
        throw Exception('Error al obtener la Pokédex del usuario');
      }
    } catch (e) {
      print('Error en verificarPokemonRegistrado: $e');
      return false; // En caso de error, consideramos que el Pokémon no está registrado
    }
  }
}
