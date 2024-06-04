import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class CustomGenderAutocomplete extends StatelessWidget {
  // final List<String> suggestions;
  final ValueChanged<String> onSelected;

  CustomGenderAutocomplete({
    // required this.suggestions,
    required this.onSelected,
  });

  var suggestions = [
    "Heterosexual",
    "Gay",
    "Lesbiana",
    "Bisexual",
    "Pansexual",
    "Asexual",
    "Demisexual",
    "Polisexual",
    "Sapiosexual",
    "Queer",
    "Intersexual",
    "Transexual",
    "No binario",
    "Prefiero no responder"
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Orientación sexual",
          style: TextStyle(
            fontSize: text,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            return suggestions.where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String value) {
            onSelected(value);
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.fromLTRB(width * .05, 0, 10, width * .05),
                hintText: 'Ingresa tu sexo',
                hintStyle: TextStyle(
                    color: AppColors.shadeColor, //
                    fontWeight: FontWeight.normal,
                    fontSize: text * 0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: AppColors.backColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.accentColor),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<String> onSelected,
              Iterable<String> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: height * .1,
                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final option = options.elementAt(index);
                      return ListTile(
                        title: Text(option),
                        onTap: () {
                          onSelected(option);
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}