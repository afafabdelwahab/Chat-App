import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, required this.text, this.onPressed})
      : super(key: key);
  String? text;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Center(
        child: Text(
          '$text',
          style: TextStyle(
            color: Color(0xff2B475E),
            fontSize: 18,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        fixedSize: Size(double.maxFinite, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
