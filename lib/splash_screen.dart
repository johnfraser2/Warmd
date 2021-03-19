import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'common/delayable_state.dart';

class SplashScreen extends StatefulWidget {
  final Function(BuildContext) onFinished;

  const SplashScreen({Key? key, required this.onFinished}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends DelayableState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    delay(const Duration(seconds: 2), () => widget.onFinished(context));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SvgPicture.asset(
          'assets/splash.svg',
        ),
      ),
    );
  }
}
