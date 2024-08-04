import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/auth/get_my_name.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/presentation/calendar/calendar_screen.dart';
import 'package:diary_flutter/presentation/journal/journal_music_card.dart';
import 'package:diary_flutter/presentation/journal_screen.dart';
import 'package:diary_flutter/presentation/main/provider/main_screen_scroll_position.dart';
import 'package:diary_flutter/presentation/main/use_is_top_of_stack.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

class MainScreen extends HookConsumerWidget {
  static const String path = '/main';
  static const String name = 'main';
  static const double carouselHeight = 490.0 + kToolbarHeight;

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 300));
    // final isDarkening = useState(false);
    final darkeningAnimationContorller = useAnimationController(
        duration: const Duration(milliseconds: 300), initialValue: 0.0);

    useStackAnimation(
      isTopOfStack: useIsTopOfStack(context),
      animationController: animationController,
      // isDarkening: isDarkening,
    );
    // final scrollPosition = ref.watch(mainScrollPositionProvider);

    // final opacityController = useAnimationController(
    //   duration: const Duration(milliseconds: 300),
    //   initialValue: 1.0,
    // );
    // useEffect(() {
    //   final opacity = ((scrollPosition / (carouselHeight - kToolbarHeight))
    //       .clamp(0.0, 1.0));

    //   opacityController.animateTo(1 - opacity,
    //       duration: const Duration(milliseconds: 100));
    //   return null;
    // }, [scrollPosition]);

    // useEffect(() {
    //   if (scrollPosition > 86) {
    //     isVisible.value = false;
    //   } else {
    //     isVisible.value = true;
    //   }
    //   return null;
    // }, [scrollPosition]);

    return Animate(
      effects: [
        TintEffect(
          curve: Curves.easeInOut,
          begin: 0,
          end: 1,
          color: Colors.black.withOpacity(0.2),
          duration: TransitionDuration.short.value,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          begin: const Offset(0, 0),
          end: const Offset(-40, 0),
          duration: TransitionDuration.short.value,
        ),
      ],
      controller: darkeningAnimationContorller,
      target: 0,
      child: Container(
        color: colors.primary100,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            floatingActionButton: MainFloatingActionButton(
                animationController: animationController),
            body: MainBody(
              // isDarkening: isDarkening,
              animationController: animationController,
              darkeningAnimationContorller: darkeningAnimationContorller,
            ),
          ),
        ),
      ),
    );
  }
}

class MainFloatingActionButton extends HookConsumerWidget {
  final AnimationController animationController;

  const MainFloatingActionButton(
      {super.key, required this.animationController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    return SizedBox(
      height: 52,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'floating',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: SizedBox(
                    width: 140,
                    height: 36,
                    child: ElevatedButton.icon(
                      onPressed: () => context.go(CalendarScreen.path),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.grayScale80.withOpacity(0.8),
                        foregroundColor: colors.grayScale80,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      label: AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) => FadeTransition(
                          opacity: animationController,
                          child: child,
                        ),
                        child: Text(
                          'Calendar',
                          style: textStyle.button
                              .copyWith(color: colors.grayScale0),
                        ),
                      ),
                      icon: Icon(CupertinoIcons.back,
                          size: 18, color: colors.grayScale50),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  Print.red("일기 전부삭제");
                  ref.read(myJournalStoreProvider.notifier).deleteAllJournals();
                },
                child: Text(
                  "일기삭제",
                  style: textStyle.button.withColor(colors.error),
                )),
            TextButton(
                onPressed: () {
                  Print.cyan("더미 일기 생성");
                  ref
                      .read(myJournalStoreProvider.notifier)
                      .createDummyJournal();
                },
                child: Text("일기생성",
                    style: textStyle.button.withColor(colors.caption)))
          ],
        ),
      ),
    );
  }
}

class MainBody extends HookConsumerWidget {
  static const double carouselHeight = 490.0 + kToolbarHeight;
  // final double carouselHeight;
  // final ValueNotifier<bool> isDarkening;
  final AnimationController animationController;
  final AnimationController darkeningAnimationContorller;

