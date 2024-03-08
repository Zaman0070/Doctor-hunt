import 'package:flutter/material.dart';

extension ThemeColors on BuildContext {
  Color get whiteColor => Theme.of(this).colorScheme.primary;
  Color get bodyTextColor => Theme.of(this).colorScheme.secondary;
  Color get buttonColor => Theme.of(this).colorScheme.onPrimary;
  Color get onSecondaryColor => Theme.of(this).colorScheme.onSecondary;
  Color get containerColor => Theme.of(this).colorScheme.primaryContainer;
  Color get secondaryContainerColor => Theme.of(this).colorScheme.secondaryContainer;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;


}
