import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarScreen extends ConsumerWidget {
  static const String path = '/calendar';
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    const weeks = 6;
    return Scaffold(
      backgroundColor: colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 13.0,
        ),
        child: Column(
          children: [
            Placeholder(
              color: colors.placeholder,
              child: const SizedBox(
                width: double.infinity,
                height: 44,
                child: Center(
                  child: Text('년도와 월 컨트롤러 영역'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Placeholder(
              color: colors.placeholder,
              child: const SizedBox(
                width: double.infinity,
                height: 52,
                child: Center(
                  child: Text('일주일 타이틀 영역'),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 52.0 * weeks,
              child: Column(
                children: [
                  for (var i = 0; i < weeks; i++)
                    Placeholder(
                      color: colors.placeholder,
                      child: const SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: Center(
                          child: Text('주간 날짜 영역'),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
