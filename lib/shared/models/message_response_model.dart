
import 'chat_message_moodel.dart';

class MessageResponse {
  final List<ChatMessage> mensajes;

  MessageResponse({required this.mensajes});

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    var mensajesJson = json['mensajes'] as List;
    List<ChatMessage> mensajesList = mensajesJson.map((i) => ChatMessage.fromJson(i)).toList();

    return MessageResponse(mensajes: mensajesList);
  }

  Map<String, dynamic> toJson() {
    return {
      'mensajes': mensajes.map((i) => i.toJson()).toList(),
    };
  }
}

