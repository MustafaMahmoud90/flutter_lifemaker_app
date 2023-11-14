import 'package:flutter/material.dart';


void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1100),
      reverseTransitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return const ZoomPageTransitionsBuilder().buildTransitions(
          MaterialPageRoute(builder: (context) => screen),
          context,
          animation,
          secondaryAnimation,
          child,
        );
      },
    ),
  );
}

