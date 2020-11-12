import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markup_text/markup_text.dart';

import '../common/blue_card.dart';
import '../common/common.dart';
import '../common/screen_template.dart';
import '../generated/locale_keys.g.dart';

class ClimateChangeScreen extends StatelessWidget {
  const ClimateChangeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      body: Column(
        children: [
          SvgPicture.asset(
            'assets/sky.svg',
          ),
          Gaps.h48,
          Text(
            LocaleKeys.climateChangeTitle.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
          ),
          Gaps.h32,
          _buildConsequencesCard(context),
          _buildObjectivesCard(context),
          _buildActionsCard(context),
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

  Widget _buildConsequencesCard(BuildContext context) {
    return BlueCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.consequencesTitle.tr(),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: warmdDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Gaps.h16,
          MarkupText(
            LocaleKeys.consequencesPart1.tr(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
          Gaps.h16,
          const Image(
            image: AssetImage('assets/dead_zones_4deg.webp'),
            fit: BoxFit.contain,
            height: 180,
            width: double.infinity,
          ),
          Gaps.h16,
          MarkupText(
            LocaleKeys.consequencesPart2.tr(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget _buildObjectivesCard(BuildContext context) {
    return BlueCard(
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
          MarkupText(
            LocaleKeys.globalObjectivesPart1.tr(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
          Gaps.h16,
          Center(
            child: SvgPicture.asset(
              'assets/graph_emissions.svg',
              height: 200,
            ),
          ),
          Gaps.h16,
          MarkupText(
            LocaleKeys.globalObjectivesPart2.tr(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard(BuildContext context) {
    return BlueCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.globalActionsTitle.tr(),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: warmdDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Gaps.h16,
          MarkupText(
            LocaleKeys.globalActionsPart1.tr(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
          Gaps.h16,
          Center(
            child: SvgPicture.asset(
              'assets/emissions_sectors.svg',
              height: 250,
            ),
          ),
          Gaps.h16,
          MarkupText(
            LocaleKeys.globalActionsPart2.tr(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
