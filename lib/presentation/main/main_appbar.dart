import 'package:diary_flutter/gen/gen_assets.dart';
import 'package:diary_flutter/presentation/calendar/calendar_screen.dart';
import 'package:diary_flutter/presentation/common/hook/use_sync_animation_value.dart';
import 'package:diary_flutter/presentation/common/hook/use_top_of_stack_callback.dart';
import 'package:diary_flutter/presentation/common/router.dart';
import 'package:diary_flutter/presentation/my_info/my_info_screen.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainAppbar extends HookConsumerWidget {
  const MainAppbar({
    super.key,
  });

  /// 액션 버튼 생성 함수
  Widget _buildActionButton({
    required WidgetRef ref,
    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
    final textStyle = ref.gemTextStyle;

    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: textStyle.button.withColor(color)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    final listButtonAnimationController = useSyncAnimationController(
      controller:
          useAnimationController(duration: const Duration(milliseconds: 400)),
      ref: ref,
      key: 'calendarOrlist',
    );

    useTopOfStackCallback(
      delay: const Duration(milliseconds: 400),
      context,
      () {
        listButtonAnimationController.value = 0;
        Future.microtask(() => listButtonAnimationController.forward());
      },
    );

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 캘린더 버튼
            Hero(
              tag: 'calendarOrlist',
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 120,
                  height: 36,
                  child: Align(
                    child: SizedBox(
                      width: 99,
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () => context.pushNamed(CalendarScreen.name),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.buttonBackground,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: EdgeInsets.zero, // Remove default padding
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 6), // Add left padding for visual balance
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(CupertinoIcons.back,
                                  size: 18, color: colors.grayScale70),
                              const SizedBox(
                                  width: 5), // Space between icon and text
                              Expanded(
                                child: AnimatedBuilder(
                                  animation: listButtonAnimationController,
                                  builder: (context, child) => FadeTransition(
                                    opacity: listButtonAnimationController,
                                    child: child,
                                  ),
                                  child: Text(
                                    'Calendar',
                                    style: textStyle.button
                                        .copyWith(color: colors.text),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // -> 삭제예정
            const Spacer(),

            InkWell(
              onTap: () => context.pushNamed(
                MyInfoScreen.name,
                queryParameters: {
                  QueryParameterKeys.previous.toString():
                      PreviousScreens.main.toString(),
                },
              ),
              child: GenAssets.images.iconProfile.image(scale: 2),
            ),

            /// 일기 삭제 버튼 -> 삭제예정
            // _buildActionButton(
            //   text: "일기삭제",
            //   ref: ref,
            //   onPressed: () {
            //     Print.red("일기 전부삭제");
            //     ref.read(myJournalStoreProvider.notifier).deleteAllJournals();
            //   },
            //   color: colors.error,
            // ),

            // /// 더미 일기 생성 버튼 -> 삭제예정
            // _buildActionButton(
            //   text: "일기생성",
            //   ref: ref,
            //   onPressed: () {
            //     Print.cyan("더미 일기 생성");
            //     ref.read(myJournalStoreProvider.notifier).createDummyJournal();
            //   },
            //   color: colors.caption,
            // ),
          ],
        ),
      ),
    );
  }
}
