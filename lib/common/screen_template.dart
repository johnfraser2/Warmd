import 'package:flutter/material.dart';

import 'common.dart';
import 'steps_progress_indicator.dart';

class ScreenTemplate extends StatelessWidget {
  final double progressValue;
  final Widget body;
  final ScrollController scrollController;

  const ScreenTemplate({this.progressValue, @required this.body, this.scrollController, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          controller: scrollController,
          children: [
            Gaps.h16,
            if (progressValue != null) StepsProgressIndicator(value: progressValue) else Gaps.h12,
            Gaps.h8,
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
