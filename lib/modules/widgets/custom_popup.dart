import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget content;
  final VoidCallback? onTap;

  const CustomPopup({
    Key? key,
    required this.title,
    required this.subTitle,
    this.onTap,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 0, right: 15, left: 15, bottom: 15),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: content,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
