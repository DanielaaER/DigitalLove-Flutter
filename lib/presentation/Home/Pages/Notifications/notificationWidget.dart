import 'package:digital_love/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  final String notificationTitle;
  final String notificationMessage;
  final String time;
  final VoidCallback onTap;
  final int idUser;


  NotificationWidget({
    required this.notificationTitle,
    required this.notificationMessage,
    required this.time,
    required this.onTap,
    required this.idUser,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: Icon(Icons.favorite, color: AppColors.primaryColor),
          title: Text(notificationTitle),
          subtitle: Text(notificationMessage),
          trailing: Text(time),
        ),
      ),
    );
  }
}
