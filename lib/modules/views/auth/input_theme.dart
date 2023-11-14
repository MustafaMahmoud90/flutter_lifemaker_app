import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormTheme extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final TextInputType type;
  bool? isPassword;

  FormTheme({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.type,
    this.isPassword,
  }) : super(key: key);

  @override
  _FormThemeState createState() => _FormThemeState();
}

class _FormThemeState extends State<FormTheme> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      validator: (input) {
        if (widget.controller.text.isEmpty) {
          return "يجب ادخال ${widget.hintText}";
        } else {
          return null;
        }
      },
      obscureText: (widget.isPassword == true) && !isPasswordVisible,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        fillColor: const Color(0xff0E395E),
        focusColor: const Color(0xff0E395E),
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xffD6D6D6)),
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        prefixIcon: Icon(
          widget.icon,
          color: const Color(0xff0E395E),
        ),
        suffixIcon: (widget.isPassword == true)
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                child: Icon(
                  isPasswordVisible
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash,
                  color: const Color(0xff0E395E),
                ),
              )
            : null, // Don't show suffix icon for non-password fields
      ),
    );
  }
}
