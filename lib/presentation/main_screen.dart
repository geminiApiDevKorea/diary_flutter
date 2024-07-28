import 'package:diary_flutter/presentation/home_body.dart';
import 'package:diary_flutter/presentation/home_bottom_navigation_bar.dart';
import 'package:diary_flutter/presentation/main/main_body.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainScreen extends StatelessWidget {
  static const String path = '/main';
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.gemColors.background, //SafeArea 색상
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
            backgroundColor: context.gemColors.background,
            appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 52),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 16),
                  height: 52,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ElevatedButton.icon(
                      //   onPressed: () {
                      //     print('Calendar');
                      //   },
                      //   icon: const Icon(CupertinoIcons.back, size: 18),
                      //   label: ConstrainedBox(
                      //     constraints: const BoxConstraints(maxWidth: 99),
                      //     child: Text('Calendar',
                      //         style: context.gemTextStyle.button),
                      //   ),
                      // ),
                      Material(
                        color: context.gemColors.grayScale80,
                        borderRadius: BorderRadius.circular(
                            32), // 버튼의 모서리를 둥글게 만듭니다. 필요에 따라 조정하세요.
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                              32), // InkWell의 모서리도 같게 설정합니다.
                          onTap: () {
                            print('Calendar');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(CupertinoIcons.back,
                                    size: 18,
                                    color: context.gemColors.grayScale50),
                                const SizedBox(width: 8), // 아이콘과 텍스트 사이의 간격
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 99),
                                  child: Text(
                                    'Calendar',
                                    style: context.gemTextStyle.button.copyWith(
                                        color: context.gemColors.grayScale0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            body: const MainBody()),
      ),
    );
  }
}
