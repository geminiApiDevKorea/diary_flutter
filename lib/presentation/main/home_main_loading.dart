import 'package:flutter/material.dart';

class HomeMainLoading extends StatelessWidget {
  const HomeMainLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
