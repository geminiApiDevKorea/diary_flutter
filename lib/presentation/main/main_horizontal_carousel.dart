import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/common/extension/date_time_extension.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/common/provider/primitive_notifiers.dart';
import 'package:diary_flutter/presentation/common/router.dart';
import 'package:diary_flutter/presentation/journal/journal_screen.dart';

import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';
// Import other necessary dependencies

class MainHorizontalCarousel extends ConsumerWidget {
  final double carouselHeight;
  static double circleDiameter = 280;
  static double cardWidth = 329;

  const MainHorizontalCarousel({super.key, required this.carouselHeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allMyJournals = ref.watch(getAllMyJournalsProvider);
    final sortedMyJournals = allMyJournals.sortByDateDescending();
    final scrollPosition = ref.watch(doubleNotifierProvider(key: 'mainScroll'));
    final currentIndex = ref.watch(intNotifierProvider(key: "carouselIndex"));
    if (sortedMyJournals.isEmpty) {
      return EmptyCarouselMessage(
        carouselHeight: carouselHeight,
      );
    }

    return CarouselContainer(
      carouselHeight: carouselHeight,
      child: CustomCarousel(
        onSelectedItemChanged: (index) =>
            _updateCarouselIndex(ref, index, sortedMyJournals.length),
        depthOrder: DepthOrder.reverse,
        itemCountBefore: 0,
        itemCountAfter: _calculateItemCountAfter(allMyJournals.length),
        alignment: Alignment.bottomCenter,
        scrollDirection: Axis.horizontal,
        tapToSelect: false,
        effectsBuilder: (index, ratio, child) =>
            _buildCarouselEffects(index, ratio, child),
        children: _buildCarouselItems(
            context, ref, sortedMyJournals, scrollPosition, currentIndex),
      ),
    );
  }

  void _updateCarouselIndex(WidgetRef ref, int index, int journalsLength) {
    Print.white(
        'Raw index: $index, Journals length: $journalsLength'); // Debug print

    if (journalsLength == 0) {
      Print.red('Warning: No journals available');
      return;
    }

    // Ensure index is within valid range
    final safeIndex = index.clamp(0, journalsLength - 1);

    Print.cyan('Safe index: $safeIndex'); // Debug print

    if (safeIndex != index) {
      Print.yellow('Index was adjusted from $index to $safeIndex');
    }

    try {
      ref
          .read(intNotifierProvider(key: "carouselIndex").notifier)
          .setValue(safeIndex);

      Print.green('Carousel index updated successfully');
    } catch (e) {
      Print.red('Error updating carousel index: $e');
    }
  }

  int _calculateItemCountAfter(int journalsCount) {
    return journalsCount > 2 ? 2 : (journalsCount == 2 ? 1 : 0);
  }

  Widget _buildCarouselEffects(int index, double ratio, Widget child) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, -ratio * 127, 0)
        ..scale(1 - ratio.abs() * 0.15),
      alignment: Alignment.center,
      child: child,
    );
  }

  List<Widget> _buildCarouselItems(BuildContext context, WidgetRef ref,
      List<Journal> journals, double scrollPosition, int currentIndex) {
    return List.generate(
      journals.length,
      (index) {
        int relativeIndex = (index - currentIndex).abs();
        return JournalCard(
          journal: journals[index],
          isRevealed: scrollPosition >= 350,
          relativeIndex: relativeIndex,
        );
      },
    );
  }
}

class EmptyCarouselMessage extends ConsumerWidget {
  final double carouselHeight;

  const EmptyCarouselMessage({
    super.key,
    required this.carouselHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;

    return Container(
      height: carouselHeight,
      padding: const EdgeInsets.only(bottom: 20),
      color: colors.primary100,
      child: Center(
        child: Text(
          'The box is empty',
          style: textStyle.h4.withColor(colors.caption),
        ),
      ),
    );
  }
}

class CarouselContainer extends ConsumerWidget {
  final double carouselHeight;

  final Widget child;

  const CarouselContainer({
    super.key,
    required this.carouselHeight,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;

    return Container(
      height: carouselHeight,
      padding: const EdgeInsets.only(bottom: 20),
      color: colors.primary100,
      child: child,
    );
  }
}

class JournalCard extends ConsumerWidget {
  final Journal journal;
  final bool isRevealed;
  final int relativeIndex;

