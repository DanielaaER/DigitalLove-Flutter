class AppNotification {
  final int id;
  final String mensaje;
  final DateTime fechaEnvio;
  final int usuario;

  AppNotification({
    required this.id,
    required this.mensaje,
    required this.fechaEnvio,
    required this.usuario,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      mensaje: json['mensaje'],
      fechaEnvio: DateTime.parse(json['fechaEnvio']),
      usuario: json['usuario'],
    );
  }
}
