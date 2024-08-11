import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/gen/gen_assets.dart';
import 'package:diary_flutter/presentation/settings/setting_gender.dart';
import 'package:diary_flutter/presentation/style/enums.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingGenderItem extends ConsumerWidget {
  final Gender gender;
  final bool isSelected;
  final GenderSelectionCallback onSelect;
  const SettingGenderItem({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    return Material(
      color: isSelected ? colors.primary90 : colors.primary100,
      borderRadius: GemRadius.mediumRadius,
      child: InkWell(
        onTap: () => onSelect(gender),
        borderRadius: GemRadius.mediumRadius,
        child: Container(
          height: 46,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: GemRadius.mediumRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gender.name.capitalize(),
                style: textStyle.h4,
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary50 : colors.grayScale70,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: isSelected
                    ? GenAssets.images.checked.image(scale: 2)
                    : GenAssets.images.unchecked.image(scale: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
