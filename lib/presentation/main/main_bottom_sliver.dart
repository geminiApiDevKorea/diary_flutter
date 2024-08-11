import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/common/extension/date_time_extension.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/common/provider/primitive_notifiers.dart';
import 'package:diary_flutter/presentation/main/main_carousel_sliver.dart';
import 'package:diary_flutter/presentation/main/main_horizontal_carousel.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainBottomContentSliver extends ConsumerWidget {
  const MainBottomContentSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;

    final screenHeight = MediaQuery.of(context).size.height;

    return SliverToBoxAdapter(
      child: Container(
        height: screenHeight - MainCarouselSliver.carouselHeight,
        color: colors.primary100,
        child: const BottomContentConsumer(),
      ),
    );
  }
}

class BottomContentConsumer extends ConsumerWidget {
  const BottomContentConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carouselIndex = ref.watch(intNotifierProvider(key: "carouselIndex"));

    final allMyJournals = ref.watch(getAllMyJournalsProvider);
    final sortedMyJournals = allMyJournals.sortByDateDescending();

    if (sortedMyJournals.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentJournal = sortedMyJournals[carouselIndex];
    final scrollPosition = ref.watch(doubleNotifierProvider(key: 'mainScroll'));

    return BottomTitleContainer(
      journal: currentJournal,
      isVisible: scrollPosition > 350,
    );
  }
}

class BottomTitleContainer extends ConsumerWidget {
  final Journal journal;
  final bool isVisible;

  const BottomTitleContainer({
    super.key,
    required this.journal,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(left: 36),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Visibility(
          visible: isVisible,
          child: BottomTitle(journal: journal),
        ),
      ),
    );
  }
}

class BottomTitle extends ConsumerWidget {
  final Journal journal;

  const BottomTitle({
    super.key,
    required this.journal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;

    // final bottomTitle =
    //     journal.title ?? "Draft of \n${journal.createdAt.monthDayOrdinal}";

    return Container(
      // color: Colors.amber,
      width: MainHorizontalCarousel.cardWidth,
      height: MainHorizontalCarousel.circleDiameter / 2,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: colors.primary100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 4),
          Text(
            journal.title ?? "Draft of \n${journal.createdAt.monthDayOrdinal}",
            style: textStyle.h1
                .withColor(colors.grayScale0)
                .withFontSize(28)
                .withHeight(1.4),
            textAlign: TextAlign.left,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Text(
            '${journal.createdAt.fullDateOrdinal} · ${journal.feedbackType.value.capitalize()}',
            style: textStyle.button.withColor(colors.caption),
          )
        ],
      ),
    );
  }
}
