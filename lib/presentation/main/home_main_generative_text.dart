import 'package:flutter/material.dart';

class HomeMainGenerativeText extends StatelessWidget {
  final String generativeText;
  const HomeMainGenerativeText(this.generativeText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: SelectionArea(
        child: Text(generativeText),
      ),
    );
  }
}
