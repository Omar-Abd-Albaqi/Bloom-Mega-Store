import 'package:flutter/material.dart';

import '../../../../constants.dart';

class TextWithBackground extends StatelessWidget {
  final String text;

  const TextWithBackground({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: Text.rich(
          TextSpan(
            text: text,
            style: const TextStyle(
              fontFamily: grandisExtendedFont,
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.black,
              backgroundColor: Color.fromARGB(120, 255, 255, 255), // white semi-transparent
            ),
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}