class SendMessage {
  final String mensaje;
  final int usuarioEnviaId;
  final int usuarioRecibeId;
  final int chatPersonalId;

  SendMessage({
    required this.mensaje,
    required this.usuarioEnviaId,
    required this.usuarioRecibeId,
    required this.chatPersonalId,
  });

  factory SendMessage.fromJson(Map<String, dynamic> json) {
    return SendMessage(
      mensaje: json['mensaje'],
      usuarioEnviaId: json['usuario_envia_id'],
      usuarioRecibeId: json['usuario_recibe_id'],
      chatPersonalId: json['chat_personal_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mensaje': mensaje,
      'usuario_envia_id': usuarioEnviaId,
      'usuario_recibe_id': usuarioRecibeId,
      'chat_personal_id': chatPersonalId,
    };
  }
}
