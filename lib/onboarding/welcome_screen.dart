import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../common/common.dart';

class WelcomeScreen extends StatelessWidget {
  final Function onStartSelected;

  const WelcomeScreen({@required this.onStartSelected, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gaps.h64,
          Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              'assets/pinguins.svg',
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello there,',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
                  ),
                  Gaps.h64,
                  Text(
                    'Thank you for downloading Warmd and taking the first step to making our future generations safer.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(color: warmdDarkBlue),
                  ),
                  Gaps.h32,
                  Text(
                    'Before you get started, we’ll ask you few questions to create personalized recommendations. Are you ready?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(color: warmdDarkBlue),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                onStartSelected();
              },
              child: const Text("LET'S GO"),
            ),
          ),
          Gaps.h48,
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              'assets/ice.svg',
            ),
          ),
        ],
      ),
    );
  }
}
