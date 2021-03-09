import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  AppLocalizations get i18n => AppLocalizations.of(this)!;
}

extension ListExtension<E> on List<E> {
  Iterable<T> mapIndexed<T>(T Function(int idx, E element) f) => asMap()
      .map(
        (idx, element) => MapEntry(
          idx,
          f(idx, element),
        ),
      )
      .values;
}

extension DoubleExtension on double {
  String toShortString(int maxFractionDigits) {
    final formatter = NumberFormat()
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = maxFractionDigits;
    return formatter.format(this);
  }
}
