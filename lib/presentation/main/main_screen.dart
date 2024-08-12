import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/presentation/common/hook/use_sync_scorll_value.dart';
import 'package:diary_flutter/presentation/common/provider/primitive_notifiers.dart';
import 'package:diary_flutter/presentation/main/main_appbar.dart';
import 'package:diary_flutter/presentation/main/main_bottom_sliver.dart';
import 'package:diary_flutter/presentation/main/main_carousel_sliver.dart';
import 'package:diary_flutter/presentation/main/main_header_sliver.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainScreen extends HookConsumerWidget {
  static const String path = '/main';
  static const String name = 'main';

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;

    final darkeningAnimationValue =
        ref.watch(doubleNotifierProvider(key: 'darekning'));

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
      value: darkeningAnimationValue,
      target: 0,
      child: Container(
        color: colors.primary100,
        child: const SafeArea(
          top: true,
          bottom: false,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            floatingActionButton: MainAppbar(),
            body: MainBody(),
          ),
        ),
      ),
    );
  }
}

class MainBody extends HookConsumerWidget {
  const MainBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainScrollController = useSyncScrollController(
        controller: useScrollController(), ref: ref, key: 'mainScroll');

    return CustomScrollView(
      controller: mainScrollController,
      physics: const ClampingScrollPhysics(),
      slivers: const [
        MainHeaderSliver(),
        MainCarouselSliver(),
        MainBottomContentSliver()
      ],
    );
  }
}

// InkWell(
    //         onTap: () => context.pushNamed(MyInfoScreen.name, queryParameters: {
    //           QueryParameterKeys.previous.toString():
    //               PreviousScreens.calendar.toString(),
    //         }),
    //         child: GenAssets.images.iconMyInfo.image(scale: 2),
    //       ),