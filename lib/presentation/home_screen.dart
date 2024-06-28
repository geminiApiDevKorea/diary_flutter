import 'package:diary_flutter/presentation/home_body.dart';
import 'package:diary_flutter/presentation/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: HomeBottomNavigationBar(),
      body: HomeBody(),
    );
  }
}
