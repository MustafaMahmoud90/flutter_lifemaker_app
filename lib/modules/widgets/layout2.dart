import 'package:flutter/material.dart';
import 'package:lifemaker/modules/views/home/home.dart';

class LayoutMaker2 extends StatelessWidget {
  const LayoutMaker2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff0E395E),
        ),
        child: const Stack(
          children: [
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
