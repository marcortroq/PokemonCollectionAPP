class Usuario {
  final int idUsuario;
  final String nombreUsuario;
  final String mail;
  final String contrasena;
  final int admin;

  Usuario({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.mail,
    required this.contrasena,
    required this.admin,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json['ID_USUARIO'],
      nombreUsuario: json['NOMBRE_USUARIO'],
      mail: json['MAIL'],
      contrasena: json['CONTRASEÑA'],
      admin: json['ADMIN'],
    );
  }
}