import 'package:diary_flutter/presentation/style/enums.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgreementCheckBox extends ConsumerWidget {
  final String title;
  final bool? isRequired;
  final String? url;
  const AgreementCheckBox({
    super.key,
    required this.title,
    this.isRequired,
    this.url,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Material(
              color: colors.grayScale70,
              borderRadius: GemRadius.smallRadius,
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    'images/Onboarding/unchecked.png',
                    scale: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: textStyle.h4,
            ),
            if (isRequired ?? false) ...[
              const SizedBox(width: 4),
              Text(
                'Required',
                textAlign: TextAlign.end,
                style: textStyle.captionBold.copyWith(color: colors.primary50),
              ),
            ],
            if (url != null) ...[
              const Spacer(),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                      'images/Onboarding/iconActionright.png',
                      scale: 2,
                    ),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
