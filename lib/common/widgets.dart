import 'package:flutter/material.dart';

import 'extensions.dart';

const warmdLightBlue = Color(0xFFDFF3FE);
const warmdBlue = Color(0xFF00AAF2);
const warmdDarkBlue = Color(0xFF123079);

const warmdRed = Color(0xFFFF757D);

const warmdGreen = Color(0xFF7CCE17);

Widget buildBackButton(BuildContext context) {
  return TextButton(
    onPressed: () => Navigator.pop(context),
    child: Text(
      context.i18n.back,
      style: context.textTheme.subtitle1?.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.bold),
    ),
  );
}
