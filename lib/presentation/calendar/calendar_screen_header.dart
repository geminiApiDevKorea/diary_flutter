import 'package:diary_flutter/gen/gen_assets.dart';
import 'package:diary_flutter/presentation/common/router.dart';
import 'package:diary_flutter/presentation/my_info/my_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CalendarScreenHeader extends StatelessWidget {
  const CalendarScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 16),
      height: 46,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: () => context.pop(),
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                height: 36,
                padding: const EdgeInsets.only(left: 8),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 16.0),
                  child: Row(
                    children: [
                      GenAssets.images.iconActionRight.image(scale: 2),
                      const SizedBox(width: 19),
                      const Text('List'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => context.pushNamed(MyInfoScreen.name, queryParameters: {
              QueryParameterKeys.previous.toString(): PreviousScreens.calendar,
            }),
            child: GenAssets.images.iconMyInfo.image(scale: 2),
          ),
        ],
      ),
    );
  }
}
