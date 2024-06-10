import 'dart:async';

import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/widgets/ChatPreview.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/widgets/ChatWindow.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextSpan.dart';
import 'package:flutter/material.dart';

import '../../../../shared/models/chat_model.dart';
import '../../../../shared/models/chat_response_model.dart';
import '../../../../shared/services/ApiService.dart';
import '../../../../shared/services/UserData.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Future<ChatResponse> chatResponse;

  @override
  void initState() {
    super.initState();
    chatResponse = ApiService().getChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ChatResponse>(
        future: chatResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData != "") {
            print("Chat");
            print(snapshot.data?.chats.length);
            if (snapshot.data?.chats.length == 0) {
              return Center(
                child: CustomTextBold(
                  textValue: "No tienes chats",
                  size: 20,
                  color: AppColors.backColor,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.chats.length ?? 0,
              itemBuilder: (context, index) {
                var chat = snapshot.data!.chats[index];
                print("user id");
                print(UserData().userId);
                print("id usuario");
                print(chat.usuario.id);
                print("id usuario match");
                print(chat.usuarioMatch.id);

                var userChat = chat.usuarioMatch;
                print("userChat");
                print(userChat.nombre);
                print(userChat.id);
                if (userChat.id == UserData().userId) {
                  print("usuario");
                  userChat = chat.usuario;
                } else {
                  print("match");
                  userChat = chat.usuarioMatch;
                }
                print("Chat");
                print("userChat");
                print(userChat.nombre);
                print(userChat.id);
                print(userChat.fotos.isNotEmpty
                    ? userChat.fotos[0]["foto"]
                    : null);
                var foto = userChat.fotos.isNotEmpty
                    ? userChat.fotos[0]["foto"]
                        .replaceFirst('/media', '/api/v1/media')
                    : null;
                print(foto);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatWindow(
                              id: chat.id,
                              name: '${userChat.nombre}',
                              idSender: userChat.id,
                              profilePicture: foto,
                              age: userChat.edad),
                        ));
                  },
                  child: ChatPreviewWidget(
                    senderName: '${userChat.nombre}',
                    lastMessage: "",
                    time: "",
                    idChat: chat.id,
                    profilePicture: foto,
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class Chat {
  final int id;
  final String name;
  final String lastMessage;
  final String time;
  final int idUser;
  final String? profilePicture;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.idUser,
    this.profilePicture,
  });
}
