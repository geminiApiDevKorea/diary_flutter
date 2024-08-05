import 'package:diary_flutter/presentation/common/popup/confirm_popup.dart';
import 'package:diary_flutter/presentation/common/popup/popup_button_param.dart';
import 'package:diary_flutter/presentation/style/gem_colors.dart';
import 'package:flutter/material.dart';

enum DeleteConfirmationResult {
  cancel,
  confirm,
}

Future<DeleteConfirmationResult?> showConfirmDialog({
  required BuildContext context,
  required GemColors colors,
  required String title,
  required String description,
  VoidCallback? onClose,
  VoidCallback? onConfirm,
}) {
  return showDialog<DeleteConfirmationResult?>(
    barrierColor: colors.modalBackground,
    context: context,
    builder: (context) {
      return GemsConfirmPopup(
        title: title,
        description: description,
        popupButtonParams: [
          PopupButtonParam(
            title: 'Close',
            isPrimary: false,
            onTap: (popupContext) async {
              Navigator.pop(popupContext, DeleteConfirmationResult.cancel);
              onClose?.call();
            },
          ),
          PopupButtonParam(
            title: 'Confirm',
            isPrimary: true,
            onTap: (popupContext) async {
              Navigator.pop(popupContext, DeleteConfirmationResult.confirm);
              onConfirm?.call();
            },
          ),
        ],
      );
    },
  );
}