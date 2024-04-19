class Usuario {
  final int idUsuario;
  final String nombreUsuario;
  final String mail;
  final int admin;
  final int sobres;
  final int xp;

  Usuario({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.mail,
    required this.admin,
    required this.sobres,
    required this.xp,
  });

  Future<bool> verificarPokemonRegistrado(int pokemonId) async {
    // Implementar lógica para verificar si el Pokémon está registrado por el usuario
    return Future.delayed(Duration(seconds: 1), () => true); // Simulación de verificación
  }
}
