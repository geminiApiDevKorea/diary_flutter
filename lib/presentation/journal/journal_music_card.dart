import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalMusicCard extends ConsumerWidget {
  final String? imgUrl;
  final String bottomText;
  final VoidCallback onButtonPressed;

  const JournalMusicCard({
    super.key,
    this.imgUrl,
    required this.bottomText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: imgUrl != null
                ? FutureBuilder<void>(
                    future: precacheImage(NetworkImage(imgUrl!), context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          !snapshot.hasError) {
                        return Image.network(
                          imgUrl!,
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return const BlurredCircleWidget();
                      }
                    },
                  )
                : const BlurredCircleWidget(),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          bottomText,
          style: textStyle.caption.withColor(colors.grayScale40),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 270,
          height: 44,
          child: ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary50, // 버튼 배경색을 primary50으로 설정
              foregroundColor: colors.grayScale100, // 텍스트와 아이콘 색상을 white로 설
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              'Play in Youtube',
              style: textStyle.button.withColor(colors.grayScale100),
            ),
          ),
        ),
      ],
    );
  }
}

class BlurredCircleWidget extends ConsumerWidget {
  const BlurredCircleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
