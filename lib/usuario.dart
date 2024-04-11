class Usuario {
  final int idUsuario;
  final String nombreUsuario;
  final String mail;
  final String contrasena;
  final int admin;
  final int sobres;

  Usuario({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.mail,
    required this.contrasena,
    required this.admin,
    required this.sobres,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json['ID_USUARIO'],
      nombreUsuario: json['NOMBRE_USUARIO'],
      contrasena: json['CONTRASEÑA'],
      mail: json['MAIL'],      
      admin: json['ADMIN'],
      sobres: json['SOBRES']
    );
  }
}