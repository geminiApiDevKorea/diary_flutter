import 'dart:ui';
import 'package:diary_flutter/presentation/calendar/calendar_screen.dart';
import 'package:diary_flutter/presentation/journal_screen.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainScreen extends HookConsumerWidget {
  static const String path = '/main';
  static const String name = 'main';
  // final StatefulNavigationShell navigationShell;
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final path =
    //     ref.watch(routerProvider).routerDelegate.currentConfiguration.uri.path;

    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;
    const carouselHeight = 490.0;

    // 각 경로에 대한 설정을 맵으로 관리
    final pathConfigs = {
      MainScreen.path: PathConfig(
          width: 140,
          text: 'Calendar',
          onTap: () {
            if (kDebugMode) print('Calendar');
          },
          backgroundColor: colors.primary100),
      JournalScreen.path: PathConfig(
          width: 100,
          text: 'List',
          onTap: () => context.goNamed(MainScreen.name),
          backgroundColor: colors.grayScale90),
      // 여기에 새로운 경로를 추가할 수 있습니다.
    };

    // 현재 경로에 대한 설정을 가져옵니다. 없으면 기본값 사용
    final currentConfig = pathConfigs[path] ?? PathConfig();
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 300));
    // final isMounted = useIsMounted();

// 화면이 빌드될 때마다 애니메이션 재시작
    useEffect(() {
      animationController.forward(from: 0.0);
      return null;
    }, []);

    void restartAnimation() {
      animationController.forward(from: 0.0);
    }

    bool useIsTopOfStack(BuildContext context) {
      final router = GoRouter.of(context);
      final currentRoute =
          router.routerDelegate.currentConfiguration.matches.last;

      final isTop = useState(true);

      useEffect(() {
        void listener() {
          final matches = router.routerDelegate.currentConfiguration.matches;
          isTop.value = matches.isNotEmpty && matches.last == currentRoute;
        }

        router.routerDelegate.addListener(listener);
        return () => router.routerDelegate.removeListener(listener);
      }, []);

      return isTop.value;
    }

    final isTopOfStack = useIsTopOfStack(context);
    final isDarkening = useState(false);
    useEffect(() {
      if (isTopOfStack) {
        // 최상단에 있을 때 애니메이션 재생
        if (kDebugMode) {
          print(isTopOfStack);
        }

        Future.delayed(const Duration(milliseconds: 300), () {
          restartAnimation();
        });
      }
      return null;
    }, [isTopOfStack]);

    return Animate(
      effects: [
        // BlurEffect(
        //   begin: const Offset(0, 0),
        //   end: const Offset(4, 4),
        //   duration: 300.ms,
        //   curve: Curves.easeInOut,
        // ),
        // ColorEffect(
        //   curve: Curves.bounceIn,
        //   begin: Colors.transparent,
        //   end: Colors.black.withOpacity(0.9),
        //   duration: 300.ms,
        // ),
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
              // backgroundColor: colors.primary100,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerTop,
              floatingActionButton: SizedBox(
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
                            onPressed: () {
                              if (kDebugMode) {
                                print("calendar로");
                              }
                              context.go(CalendarScreen.path);
                            },
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
                                  style: textStyle.button
                                      .copyWith(color: colors.grayScale0),
                                )),
                            icon: Icon(CupertinoIcons.back,
                                size: 18, color: colors.grayScale50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: colors.primary100,
                        height: 314,
                        padding: const EdgeInsets.fromLTRB(16, 64, 16, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Good Evening, Cody",
                                style: textStyle.paragraph
                                    .withColor(colors.grayScale60)),
                            Text("How was\n your day?", style: textStyle.h1),
                            const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  color: colors.grayScale80,
                                  borderRadius: BorderRadius.circular(
                                      32), // 버튼의 모서리를 둥글게 만듭니다. 필요에 따라 조정하세요.
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(
                                        32), // InkWell의 모서리도 같게 설정합니다.
                                    onTap: () async {
                                      isDarkening.value = true;
                                      animationController.value = 0.0;
                                      await context.pushNamed(
                                          JournalScreen.name,
                                          queryParameters: {'type': 'chat'});

                                      isDarkening.value = false;
                                    },

                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 6.0),
                                      child: SizedBox(
                                        height: 31,
                                        width: 130,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Chat to record',
                                            textAlign: TextAlign.center,
                                            style: textStyle.paragraph.copyWith(
                                                color: colors.grayScale0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: colors.grayScale80,
                                  borderRadius: BorderRadius.circular(
                                      32), // 버튼의 모서리를 둥글게 만듭니다. 필요에 따라 조정하세요.
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(
                                        32), // InkWell의 모서리도 같게 설정합니다.
                                    onTap: () async {
                                      isDarkening.value = true;
                                      animationController.value = 0.0;
                                      await context.pushNamed(
                                          JournalScreen.name,
                                          queryParameters: {'type': 'post'});
                                      isDarkening.value = false;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 6.0),
                                      child: SizedBox(
                                        height: 31,
                                        width: 130,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Add a new record',
                                            textAlign: TextAlign.center,
                                            style: textStyle.paragraph.copyWith(
                                                color: colors.grayScale0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
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
                        height:
                            MediaQuery.of(context).size.height - carouselHeight,
                        color: Colors.red),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class PathConfig {
  final double width;
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;

  PathConfig({
    this.width = 100,
    this.text = '',
    this.onTap = _defaultOnTap,
    this.backgroundColor = Colors.transparent,
  });

  static void _defaultOnTap() {}
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
