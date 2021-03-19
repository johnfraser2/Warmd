import 'package:flutter/material.dart';

import 'widgets.dart';

class BlueCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const BlueCard({Key? key, required this.child, this.padding = const EdgeInsets.all(32)}) : super(key: key);

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
