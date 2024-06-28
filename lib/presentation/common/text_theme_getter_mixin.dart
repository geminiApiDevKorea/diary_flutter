import 'package:flutter/material.dart';

mixin TextThemeGetterMixin {
  TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;
}
