import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String textValue;
  final VoidCallback onPressed;
  final bool enabled;
  final bool loading;

  const CustomButton({
    required this.textValue,
    required this.onPressed,
    this.enabled = true,
    this.loading = false,
  }); // Constructor

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return Container(
      width: width * .5,
      height: height * .052,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: enabled
            ? LinearGradient(
          colors: [AppColors.accentColor, AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
      ),
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: loading
            ? SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(
          textValue,
          style: TextStyle(
            fontSize: 18,
            color: enabled ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
