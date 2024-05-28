import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/TextBold.dart'; // Asegúrate de que la ruta sea correcta

class NotificationWidget extends StatelessWidget {
  final String notificationTitle;
  final String notificationMessage;
  final String time;
  final IconData? icon;

  NotificationWidget({
    required this.notificationTitle,
    required this.notificationMessage,
    required this.time,
    this.icon,
  });

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
          backgroundColor: AppColors.accentColor,
          child: Icon(
            icon ?? Icons.notifications,
            size: title * 1,
            color: Colors.white,
          ),
        ),
        title: CustomTextBold(
          size: title,
          color: AppColors.accentColor,
          textValue: notificationTitle,
        ),
        subtitle: Text(
          notificationMessage,
          maxLines: 2,
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
