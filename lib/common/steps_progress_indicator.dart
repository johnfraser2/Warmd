import 'package:flutter/material.dart';

class StepsProgressIndicator extends StatelessWidget {
  final double value;

  const StepsProgressIndicator({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: Colors.grey[100],
        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1DD076)),
        minHeight: 12,
      ),
    );
  }
}
