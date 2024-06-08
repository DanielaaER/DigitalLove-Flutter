import 'dart:convert';
import 'dart:io';

import 'package:digital_love/presentation/Register/pages/CredentialBackConfirmacion.dart';
import 'package:digital_love/presentation/Register/pages/CredentialConfirmacion.dart';
import 'package:digital_love/shared/services/AuthServices.dart';
import 'package:digital_love/shared/services/UserData.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<CameraDescription>> obtenerCamaras() async {
  WidgetsFlutterBinding.ensureInitialized();
  return await availableCameras();
}

class CameraCredentialFront extends StatefulWidget {
  @override
  _CameraCredentialFrontState createState() => _CameraCredentialFrontState();
}

class _CameraCredentialFrontState extends State<CameraCredentialFront> {
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
      print(UserData().userFullName);
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
                  var image = await _controller.takePicture();
                  File picture = File(image.path);

                  AuthService().saveFrontCredential(picture);


                  print("credential back?");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CredentialBackConfirmationScreen(),
                    ),
                  );
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
    await prefs.setString('credential_front', base64Image);
  }
}
