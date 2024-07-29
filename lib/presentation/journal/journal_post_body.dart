import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostJournalBody extends ConsumerWidget {
  const PostJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
                height: 900,
                color: colors.grayScale90,
                child: const Center(child: Text('Post Journal Body'))),
          ],
        ));
  }
}
