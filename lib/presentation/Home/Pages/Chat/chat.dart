import 'dart:async';

import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/widgets/ChatPreview.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/widgets/ChatWindow.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextSpan.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  PageController _pageController = PageController();

  bool canScroll = false;
  double _dragDistance = 0.0;
  final double _longSwipeThreshold = 100.0;
  double _pageOffset = 0.0;
  var nextProfile = 0;
  var noProfiles = false;

  var chats = [
    Chat(
        id: 1,
        name: 'Rafaela',
        lastMessage: "hola",
        time: "10:01 AM",
        idUser: 1,
        profilePicture:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt4ZHvtgQvmWfBY"
            "-awhyifwjex-_AnOZJy30wWEYm7frPNCxUc9bbb6KUDRY_R_BsyyV0&usqp=CAU"),
    Chat(
        id: 2,
        name: 'Pedri',
        lastMessage: "que opinas..",
        time: "10:01 PM",
        idUser: 2,
        profilePicture: ""),
    Chat(
      id: 3,
      name: 'Hernan',
      lastMessage: "holaaa",
      time: "10:01 AM",
      idUser: 2,
    ),
    Chat(
        id: 1,
        name: 'Rafaela',
        lastMessage: "hola",
        time: "10:01 AM",
        idUser: 2,
        profilePicture:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt4ZHvtgQvmWfBY"
            "-awhyifwjex-_AnOZJy30wWEYm7frPNCxUc9bbb6KUDRY_R_BsyyV0&usqp=CAU"),
    Chat(
        id: 2,
        name: 'Pedri',
        lastMessage: "que opinas..",
        time: "10:01 PM",
        idUser: 2,
        profilePicture: ""),
    Chat(
      id: 3,
      name: 'Hernan',
      lastMessage: "holaaa",
      time: "10:01 AM",
      idUser: 2,
    ),
    Chat(
        id: 1,
        name: 'Rafaela',
        lastMessage: "hola",
        time: "10:01 AM",
        idUser: 2,
        profilePicture:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt4ZHvtgQvmWfBY"
            "-awhyifwjex-_AnOZJy30wWEYm7frPNCxUc9bbb6KUDRY_R_BsyyV0&usqp=CAU"),
    Chat(
        id: 2,
        name: 'Pedri',
        lastMessage: "que opinas..",
        time: "10:01 PM",
        idUser: 2,
        profilePicture: ""),
    Chat(
      id: 3,
      name: 'Hernan',
      lastMessage: "holaaa",
      time: "10:01 AM",
      idUser: 2,
    ),
    Chat(
        id: 1,
        name: 'Rafaela',
        lastMessage: "hola",
        time: "10:01 AM",
        idUser: 2,
        profilePicture:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt4ZHvtgQvmWfBY"
            "-awhyifwjex-_AnOZJy30wWEYm7frPNCxUc9bbb6KUDRY_R_BsyyV0&usqp=CAU"),
    Chat(
        id: 2,
        name: 'Pedri',
        lastMessage: "que opinas..",
        time: "10:01 PM",
        idUser: 2,
        profilePicture: ""),
    Chat(
      id: 3,
      name: 'Hernan',
      lastMessage: "holaaa",
      time: "10:01 AM",
      idUser: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Widget nextProfileWidget;

    var title = width * 0.09;
    var text = width * 0.05;

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(children: [
          Container(
            color: AppColors.whiteColor,
            height: MediaQuery.of(context).size.height * .8,
            width: width,
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatWindow(
                              id: chats[index].id,
                              name: chats[index].name,
                              profilePicture: chats[index].profilePicture,
                            ),
                          ));
                    },
                    child: ChatPreviewWidget(
                      senderName: chats[index].name,
                      lastMessage: chats[index].lastMessage,
                      time: chats[index].time,
                      profilePicture: chats[index].profilePicture,
                    ));
              },
            ),
          ),
        ]));
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