  const MainBody({
    super.key,
    // required this.carouselHeight,
    // required this.isDarkening,
    required this.animationController,
    required this.darkeningAnimationContorller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useMainScrollController(ref);
    final scrollPosition = ref.watch(mainScrollPositionProvider);

    Print.white(scrollPosition.toString());

    return CustomScrollView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: MainHeader(
            // isDarkening: isDarkening,
            animationController: animationController,
            darkeningAnimationContorller: darkeningAnimationContorller,
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            minHeight: carouselHeight,
            maxHeight: carouselHeight,
            child: const CustomHorizontalCarousel(
              carouselHeight: carouselHeight,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.height - carouselHeight,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class MainHeader extends HookConsumerWidget {
  // final ValueNotifier<bool> isDarkening;
  final AnimationController animationController;
  final AnimationController darkeningAnimationContorller;

  const MainHeader({
    super.key,
    // required this.isDarkening,
    required this.animationController,
    required this.darkeningAnimationContorller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    final myName = ref.read(getMyNameProvider);

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: colors.primary100,
        height: 314,
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good Evening, $myName",
                style: textStyle.paragraph.withColor(colors.grayScale60)),
            Text("How was\n your day?", style: textStyle.h1),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainHeaderButton(
                  text: 'Chat to record',
                  onTap: () async {
                    darkeningAnimationContorller.forward();
                    animationController.value = 0.0;
                    await ref.read(focusedDateProvider.notifier).resetToToday();
                    if (context.mounted) {
                      await context
                          .pushNamed(JournalScreen.name, queryParameters: {
                        'type': 'chat',
                      });
                    }

                    darkeningAnimationContorller.reverse();
                  },
                ),
                MainHeaderButton(
                  text: 'Add a new record',
                  onTap: () async {
                    darkeningAnimationContorller.forward();
                    animationController.value = 0.0;
                    await ref.read(focusedDateProvider.notifier).resetToToday();
                    if (context.mounted) {
                      await context
                          .pushNamed(JournalScreen.name, queryParameters: {
                        'type': 'post',
                      });
                    }

                    darkeningAnimationContorller.reverse();
                  },
                ),
                // _buildButton(context, 'Chat to record', 'chat', ref),
                // _buildButton(context, 'Add a new record', 'post', ref),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildButton(
  //     BuildContext context, String text, String type, WidgetRef ref) {
  //   final textStyle = ref.gemTextStyle;
  //   final colors = ref.gemColors;

  //   return Material(
  //     color: colors.grayScale80,
  //     borderRadius: BorderRadius.circular(32),
  //     child: InkWell(
  //       borderRadius: BorderRadius.circular(32),
  //       onTap: () async {
  //         // isDarkening.value = true;

  //         darkeningAnimationContorller.forward();
  //         animationController.value = 0.0;
  //         await context
  //             .pushNamed(JournalScreen.name, queryParameters: {'type': type});
  //         // isDarkening.value = false;
  //         darkeningAnimationContorller.reverse();
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6.0),
  //         child: SizedBox(
  //           height: 31,
  //           width: 130,
  //           child: Align(
  //             alignment: Alignment.center,
  //             child: Text(
  //               text,
  //               textAlign: TextAlign.center,
  //               style: textStyle.paragraph.copyWith(color: colors.grayScale0),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

void useStackAnimation({
  required bool isTopOfStack,
  required AnimationController animationController,
  // required ValueNotifier<bool> isDarkening,
}) {
  useEffect(() {
    if (isTopOfStack) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 300), () {
          // isDarkening.value = false;
          animationController.forward(from: 0.0);
        });
      });
    }
    return null;
  }, [isTopOfStack]);
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  bool _wasAtTop = false;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //FIXME: 59??
    if (shrinkOffset >= 59 && !_wasAtTop) {
      _wasAtTop = true;
      // ignore: avoid_print
      print('SliverPersistentHeader reached the top of the screen');
    } else if (shrinkOffset < 59 && _wasAtTop) {
      _wasAtTop = false;
      // print('SliverPersistentHeader is no longer at the top of the screen');
    }
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CustomHorizontalCarousel extends ConsumerWidget {
  final double carouselHeight;
  const CustomHorizontalCarousel({super.key, required this.carouselHeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final allMyJournalswithMusicandSong =
    //     ref.watch(getJournalsWithMusicAndSongProvider);
    final allMyJournals = ref.watch(getAllMyJournalsProvider);
    // 저널이 없는 경우 텍스트 위젯 반환
    final scrollPosition = ref.watch(mainScrollPositionProvider);
    if (allMyJournals.isEmpty) {
      return Container(
        height: carouselHeight,
        padding: const EdgeInsets.only(bottom: 20),
        color: Colors.amber,
        child: const Center(
          child: Text(
            'No journals with music and song available',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Container(
      height: carouselHeight,
      padding: const EdgeInsets.only(bottom: 20),
      color: Colors.amber,
      child: CustomCarousel(
        depthOrder: DepthOrder.reverse,
        itemCountBefore: 0,
        itemCountAfter:
            allMyJournals.length > 2 ? 2 : (allMyJournals.length == 2 ? 1 : 0),
        alignment: Alignment.bottomCenter,
        scrollDirection: Axis.horizontal,
        tapToSelect: false,
        effectsBuilder: (index, ratio, child) {
          // print('index: $index, ratio: $ratio');

          return Transform(
            transform: Matrix4.identity()
              ..translate(0.0, -ratio * 127, 0)
              ..scale(1 - ratio.abs() * 0.2),
            alignment: Alignment.center,
            child: Opacity(
              opacity: 1 - ratio.abs() * 0.2,
              child: child,
            ),
          );
        },
        children: List.generate(
          allMyJournals.length,
          (index) => _buildCard(context, ref,
              index: index,
              musicTitle: allMyJournals[index].song?.title ?? '',
              singer: allMyJournals[index].song?.singer ?? '',
              imgUrl: allMyJournals[index].music?.thumbnailUrl,
              journalTitle: allMyJournals[index].title,
              isRevealed: scrollPosition >= 350 //FIXME: 숫자멋대로
              // index,
              // allMyJournals[index].music?.title ?? 'Draft',
              // // 'https://picsum.photos/200/200?random=$index'
              // allMyJournals[index].music?.thumbnailUrl,
              ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, WidgetRef ref,
      {required int index,
      required String musicTitle,
      required String singer,
      required String? imgUrl,
      required String? journalTitle,
      required bool isRevealed}) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    return AspectRatio(
      aspectRatio: 1,
      child: Align(
        child: Container(
          width: 329,
          decoration: BoxDecoration(
            color: colors.grayScale100,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$musicTitle $singer',
                style: textStyle.caption.withColor(colors.grayScale40),
              ),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  // 이미지
                  imgUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: CachedNetworkImage(
                            imageUrl: imgUrl,
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const BlurredCircleWidget(),
                            errorWidget: (context, url, error) =>
                                const BlurredCircleWidget(),
                          ),
                        )
                      : const BlurredCircleWidget(),

                  // AnimatedSwitcher를 사용하여 컨테이너와 버튼 사이의 전환
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isRevealed
                        ? ElevatedButton(
                            key: const ValueKey('play_button'),
                            onPressed: () {
                              // 버튼 동작 추가
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(20),
                            ),
                            child: const Icon(Icons.play_arrow),
                          )
                        : SizedBox(
                            key: const ValueKey('journal_container'),
                            width: 250,
                            height: 250,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 250,
                                height: 125,
                                decoration: BoxDecoration(
                                  color: colors.grayScale100,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(125),
                                    bottomRight: Radius.circular(125),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    journalTitle ?? "Draft",
                                    style: textStyle.h1
                                        .withColor(colors.grayScale0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildBlurredCircle(BuildContext context, WidgetRef ref) {
  //   final colors = ref.gemColors;
  //   return Container(
  //     width: 250,
  //     height: 250,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: colors.grayScale60,
  //     ),
  //     child: ClipOval(
  //       child: BackdropFilter(
  //         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //         child: Container(
  //           color: Colors.transparent,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

void useTopOfStack(BuildContext context, WidgetRef ref, VoidCallback action) {
  final isTop = useIsTopOfStack(context);

  useEffect(() {
    if (isTop) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        action();
      });
    }
    return null;
  }, [isTop]);
}

ScrollController useMainScrollController(WidgetRef ref) {
  final controller = useScrollController();

  useEffect(() {
    void listener() {
      ref
          .read(mainScrollPositionProvider.notifier)
          .updateScrollPosition(controller.offset);
    }

    controller.addListener(listener);
    return () => controller.removeListener(listener);
  }, [controller]);

  return controller;
}

class MainHeaderButton extends ConsumerWidget {
  final String text;

  final VoidCallback onTap;

  const MainHeaderButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    return Material(
      color: colors.grayScale80,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6.0),
          child: SizedBox(
            height: 31,
            width: 130,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle.paragraph.copyWith(color: colors.grayScale0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
