import 'package:diary_flutter/presentation/common/popup/popup_button_param.dart';
import 'package:diary_flutter/presentation/style/enums.dart';
import 'package:diary_flutter/presentation/style/gem_colors.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GemsConfirmPopup extends ConsumerWidget {
  final String title;
  final String description;
  final List<PopupButtonParam> popupButtonParams;
  const GemsConfirmPopup({
    super.key,
    required this.title,
    required this.description,
    required this.popupButtonParams,
  });

  createButton({
    required GemColors colors,
    required GemTextStyle style,
    required String buttonTitle,
    required Function() onTap,
    required bool isPrimary,
  }) {
    return Expanded(
      child: Material(
        color: isPrimary ? colors.primary50 : colors.grayScale90,
        borderRadius: GemRadius.mediumRadius,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 44,
            child: Center(
              child: Text(
                buttonTitle,
                style: style.h5.withColor(
                  isPrimary ? colors.grayScale100 : colors.text,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final style = GemTheme.of(ref).textStyle;
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: colors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: style.h2,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: style.h5,
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                ...popupButtonParams
                    .mapIndexed(
                      (index, param) => [
                        if (index != 0) const SizedBox(width: 12),
                        createButton(
                          colors: colors,
                          onTap: () => param.onTap(context),
                          style: style,
                          buttonTitle: param.title,
                          isPrimary: param.isPrimary,
                        ),
                      ],
                    )
                    .flattened,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
