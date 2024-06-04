class AppNotification {
  final int id;
  final String mensaje;
  final DateTime fechaEnvio;
  final int usuario;
  final int recibe;

  AppNotification({
    required this.id,
    required this.mensaje,
    required this.fechaEnvio,
    required this.usuario,
    required this.recibe,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      mensaje: json['mensaje'],
      fechaEnvio: DateTime.parse(json['fecha_creacion']),
      usuario: json['usuario_envia_id'],
      recibe: json['usuario_recibe_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mensaje': mensaje,
      'fechaEnvio': fechaEnvio.toIso8601String(),
      'usuario': usuario,
      'recibe': recibe,
    };
  }
}
