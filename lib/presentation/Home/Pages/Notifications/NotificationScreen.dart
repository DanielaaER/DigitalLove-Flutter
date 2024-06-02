import 'package:flutter/material.dart';
import '../../../../shared/models/notification_model.dart';
import '../../../../shared/services/ApiService.dart';
import 'notificationWidget.dart'; // Importa el widget de notificaciones

class NotificationsPage extends StatefulWidget {
  NotificationsPage();

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
        stream: ApiService().notificationsStream,
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
                  time:
                      '${notification.fechaEnvio.hour}:${notification.fechaEnvio.minute}',
                  idUser: notification.usuario,
                  onTap: () =>
                      _showLikeDialog(context, idUser: notification.usuario),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showLikeDialog(BuildContext context, {int? idUser}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Acción de Like'),
          content: Text('¿Quieres aceptar o rechazar el like?'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar Like'),
              onPressed: () async {
                var response = await ApiService().responseLike(idUser!, true);
                print('Aceptar Like');
                if (response) {
                  print('Like aceptado');

                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  _showErrorDialog(context);
                  print('Error al aceptar like');
                }
              },
            ),
            TextButton(
              child: Text('Rechazar Like'),
              onPressed: () async {
                // Lógica para rechazar el like
                var response = await ApiService().responseLike(idUser!, false);
                print('Rechazar Like');
                if (response) {
                  print('Like rechazado');
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  _showErrorDialog(context);
                  print('Error al rechazar like');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Ya has respondido a esta persona.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
