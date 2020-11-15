import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../common/common.dart';
import '../generated/locale_keys.g.dart';

class WelcomeScreen extends StatelessWidget {
  final Function onStartSelected;

  const WelcomeScreen({@required this.onStartSelected, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gaps.h64,
            Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                'assets/pinguins.svg',
                height: MediaQuery.of(context).size.height / 6,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.welcomeTitle.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
                      ),
                      Gaps.h64,
                      Text(
                        LocaleKeys.welcomeDescription.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(color: warmdDarkBlue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  onStartSelected();
                },
                child: Text(LocaleKeys.welcomeAction.tr()),
              ),
            ),
            Gaps.h48,
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                'assets/ice.svg',
                height: MediaQuery.of(context).size.height / 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
