import 'package:diary_flutter/gen/gen_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingAppBar extends ConsumerWidget {
  const SettingAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.pop(),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: GenAssets.images.backButton.image(scale: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
