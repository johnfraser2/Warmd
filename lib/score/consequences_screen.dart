import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/common.dart';
import '../common/screen_template.dart';
import '../generated/locale_keys.g.dart';

class ConsequencesScreen extends StatelessWidget {
  const ConsequencesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      body: Column(
        children: [
          SvgPicture.asset(
            'assets/sky.svg',
          ),
          Gaps.h32,
          Text(
            'What are the consequences of climate change?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
          ),
          Gaps.h32,
          _buildObjectivesCard(context),
          Gaps.h32,
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

  Widget _buildObjectivesCard(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: warmdLightBlue,
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.globalObjectivesTitle.tr(),
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: warmdDarkBlue,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Gaps.h16,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: LocaleKeys.globalObjectivesPart1.tr(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: LocaleKeys.globalObjectivesPart2.tr(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: LocaleKeys.globalObjectivesPart3.tr(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: LocaleKeys.globalObjectivesPart4.tr(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: warmdDarkBlue,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w300,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch('https://www.ipcc.ch/site/assets/uploads/sites/2/2019/03/ST1.5_final_310119.pdf');
                      },
                  ),
                  TextSpan(
                    text: LocaleKeys.globalObjectivesPart5.tr(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            const Image(
              image: AssetImage('assets/carbon_graph.webp'),
              fit: BoxFit.contain,
              height: 264,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
