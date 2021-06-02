import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  AppLocalizations get i18n => AppLocalizations.of(this)!;
}

extension DoubleExtension on double {
  String toShortString(BuildContext context, int maxFractionDigits) {
    final formatter = NumberFormat.decimalPattern(Localizations.localeOf(context).languageCode)
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = maxFractionDigits;
    return formatter.format(this);
  }
}
