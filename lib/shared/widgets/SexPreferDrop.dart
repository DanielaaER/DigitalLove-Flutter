import 'package:digital_love/presentation/Home/Pages/Welcome/welcomeScreen.dart';
import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

class CustomLabelSexAutocomplete extends StatefulWidget {
  final ValueChanged<String> onSelected;

  CustomLabelSexAutocomplete({
    required this.onSelected,
  });

  @override
  _CustomLabelSexAutocompleteState createState() =>
      _CustomLabelSexAutocompleteState();
}

class _CustomLabelSexAutocompleteState
    extends State<CustomLabelSexAutocomplete> {
  var suggestions = ['MASCULINO', 'FEMENINO', 'AMBOS'];
  String selectedLabels = "MASCULINO";
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _showOptions = false;

  void _onSelected(String value) {
    setState(() {
      if (!selectedLabels.contains(value)) {
        selectedLabels = value;
        _textEditingController.clear();
        widget.onSelected(selectedLabels);
        _focusNode.unfocus();
        _showOptions = false;
      }
    });
  }

  void _removeLabel(String label) {
    setState(() {
      selectedLabels = "MASCULINO";
      widget.onSelected(selectedLabels);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var text = width * 0.05;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Sexo preferido",
          style: TextStyle(
            fontSize: text,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        // Agregar espacio entre el texto y los chips
        Wrap(spacing: 6.0, runSpacing: 6.0, children: [
          Chip(
            label: Text(selectedLabels),
            onDeleted: () => _removeLabel(selectedLabels),
          )
        ]),

        SizedBox(height: 8.0),
        // Agregar espacio entre los chips y el Autocomplete
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            return suggestions.where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String value) {
            _onSelected(value);
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            _textEditingController = textEditingController;
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.fromLTRB(width * .05, 0, 10, width * .05),
                hintText: 'Ingresa tus preferencias',
                hintStyle: TextStyle(
                    color: AppColors.shadeColor,
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
                  height: height * .3,
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
        ),
      ],
    );
  }
}
