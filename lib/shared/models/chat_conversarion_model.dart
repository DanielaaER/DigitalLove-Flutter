class ChatConversation {
  final List<String> id;
  final int idChat;
  final String usuario;
  final String mensaje;
  final DateTime fechaRegistro;


  ChatConversation({
    required this.id,
    required this.idChat,
    required this.usuario,
    required this.mensaje,
    required this.fechaRegistro,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      id: json['id'],
      idChat: json['id_chat'],
      usuario: json['usuario'],
      mensaje: json['mensaje'],
      fechaRegistro: DateTime.parse(json['fechaRegistro']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_chat': idChat,
      'usuario': usuario,
      'mensaje': mensaje,
      'fechaRegistro': fechaRegistro.toIso8601String(),
    };
  }
}