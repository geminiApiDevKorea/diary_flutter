import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/presentation/common/input_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nil/nil.dart';

class SettingNameTextField extends ConsumerWidget {
  final Function(String) onChangedName;
  final Animation<double> animation;
  const SettingNameTextField({
    super.key,
    required this.onChangedName,
    required this.animation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final width = MediaQuery.sizeOf(context).width;
        return Transform.translate(
          offset: Offset(0 - width * animation.value, 0),
          child: child,
        );
      },
      child: ref.watch(authProvider).when(
            data: (authState) {
              final state = authState;
              if (state is SignedInState) {
                return CustomTextFormField(
                  initialText: state.name,
                  isEditable: true,
                  maxLength: 20,
                  minLength: 2,
                  onChangedInputText: onChangedName,
                );
              } else {
                return const Nil();
              }
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, _) => Text('Error: $error'),
          ),
    );
  }
}
