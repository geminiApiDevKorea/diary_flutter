import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_animate/flutter_animate.dart';

class JournalMusicCard extends ConsumerWidget {
  final String? imgUrl;
  final String? bottomText;
  final VoidCallback? onButtonPressed;

  const JournalMusicCard({
    super.key,
    this.imgUrl,
    this.bottomText,
    this.onButtonPressed,
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
                  ? CachedNetworkImage(
                      imageUrl: imgUrl!,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const BlurredCircleWidget(),
                      errorWidget: (context, url, error) =>
                          const BlurredCircleWidget(),
                    )
                  : const BlurredCircleWidget()),
        ),
        const SizedBox(height: 20),
        if (bottomText != null)
          Text(
            bottomText ?? '',
            style: textStyle.caption.withColor(colors.grayScale40),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        else
          Text(
            'No music data',
            style: textStyle.caption.withColor(colors.grayScale40),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .shimmer(duration: 1.seconds, color: colors.grayScale40),
        const SizedBox(height: 20),
        if (onButtonPressed != null)
          SizedBox(
            width: 270,
            height: 44,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary50,
                foregroundColor: colors.grayScale100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Play in Youtube',
                style: textStyle.button.withColor(colors.grayScale100),
              ),
            ),
          ).animate().fade(duration: 300.ms, curve: Curves.easeOut).slideY(
                begin: 1,
                end: 0,
                duration: 300.ms,
                curve: Curves.easeOut,
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
