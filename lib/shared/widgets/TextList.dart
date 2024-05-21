import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomTextList extends StatefulWidget {
  final String textValue;
  final TextEditingController controller;
  final List<String> list;

  const CustomTextList({
    required this.textValue,
    required this.controller,
    required this.list,
  });

  @override
  _CustomTextListState createState() => _CustomTextListState();
}

class _CustomTextListState extends State<CustomTextList> {
  late List<String> filteredData;

  _loadCities() {
    filteredData = List.from(widget.list);
  }

  @override
  void initState() {
    super.initState();
    _loadCities();
    widget.controller.addListener(_filterCities);
  }

  void _filterCities() {
    setState(() {
      filteredData = widget.list
          .where((city) =>
              city.toLowerCase().contains(widget.controller.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_filterCities);
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
          Container(
            constraints: BoxConstraints(
              maxHeight:
                  height * .1, // Establece una altura máxima para el contenedor
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.backColor),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredData[index]),
                  onTap: () {
                    setState(() {
                      widget.controller.text = filteredData[index];
                      filteredData.clear();
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
