import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/presentation/settings/setting_gender_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef GenderSelectionCallback = void Function(Gender selectedGender);

class SettingGender extends StatelessWidget {
  final Gender? selectedGender;
  final GenderSelectionCallback onSelect;
  final Animation<double> animation;
  const SettingGender({
    super.key,
    required this.selectedGender,
    required this.onSelect,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        final width = MediaQuery.sizeOf(context).width;
        return Transform.translate(
          offset: Offset(
            -width * animation.value,
            0,
          ),
          child: child,
        );
      },
      animation: animation,
      child: Transform.translate(
        offset: Offset(
          MediaQuery.sizeOf(context).width,
          0,
        ),
        child: SizedBox(
          height: 200,
          width: MediaQuery.sizeOf(context).width,
          child: ListView.separated(
            itemCount: Gender.values.length,
            itemBuilder: (context, index) => SettingGenderItem(
              gender: Gender.values[index],
              isSelected: selectedGender == Gender.values[index],
              onSelect: onSelect,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }
}
