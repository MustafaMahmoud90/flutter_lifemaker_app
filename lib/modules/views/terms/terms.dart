import 'package:flutter/material.dart';

class TermsWidget extends StatelessWidget {
  final String text;

  const TermsWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 27),
      // color: const Color(0xffE9791E),
      // semanticContainer: true,
      // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xffE9791E),
            radius: 7,
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 2,
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Color(0xff0E395E),
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
