import 'package:flutter/material.dart';

class HomeMainTab extends StatefulWidget {
  const HomeMainTab({super.key});

  @override
  State<HomeMainTab> createState() => _HomeMainTabState();
}

class _HomeMainTabState extends State<HomeMainTab> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: '일기를 작성하고 음악을 추천받아 보세요.',
                  prefixIcon: Icon(Icons.smart_button_rounded),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _controller.clear(),
              child: const Text('음악 추천'),
            ),
          ],
        ),
      ),
    );
  }
}
