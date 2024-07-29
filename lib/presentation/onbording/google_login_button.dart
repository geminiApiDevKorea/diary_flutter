import 'package:diary_flutter/common/gem_assets.dart';
import 'package:diary_flutter/presentation/onbording/agreement_modal_bottom_sheet.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoogleLoginButton extends HookConsumerWidget {
  const GoogleLoginButton({super.key});

  _onLogin(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    showModalBottomSheet(
      backgroundColor: colors.modalBackground,
      context: context,
      builder: (context) => const AgreementModalBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );
    useEffect(() {
      animationController.forward();
      return () {};
    }, []);

    final textStyle = GemTheme.of(ref).textStyle;
    return AnimatedBuilder(
      animation: animationController,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () => _onLogin(context, ref),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GemAssets.images.iconGoogle.image(scale: 2),
                const SizedBox(width: 8),
                Text('Sign in with Google', style: textStyle.h4),
              ],
            ),
          ),
        ),
      ),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            0 + (100 * (1 - animationController.value)),
          ),
          child: child,
        );
      },
    );
  }
}
