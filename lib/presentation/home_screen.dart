import 'package:diary_flutter/common/types.dart';
import 'package:diary_flutter/presentation/home/home_body.dart';
import 'package:diary_flutter/presentation/home/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final HomeNavigationNotifier homeNavigationNotifier;
  const HomeScreen({super.key, required this.homeNavigationNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HomeBottomNavigationBar(
        homeNavigationNotifier: homeNavigationNotifier,
      ),
      body: HomeBody(
        homeNavigationNotifier: homeNavigationNotifier,
      ),
    );
  }
}
