class Usuario {
  final int idUsuario;
  final String nombreUsuario;
  final String mail;
  final int admin;
   int sobres;

  Usuario({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.mail,
    required this.admin,
    required this.sobres,
  });

  Future<bool> verificarPokemonRegistrado(int pokemonId) async {
    // Implementar lógica para verificar si el Pokémon está registrado por el usuario
    return Future.delayed(Duration(seconds: 1), () => true); // Simulación de verificación
  }
  Future<int> obtenerCantidadSobres() async {
    // Aquí iría la lógica para obtener la cantidad de sobres desde la base de datos
    // Por ahora, solo retornamos un valor fijo como simulación
    return Future.delayed(Duration(seconds: 1), () => 10); // Simulación de cantidad de sobres
  }
}
