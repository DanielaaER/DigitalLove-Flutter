class ChatMessage {
  final int id;
  final String mensaje;
  final DateTime fechaRegistro;
  final int chatId;
  final int usuarioId;

  ChatMessage({
    required this.id,
    required this.mensaje,
    required this.fechaRegistro,
    required this.chatId,
    required this.usuarioId,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      mensaje: json['mensaje'],
      fechaRegistro: DateTime.parse(json['fechaRegistro']),
      chatId: json['chat'],
      usuarioId: json['usuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mensaje': mensaje,
      'fechaRegistro': fechaRegistro.toIso8601String(),
      'chat': chatId,
      'usuario': usuarioId,
    };
  }
}