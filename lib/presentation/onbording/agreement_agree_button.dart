import 'package:diary_flutter/presentation/common/popup/confirm_popup.dart';
import 'package:diary_flutter/presentation/common/popup/popup_button_param.dart';
import 'package:diary_flutter/presentation/style/gem_colors.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AgreeResult {
  cancel,
  confirm,
}

class AgreementAgreeButton extends ConsumerWidget {
  final double bottomPadding;
  final bool isAllRequiredAgreed;
  final Function(AgreeResult) onAgreeResult;
  const AgreementAgreeButton({
    super.key,
    required this.bottomPadding,
    required this.isAllRequiredAgreed,
    required this.onAgreeResult,
  });

  Future<AgreeResult?> _showConfirmDialog(
      BuildContext context, GemColors colors) {
    return showDialog<AgreeResult>(
      barrierColor: colors.modalBackground,
      context: context,
      builder: (context) {
        return GemsConfirmPopup(
          title: 'Agree to\nRequired Terms',
          description:
              'After agreeing to the required terms, you can use the app.',
          popupButtonParams: [
            PopupButtonParam(
              title: 'Close',
              isPrimary: false,
              onTap: (popupContext) {
                Navigator.pop(popupContext, AgreeResult.cancel);
              },
            ),
            PopupButtonParam(
              title: 'Confirm',
              isPrimary: true,
              onTap: (popupContext) {
                Navigator.pop(popupContext, AgreeResult.confirm);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 50 + bottomPadding,
        child: Material(
          color: isAllRequiredAgreed ? colors.primary50 : colors.grayScale70,
          child: InkWell(
            onTap: () async {
              if (isAllRequiredAgreed) {
                onAgreeResult(AgreeResult.confirm);
              } else {
                final result = await _showConfirmDialog(context, colors);
                onAgreeResult(result ?? AgreeResult.cancel);
              }
            },
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              height: 24,
              width: double.infinity,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Agree and Continue',
                  style: textStyle.h4.withColor(
                    isAllRequiredAgreed
                        ? colors.background
                        : colors.grayScale60,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
