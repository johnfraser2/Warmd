import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:warmd/common/extensions.dart';
import 'package:warmd/common/widgets.dart';
import 'package:warmd/translations/gen/l10n.dart';

class WelcomeScreen extends StatelessWidget {
  final Function(BuildContext) onStartSelected;

  const WelcomeScreen({Key? key, required this.onStartSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap(64),
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
                        Translation.current.welcomeTitle,
                        textAlign: TextAlign.center,
                        style: context.textTheme.headline5?.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
                      ),
                      const Gap(64),
                      Text(
                        Translation.current.welcomeDescription,
                        textAlign: TextAlign.center,
                        style: context.textTheme.subtitle1?.copyWith(color: warmdDarkBlue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  onStartSelected(context);
                },
                child: Text(Translation.current.welcomeAction),
              ),
            ),
            const Gap(48),
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
