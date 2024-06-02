import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/services/UserData.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../shared/services/webSocket.dart';

class ChatWindow extends StatefulWidget {
  @override
  _ChatWindowState createState() => _ChatWindowState();

  final int id;
  final String name;
  final String? profilePicture;

  const ChatWindow({
    super.key,
    required this.id,
    required this.name,
    this.profilePicture,
  });
}

class _ChatWindowState extends State<ChatWindow> {
  void onNotificationTap() {}
  int idSendUser = UserData()!.userId!;
  String edad = "";
  String signo = "";
  String meProfilePicture = "";
  TextEditingController _messageController = TextEditingController();
  var messages = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    setState(() {
      edad = "21 años";
      signo = "libra";
    });
    getMessages();

    super.initState();
  }

  void _onMessageReceived(String message) {
    setState(() {
      messages.add(Message(
          id: messages.length + 1, message: message, idUser: widget.id));
    });
  }

  void _sendMessage(String message) {
    setState(() {
      messages.add(Message(
          id: messages.length + 1, message: message, idUser: idSendUser));
    });
  }

  void getMessages() {
    setState(() {
      print("user send me");
      print(idSendUser);
      messages = [
        Message(id: 1, message: "hola", idUser: 1),
        Message(id: 1, message: "hola", idUser: 2),
        Message(id: 1, message: "¿Qué tal", idUser: 1),
        Message(id: 1, message: "¿Qué tal", idUser: 1),
      ];
    });
  }

  void _updateMessages() {
    // Actualiza tus datos de mensajes aquí
    // Luego, desplaza el controlador al final
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var title = width * 0.06;
    var text = width * 0.04;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Fondo blanco de la barra de estado
    ));
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .11),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: 1),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * .02),
                height: kToolbarHeight + 2,
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                // color: AppColors.accentColor,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: AppColors.whiteColor,
                                ),
                                CircleAvatar(
                                  radius: title * 1.4,
                                  backgroundImage: widget.profilePicture != null
                                      ? NetworkImage(widget.profilePicture!)
                                      : null,
                                  backgroundColor: AppColors.accentColor,
                                  child: widget.profilePicture == null ||
                                          widget.profilePicture == ""
                                      ? Icon(
                                          Icons.person,
                                          size: title,
                                        )
                                      : null,
                                ),
                              ],
                            )),
                        GestureDetector(
                            // onTap: () => onTap(),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              CustomText(
                                color: AppColors.whiteColor,
                                size: title,
                                textValue: widget.name,
                              ),
                              CustomText(
                                color: AppColors.whiteColor,
                                size: text,
                                textValue: "${edad}, ${signo}",
                              )
                            ])),
                      ],
                    ),
                    GestureDetector(
                      onTap: onNotificationTap,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: height * 0.03,
                            // Ajusta el tamaño según sea necesario
                            color: AppColors.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: height * .02, horizontal: width * .05),
              color: AppColors.whiteColor,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  Message message = messages[index];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: message.idUser == idSendUser
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                              topLeft: Radius.circular(
                                  message.idUser == idSendUser ? 0.0 : 16.0),
                              topRight: Radius.circular(
                                  message.idUser != idSendUser ? 0.0 : 16.0),
                            ),
                            child: Container(
                              color: message.idUser == idSendUser
                                  ? AppColors.shadeColor
                                  : AppColors.primaryColor,
                              padding: EdgeInsets.all(10.0),
                              child: CustomText(
                                color: AppColors.whiteColor,
                                textValue: message.message,
                                size: text,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: width,
            color: AppColors.whiteColor,
            padding: EdgeInsets.symmetric(
                horizontal: width * .05, vertical: height * 0.015),
            child: Row(
              children: [
                Container(
                  width: width * .75,
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.normal,
                      fontSize: text,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(width * .05, 0, 10, width * .05),
                      hintText: 'Escribe un mensaje...',
                      hintStyle: TextStyle(color: AppColors.whiteColor),
                      fillColor: AppColors.primaryColor,
                      filled: true,
                      hoverColor: AppColors.accentColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: 8.0),
                Container(
                  width: width * .15,
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      print("send message");
                      _sendMessage(_messageController.text);
                      _updateMessages();
                      setState(() {
                        _messageController.text = "";
                      });
                    },
                    child: Container(
                      width: width * .11,
                      height: width * .11,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      alignment: Alignment.centerRight,
                      child: Center(
                        child: Icon(
                          Icons.send_rounded,
                          color: AppColors.whiteColor,
                          size: width * .08,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final int id;

  // final DateTime hour;
  final String message;
  final int idUser;

  // final int idMe;

  Message({
    required this.id,
    // required this.hour,
    required this.message,
    required this.idUser,
    // required this.idMe
  });
}
