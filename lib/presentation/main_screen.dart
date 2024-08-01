import 'dart:ui';
import 'package:diary_flutter/presentation/calendar/calendar_screen.dart';
import 'package:diary_flutter/presentation/journal_screen.dart';
import 'package:diary_flutter/presentation/main/use_is_top_of_stack.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dart:ui';
import 'package:diary_flutter/presentation/calendar/calendar_screen.dart';
import 'package:diary_flutter/presentation/journal_screen.dart';
import 'package:diary_flutter/presentation/main/use_is_top_of_stack.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainScreen extends HookConsumerWidget {
  static const String path = '/main';
  static const String name = 'main';
  static const double carouselHeight = 490.0;

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 300));
    final isDarkening = useState(false);

    useStackAnimation(
      isTopOfStack: useIsTopOfStack(context),
      animationController: animationController,
      isDarkening: isDarkening,
    );

    return Animate(
      effects: [
        TintEffect(
          curve: Curves.easeInOut,
          begin: 0,
          end: 1,
          color: Colors.black.withOpacity(0.2),
          duration: 300.ms,
        ),
      ],
      target: isDarkening.value ? 1 : 0,
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
              carouselHeight: carouselHeight,
              isDarkening: isDarkening,
              animationController: animationController,
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
              child: SizedBox(
                width: 140,
                height: 36,
                child: ElevatedButton.icon(
                  onPressed: () => context.go(CalendarScreen.path),
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
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
                      style:
                          textStyle.button.copyWith(color: colors.grayScale0),
                    ),
                  ),
                  icon: Icon(CupertinoIcons.back,
                      size: 18, color: colors.grayScale50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainBody extends HookConsumerWidget {
  final double carouselHeight;
  final ValueNotifier<bool> isDarkening;
  final AnimationController animationController;

  const MainBody({
    super.key,
    required this.carouselHeight,
    required this.isDarkening,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: MainHeader(
            isDarkening: isDarkening,
            animationController: animationController,
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            minHeight: carouselHeight,
            maxHeight: carouselHeight,
            child: const CustomHorizontalCarousel(),
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
  final ValueNotifier<bool> isDarkening;
  final AnimationController animationController;

  const MainHeader({
    super.key,
    required this.isDarkening,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: colors.primary100,
        height: 314,
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good Evening, Cody",
                style: textStyle.paragraph.withColor(colors.grayScale60)),
            Text("How was\n your day?", style: textStyle.h1),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(context, 'Chat to record', 'chat', ref),
                _buildButton(context, 'Add a new record', 'post', ref),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, String type, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    return Material(
      color: colors.grayScale80,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () async {
          isDarkening.value = true;
          animationController.value = 0.0;
          await context
              .pushNamed(JournalScreen.name, queryParameters: {'type': type});
          isDarkening.value = false;
        },
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

void useStackAnimation({
  required bool isTopOfStack,
  required AnimationController animationController,
  required ValueNotifier<bool> isDarkening,
}) {
  useEffect(() {
    if (isTopOfStack) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 300), () {
          isDarkening.value = false;
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

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
  const CustomHorizontalCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 490,
      padding: const EdgeInsets.only(bottom: 20),
      color: Colors.amber,
      child: CustomCarousel(
        depthOrder: DepthOrder.reverse,
        itemCountBefore: 0,
        itemCountAfter: 2,
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
          5,
          (index) => _buildCard(
              context,
              ref,
              index,
              "It's Raining, So... — Hazelnut",
              'https://picsum.photos/200/200?random=$index'),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, WidgetRef ref, int index,
      String title, String? imgUrl) {
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
                title,
                style: textStyle.caption.withColor(colors.grayScale40),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: imgUrl != null
                    ? FutureBuilder<void>(
                        future: precacheImage(NetworkImage(imgUrl), context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              !snapshot.hasError) {
                            return Image.network(
                              imgUrl,
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return _buildBlurredCircle(context, ref);
                          }
                        },
                      )
                    : _buildBlurredCircle(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlurredCircle(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.grayScale60,
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
