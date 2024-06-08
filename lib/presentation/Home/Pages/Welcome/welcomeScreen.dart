import 'package:digital_love/presentation/Home/NavBar.dart';
import 'package:digital_love/shared/widgets/GenderDrop.dart';
import 'package:digital_love/shared/widgets/HairColorDrop.dart';
import 'package:digital_love/shared/widgets/HairDrop.dart';
import 'package:digital_love/shared/widgets/SexDrop.dart';
import 'package:digital_love/shared/widgets/SexPreferDrop.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/shared/services/ApiService.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/config/theme/app_colors.dart';

import '../../../../shared/widgets/LabelDrop.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _update(var data) async {
    print("new data");
    print("data");
    print(data);
    bool response = await ApiService().registerPreferences(data);
    print("response");
    print(response);
    return response;
  }

  bool conLentes = false;
  bool conCaraOvalada = false;
  bool conPielBlanca = false;
  String colorCabello = 'BLACK_HAIR';
  String tipoCabello = 'STRAIGHT_HAIR';
  String sexoPreferido = 'MASCULINO';
  List<String> selectedLabels = [];

  void _onLabelsSelected(List<String> labels) {
    setState(() {
      selectedLabels = labels;
    });
  }

  void _onHairSelected(String value) {
    setState(() {
      tipoCabello = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var title = width * 0.07;
    var text = width * 0.05;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height * .8,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * .05, horizontal: width * .1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Bienvenido",
                    style: TextStyle(
                      fontSize: title,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: height * .02),
                  Text(
                    "Configura tus preferencias para una experiencia personalizada",
                    style: TextStyle(
                      fontSize: text,
                      color: AppColors.backColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * .03),
                  CustomLabelAutocomplete(
                    onSelected: _onLabelsSelected,
                  ),
                  SizedBox(height: height * .03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildChoiceChip('Usa Lentes', conLentes, (value) {
                        setState(() {
                          conLentes = value!;
                        });
                      }),
                      _buildChoiceChip('Cara Ovalada', conCaraOvalada, (value) {
                        setState(() {
                          conCaraOvalada = value!;
                        });
                      }),
                      _buildChoiceChip('Piel Blanca', conPielBlanca, (value) {
                        setState(() {
                          conPielBlanca = value!;
                        });
                      }),
                    ],
                  ),
                  CustomLabelHairColorAutocomplete(onSelected: (value) {
                    setState(() {
                      colorCabello = value;
                    });
                  }),
                  CustomLabelHairAutocomplete(onSelected: (value) {
                    setState(() {
                      tipoCabello = value;
                    });
                  }),
                  CustomLabelSexAutocomplete(
                    onSelected: (value) {
                      setState(() {
                        sexoPreferido = value;
                      });
                    },
                  ),
                  SizedBox(height: height * .05),
                  CustomButton(
                    textValue: "Guardar Preferencias",
                    onPressed: () async {
                      var data = {
                        'etiquetas': selectedLabels,
                        'conLentes': conLentes,
                        'conCaraOvalada': conCaraOvalada,
                        'conPielBlanca': conPielBlanca,
                        'colorCabello': colorCabello,
                        'tipoCabello': tipoCabello,
                        'sexoPreferido': sexoPreferido,
                      };
                      bool response = await _update(data);
                      if (response) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavBar(),
                          ),
                          (Route<dynamic> route) =>
                              false, // Esto elimina todas las rutas anteriores
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Preferencias guardadas'),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Error al guardar preferencias'),
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

Widget _buildChoiceChip(
    String title, bool value, ValueChanged<bool> onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: ChoiceChip(
      label: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: value ? Colors.white : AppColors.primaryColor,
        ),
      ),
      selected: value,
      onSelected: onChanged,
      selectedColor: AppColors.accentColor,
      backgroundColor: AppColors.backgroundColor.withOpacity(0.1),
      labelPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: value ? AppColors.accentColor : AppColors.primaryColor,
        ),
      ),
    ),
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
