import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'steps_progress_indicator.dart';
import 'widgets.dart';

class ScreenTemplate extends StatelessWidget {
  final double? progressValue;
  final Widget body;
  final ScrollController? scrollController;

  const ScreenTemplate({this.progressValue, required this.body, this.scrollController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          controller: scrollController,
          children: [
            const Gap(16),
            if (progressValue != null) StepsProgressIndicator(value: progressValue!) else const Gap(12),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.all(8),
              child: buildBackButton(context),
            ),
            body,
          ],
        ),
      ),
    );
  }
}
