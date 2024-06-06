class Reporte {
  String mensaje;
  int usuarioEnviaId;
  int usuarioRecibeId;

  Reporte({required this.mensaje, required this.usuarioEnviaId, required this.usuarioRecibeId});

  // Convertir de JSON a un objeto Mensaje
  factory Reporte.fromJson(Map<String, dynamic> json) {
    return Reporte(
      mensaje: json['mensaje'],
      usuarioEnviaId: json['usuario_envia_id'],
      usuarioRecibeId: json['usuario_recibe_id'],
    );
  }

  // Convertir de un objeto Mensaje a JSON
  Map<String, dynamic> toJson() {
    return {
      'mensaje': mensaje,
      'usuario_envia_id': usuarioEnviaId,
      'usuario_recibe_id': usuarioRecibeId,
    };
  }
}
