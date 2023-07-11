import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
      {Key? key, required this.hint, this.onChanged, this.obscureText = false})
      : super(key: key);
  String? hint;
  bool obscureText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return 'field is required';
          }
        },
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
