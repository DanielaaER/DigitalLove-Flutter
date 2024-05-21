import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomTextListLabels extends StatefulWidget {
  final String textValue;
  final TextEditingController controller;
  final List<String> list;

  const CustomTextListLabels({
    required this.textValue,
    required this.controller,
    required this.list,
  });

  @override
  _CustomTextListLabelsState createState() => _CustomTextListLabelsState();
}

class _CustomTextListLabelsState extends State<CustomTextListLabels> {
  late List<String> filteredData;
  late List<bool> selectedItems;

  _loadCities() {
    filteredData = List.from(widget.list);
    selectedItems = List.generate(widget.list.length, (index) => false);
  }

  @override
  void initState() {
    super.initState();
    _loadCities();
    widget.controller.addListener(_updateTextField);
  }

  void _updateTextField() {
    // Reconstruir el texto completo cada vez que se actualiza la lista de selecciones
    String newText = '';
    for (int i = 0; i < filteredData.length; i++) {
      if (selectedItems[i]) {
        newText += filteredData[i] + ', ';
      }
    }
    widget.controller.text =
        newText.isNotEmpty ? newText.substring(0, newText.length - 2) : '';
  }

  void _filterCities() {
    setState(() {
      filteredData = widget.list
          .where((city) =>
              city.toLowerCase().contains(widget.controller.text.toLowerCase()))
          .toList();

      // Ajustar la lista de elementos seleccionados basada en la longitud de los datos filtrados
      if (filteredData.length != selectedItems.length) {
        selectedItems = List.generate(filteredData.length, (index) => false);
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateTextField);
    widget.controller.dispose();
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
          widget.textValue,
          style: TextStyle(
            fontSize: text,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 0.05,
        ),
        TextField(
          controller: widget.controller,
          onChanged: (value) {
            _filterCities();
          },
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.fromLTRB(width * .05, 0, 10, width * .05),
            hintText: 'Ingresa tu ${widget.textValue}',
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
        ),
        if (filteredData.isNotEmpty)
          Wrap(
            children: List.generate(filteredData.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ActionChip(
                  label: Text(filteredData[index]),
                  backgroundColor: selectedItems[index] ? Colors.blue : null,
                  onPressed: () {
                    setState(() {
                      selectedItems[index] = !selectedItems[index];
                      _updateTextField();
                    });
                  },
                ),
              );
            }),
          ),
      ],
    );
  }
}
