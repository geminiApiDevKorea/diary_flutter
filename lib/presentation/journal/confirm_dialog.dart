import 'package:diary_flutter/presentation/common/popup/confirm_popup.dart';
import 'package:diary_flutter/presentation/common/popup/popup_button_param.dart';
import 'package:diary_flutter/presentation/style/gem_colors.dart';
import 'package:flutter/material.dart';

enum ConfirmationResult {
  cancel,
  confirm,
}

Future<ConfirmationResult?> showConfirmDialog({
  required BuildContext context,
  required GemColors colors,
  required String title,
  required String description,
  String? leftButtonTitle,
  String? rightButtonTitle,
  VoidCallback? onClose,
  VoidCallback? onConfirm,
}) {
  return showDialog<ConfirmationResult?>(
    barrierColor: colors.modalBackground,
    context: context,
    builder: (context) {
      return GemsConfirmPopup(
        title: title,
        description: description,
        popupButtonParams: [
          PopupButtonParam(
            title: leftButtonTitle ?? 'Close',
            isPrimary: false,
            onTap: (popupContext) async {
              FocusScope.of(context).unfocus();

              onClose?.call();
              Navigator.pop(popupContext, ConfirmationResult.cancel);
              FocusScope.of(context).unfocus();
            },
          ),
          PopupButtonParam(
            title: rightButtonTitle ?? 'Confirm',
            isPrimary: true,
            onTap: (popupContext) async {
              onConfirm?.call();

              Navigator.pop(popupContext, ConfirmationResult.confirm);
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      );
    },
  );
}
