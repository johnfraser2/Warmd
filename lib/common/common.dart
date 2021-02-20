import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

const warmdLightBlue = Color(0xFFDFF3FE);
const warmdBlue = Color(0xFF00AAF2);
const warmdDarkBlue = Color(0xFF123079);

const warmdRed = Color(0xFFFF757D);

const warmdGreen = Color(0xFF7CCE17);

extension BuildContextExtension on BuildContext {
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

Widget buildBackButton(BuildContext context) {
  // TODO: find a better way than a Row to left-align the back button
  return Row(
    children: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          context.i18n.back,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
