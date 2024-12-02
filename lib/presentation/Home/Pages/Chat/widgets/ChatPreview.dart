import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:flutter/material.dart';

class ChatPreviewWidget extends StatelessWidget {
  final String senderName;
  final String lastMessage;
  final String time;
  final String? profilePicture;
  final int idChat;

  ChatPreviewWidget(
      {required this.senderName,
      required this.lastMessage,
      required this.time,
      required this.idChat,
      this.profilePicture});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var title = width * 0.06;
    var text = width * 0.04;
    return Container(
      padding: EdgeInsets.symmetric(vertical: height * .01),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.greyColor, // Color del borde
            width: 0.07, // Ancho del borde
            style: BorderStyle.solid, // Estilo del borde
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: title * 1.4,
          backgroundImage:
              profilePicture != null ? NetworkImage(profilePicture!) : null,
          backgroundColor: AppColors.accentColor,
          child: profilePicture == null
              ? Icon(
                  Icons.person,
                  size: title * 1,
                )
              : null,
        ),
        title: CustomTextBold(
          size: title,
          color: AppColors.accentColor,
          textValue: senderName,
        ),
        subtitle: Text(
          lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey, fontSize: text),
        ),
        trailing: Text(
          time,
          style: TextStyle(color: Colors.grey, fontSize: text),
        ),
      ),
    );
  }
}
