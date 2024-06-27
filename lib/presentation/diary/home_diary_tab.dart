import 'package:diary_flutter/domain/provider/archived_diaries.dart';
import 'package:diary_flutter/presentation/common/text_theme_getter_mixin.dart';
import 'package:diary_flutter/presentation/diary/archived_diary_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDiaryTab extends ConsumerWidget with TextThemeGetterMixin {
  const HomeDiaryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archivedDiaries = ref.watch(archivedDiariesProvider);
    if (archivedDiaries.isEmpty) {
      return Center(
        child: Text(
          'No archived diaries',
          style: textTheme(context).headlineMedium,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: ListView.separated(
          itemCount: archivedDiaries.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: double.infinity,
              height: 16,
            );
          },
          itemBuilder: (context, index) =>
              ArchivedDiaryItem(diary: archivedDiaries[index]),
        ),
      );
    }
  }
}
