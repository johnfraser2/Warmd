import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension DoubleExtension on double {
  String toShortString(BuildContext context, int maxFractionDigits) {
    final formatter = NumberFormat.decimalPattern(Localizations.localeOf(context).languageCode)
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = maxFractionDigits;
    return formatter.format(this);
  }
}