  const JournalCard({
    super.key,
    required this.journal,
    required this.isRevealed,
    required this.relativeIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final cardColor = _getCardColor(colors);

    final imgUrl = journal.music?.thumbnailUrl;
    final journalTitle = journal.title;
    final createdAt = journal.createdAt;
    final feedbackType = journal.feedbackType;
    final hasFeedback = ref.watch(hasFeedbackProvider(createdAt));
    final formattedSongTitle = journal.song?.title.formattedSongTitle ?? '';
    final formattedSinger = journal.song?.singer.formattedSinger ?? '';

    return AspectRatio(
      aspectRatio: 1,
      child: Align(
        child: Container(
          width: MainHorizontalCarousel.cardWidth,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              SongInfo(
                formattedSongTitle: formattedSongTitle,
                formattedSinger: formattedSinger,
              ),
              const SizedBox(height: 11),
              Expanded(
                child: JournalCardContent(
                  imgUrl: imgUrl,
                  isRevealed: isRevealed,
                  hasFeedback: hasFeedback,
                  feedbackType: feedbackType,
                  journalTitle: journalTitle,
                  createdAt: createdAt,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCardColor(GemColors colors) {
    switch (relativeIndex) {
      case 0:
        return colors.grayScale100;
      case 1:
        return colors.grayScale90;
      default:
        return colors.grayScale80;
    }
  }
}

class SongInfo extends ConsumerWidget {
  final String formattedSongTitle;
  final String formattedSinger;

  const SongInfo({
    super.key,
    required this.formattedSongTitle,
    required this.formattedSinger,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    return Text(
      '♫ $formattedSongTitle - $formattedSinger',
      style: textStyle.caption.withColor(colors.grayScale40),
    );
  }
}

class JournalCardContent extends ConsumerWidget {
  final String? imgUrl;
  final bool isRevealed;
  final bool hasFeedback;
  final FeedbackType feedbackType;
  final String? journalTitle;
  final DateTime createdAt;

  const JournalCardContent({
    super.key,
    required this.imgUrl,
    required this.isRevealed,
    required this.hasFeedback,
    required this.feedbackType,
    required this.journalTitle,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        JournalImage(imgUrl: imgUrl),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isRevealed
              ? (hasFeedback
                  ? ViewButton(feedbackType: feedbackType, createdAt: createdAt)
                  : EditButton(
                      feedbackType: feedbackType,
                      createdAt: createdAt,
                    ))
              : JournalTitleContainer(
                  feedbackType: feedbackType,
                  journalTitle: journalTitle,
                  createdAt: createdAt,
                ),
        ),
      ],
    );
  }
}

class JournalImage extends StatelessWidget {
  final String? imgUrl;

  const JournalImage({super.key, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return imgUrl != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: CachedNetworkImage(
              imageUrl: imgUrl!,
              width: MainHorizontalCarousel.circleDiameter,
              height: MainHorizontalCarousel.circleDiameter,
              fit: BoxFit.cover,
              placeholder: (context, url) => const BlankCircleWidget(),
              errorWidget: (context, url, error) => const BlankCircleWidget(),
            ),
          )
        : const BlankCircleWidget();
  }
}

class ViewButton extends ConsumerWidget {
  final FeedbackType feedbackType;
  final DateTime createdAt;

  const ViewButton({
    super.key,
    required this.feedbackType,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    return SizedBox(
      width: 158,
      height: 31,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.subButtonBackground,
        ),
        key: const ValueKey('view_button'),
        onPressed: () async {
          await ref.read(focusedDateProvider.notifier).updateDate(createdAt);
          if (context.mounted) {
            await context.pushNamed(JournalScreen.name, queryParameters: {
              QueryParameterKeys.feedbackType.value: feedbackType.value,
            });
          }
        },
        child: Text(
          'View',
          style: textStyle.button.copyWith(color: colors.grayScale40),
        ),
      ),
    );
  }
}

class EditButton extends ConsumerWidget {
  final FeedbackType feedbackType;
  final DateTime createdAt;

  const EditButton({
    super.key,
    required this.feedbackType,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    return SizedBox(
      width: 158,
      height: 31,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.subButtonBackground,
        ),
        key: const ValueKey('edit_button'),
        onPressed: () async {
          await ref.read(focusedDateProvider.notifier).updateDate(createdAt);
          if (context.mounted) {
            await context.pushNamed(JournalScreen.name, queryParameters: {
              QueryParameterKeys.feedbackType.value: feedbackType.value,
            });
          }
        },
        child: Text(
          'Edit',
          style: textStyle.button.copyWith(color: colors.grayScale40),
        ),
      ),
    );
  }
}

class JournalTitleContainer extends ConsumerWidget {
  final String? journalTitle;
  final DateTime createdAt;
  final FeedbackType feedbackType;

  const JournalTitleContainer({
    super.key,
    required this.journalTitle,
    required this.createdAt,
    required this.feedbackType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    return SizedBox(
      key: const ValueKey('journal_container'),
      width: MainHorizontalCarousel.cardWidth,
      height: MainHorizontalCarousel.cardWidth,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MainHorizontalCarousel.cardWidth,
          height: MainHorizontalCarousel.cardWidth / 2,
          decoration: BoxDecoration(
            color: colors.grayScale100,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(125),
              bottomRight: Radius.circular(125),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                journalTitle ?? "Draft of \n${createdAt.monthDayOrdinal}",
                style: textStyle.h1
                    .withColor(colors.text)
                    .withFontSize(28)
                    .withHeight(1.4),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              Text(
                '${createdAt.fullDateOrdinal} · ${feedbackType.value.capitalize()}',
                style: textStyle.button.withColor(colors.caption),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BlankCircleWidget extends StatelessWidget {
  const BlankCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MainHorizontalCarousel.circleDiameter,
      height: MainHorizontalCarousel.circleDiameter,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey, // You can adjust this color as needed
      ),
    );
  }
}
