import 'dart:convert';
import 'dart:io';

import 'package:digital_love/presentation/Register/pages/CredentialBackConfirmacion.dart';
import 'package:digital_love/presentation/Register/pages/SelfieConfirmation.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/services/AuthServices.dart';

Future<List<CameraDescription>> obtenerCamaras() async {
  WidgetsFlutterBinding.ensureInitialized();
  return await availableCameras();
}

class CameraCredentialBack extends StatefulWidget {
  @override
  _CameraCredentialBackState createState() => _CameraCredentialBackState();
}

class _CameraCredentialBackState extends State<CameraCredentialBack> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    obtenerCamaras().then((camaras) {
      print(camaras);
      _controller = CameraController(
        camaras[0],
        ResolutionPreset.medium,
      );

      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Container(
          height: height,
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Positioned(
          bottom: 80,
          child: Container(
            alignment: Alignment.center,
            child: CustomButton(
              loading: _isLoading,
              onPressed: () async {
                try {
                  setState(() {
                    _isLoading = true;
                  });
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  print("image");

                  File picture = File(image.path);
                  print(image.path);

                  await AuthService().saveBackCredential(picture);

                  print("credential back?");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelfieConfirmationScreen(),
                    ),
                  );
                  // Aquí puedes manejar la imagen capturada, como guardarla o mostrarla en otro widget.
                } catch (e) {
                  print(e);
                }
              },
              textValue: 'Tomar fotografia',
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> saveImageAsBase64(String base64Image) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('credential_back', base64Image);
  }
}
