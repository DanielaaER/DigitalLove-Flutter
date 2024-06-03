
import 'chat_model.dart';

// class ChatResponse {
//   final List<ChatMessage> mensajes;
//
//   ChatResponse({required this.mensajes});
//
//   factory ChatResponse.fromJson(Map<String, dynamic> json) {
//     var mensajesJson = json['mensajes'] as List;
//     List<ChatMessage> mensajesList = mensajesJson.map((i) => ChatMessage.fromJson(i)).toList();
//
//     return ChatResponse(mensajes: mensajesList);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'mensajes': mensajes.map((i) => i.toJson()).toList(),
//     };
//   }
// }
//

class ChatResponse {
  final List<Chat> chats;

  ChatResponse({required this.chats});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    var chatsJson = json['chats'] as List;
    List<Chat> chatsList = chatsJson.map((chat) => Chat.fromJson(chat)).toList();

    return ChatResponse(chats: chatsList);
  }

  Map<String, dynamic> toJson() {
    return {
      'chats': chats.map((chat) => chat.toJson()).toList(),
    };
  }
}

