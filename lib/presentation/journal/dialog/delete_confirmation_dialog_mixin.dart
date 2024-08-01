import 'package:diary_flutter/presentation/common/popup/confirm_popup.dart';
import 'package:diary_flutter/presentation/common/popup/popup_button_param.dart';
import 'package:diary_flutter/presentation/style/gem_colors.dart';
import 'package:flutter/material.dart';

enum DeleteConfirmationResult {
  cancel,
  confirm,
}

mixin DeleteConfirmDialogMixin {
  Future<DeleteConfirmationResult?> showDeleteConfirmDialog({
    required BuildContext context,
    required GemColors colors,
    VoidCallback? onClose,
    VoidCallback? onConfirm,
  }) {
    return showDialog<DeleteConfirmationResult?>(
      barrierColor: colors.modalBackground,
      context: context,
      builder: (context) {
        return GemsConfirmPopup(
          title: 'Delete Journal',
          description: 'Once you delete this journal, it cannot be recovered.',
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
}
