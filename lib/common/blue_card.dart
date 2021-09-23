import 'package:flutter/material.dart';

import 'widgets.dart';

class BlueCard extends StatelessWidget {
  const BlueCard({Key? key, required this.child, this.padding = const EdgeInsets.all(32)}) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          color: warmdLightBlue,
        ),
        margin: const EdgeInsets.only(bottom: 32),
        padding: padding,
        child: child,
      ),
    );
  }
}
