import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  late MqttServerClient client;
  late StreamSubscription subscription;
  final String topic = '/message/2';

  void onConnected() {
    print('MQTT_LOGS:: Connected');
  }

  void onDisconnected() {
    print('MQTT_LOGS:: Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTT_LOGS:: Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('MQTT_LOGS:: Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    print('MQTT_LOGS:: Unsubscribed topic: $topic');
  }

  void pong() {
    print('MQTT_LOGS:: Ping response client callback invoked');
  }

  Future<void> connect() async {
    final String user = "1";
    client = MqttServerClient('roandaiserver.ddns.net', 'user-$user');
    client.port = 1883;
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;
    client.logging(on: true);

    print('MQTT_LOGS::Mosquitto client connecting....');
    try {
      await client.connect();
      client.subscribe(topic, MqttQos.atLeastOnce);
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT_LOGS::Mosquitto client connected');
    } else {
      print(
          'MQTT_LOGS::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }

    subscription = client.updates!
        .listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      for (final MqttReceivedMessage<MqttMessage> message in messages) {
        final MqttPublishMessage mqttMsg =
            message.payload as MqttPublishMessage;
        final String payload =
            MqttPublishPayload.bytesToStringAsString(mqttMsg.payload.message!);
        print(
            'MQTT_LOGS::Received message: $payload from topic: ${message.topic}');
        // Llamar a la función _onMessageReceived con el mensaje recibido
        _onMessageReceived(payload);
      }
    });
  }

  void _onMessageReceived(String message) {
    print('MQTT_LOGS::Received message from topic: ${message}');
  }

  Future<void> sendMessage(int userId, String message) async {
    final String pubTopic =
        '/message/user/$userId'; // Construye el tópico del mensaje
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
    print("send message");
    print(pubTopic);
    print(message);
  }
}
