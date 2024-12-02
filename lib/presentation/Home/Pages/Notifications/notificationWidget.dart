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
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blueGrey.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notificationTitle,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      notificationMessage,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                time,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
