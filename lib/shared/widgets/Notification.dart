import 'package:flutter/material.dart';

class NotificationFloatingWidget extends StatelessWidget {
  final String message;

  final void Function()? onTap;

  NotificationFloatingWidget({required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue, // You can change the color as needed
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ));
  }
}
