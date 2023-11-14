import 'package:flutter/material.dart';

class BtnTheme extends StatelessWidget {
  final Color color;
  final String text;
  final TextStyle? style;
  final VoidCallback? ontap;

  const BtnTheme(
      {super.key,
      required this.color,
      this.style,
      required this.text,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.maxFinite,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color:
          const Color(0xffE9791E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Alamiri',
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
