class UserUpdate {
  final String? usuario;
  final String? nombre;
  final String? apellidoMaterno;
  final String? apellidoPaterno;
  final int? edad;
  final String? ubicacion;
  final String? sexo;
  final String? telefono;
  final String? estado;
  final String? correo;
  final String? orientacionSexual;
  final String? password;
  final List<Foto>? fotos;

  UserUpdate({
    this.usuario,
    this.nombre,
    this.apellidoMaterno,
    this.apellidoPaterno,
    this.edad,
    this.ubicacion,
    this.sexo,
    this.telefono,
    this.estado,
    this.correo,
    this.orientacionSexual,
    this.password,
    this.fotos,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (usuario != null) data['usuario'] = usuario;
    if (nombre != null) data['nombre'] = nombre;
    if (apellidoMaterno != null) data['apellidoMaterno'] = apellidoMaterno;
    if (apellidoPaterno != null) data['apellidoPaterno'] = apellidoPaterno;
    if (edad != null) data['edad'] = edad;
    if (ubicacion != null) data['ubicacion'] = ubicacion;
    if (sexo != null) data['sexo'] = sexo;
    if (telefono != null) data['telefono'] = telefono;
    if (estado != null) data['estado'] = estado;
    if (correo != null) data['correo'] = correo;
    if (orientacionSexual != null) data['orientacionSexual'] = orientacionSexual;
    if (password != null) data['password'] = password;
    if (fotos != null) data['fotos'] = fotos!.map((foto) => foto.toJson()).toList();
    return data;
  }
}

class Foto {
  final String foto;

  Foto({required this.foto});

  Map<String, dynamic> toJson() => {'foto': foto};
}
