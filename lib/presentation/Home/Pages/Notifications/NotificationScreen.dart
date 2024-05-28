import 'package:flutter/material.dart';
import '../../../../shared/models/notification_model.dart';
import '../../../../shared/services/ApiService.dart';
import 'notificationWidget.dart'; // Importa el widget de notificaciones

class NotificationsPage extends StatefulWidget {
  final ApiService apiServiceapiService;

  NotificationsPage({required this.apiServiceapiService});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
      body: StreamBuilder<List<AppNotification>>(
        stream: widget.apiServiceapiService.notificationsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay notificaciones'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                AppNotification notification = snapshot.data![index];
                return NotificationWidget(
                  notificationTitle: 'Notificación',
                  notificationMessage: notification.mensaje,
                  time: '${notification.fechaEnvio.hour}:${notification.fechaEnvio.minute}',
                );
              },
            );
          }
        },
      ),
    );
  }
}
