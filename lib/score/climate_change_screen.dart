import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:markup_text/markup_text.dart';
import 'package:warmd/common/blue_card.dart';
import 'package:warmd/common/extensions.dart';
import 'package:warmd/common/screen_template.dart';
import 'package:warmd/common/widgets.dart';

class ClimateChangeScreen extends StatelessWidget {
  const ClimateChangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      body: Column(
        children: [
          SvgPicture.asset(
            'assets/sky.svg',
          ),
          const Gap(48),
          Text(
            context.i18n.climateChangeTitle,
            textAlign: TextAlign.center,
            style: context.textTheme.headline5?.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
          ),
          const Gap(32),
          _buildConsequencesCard(context),
          _buildObjectivesCard(context),
          _buildActionsCard(context),
          const Gap(48),
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
            context.i18n.consequencesTitle,
            style: context.textTheme.subtitle1?.copyWith(
              color: warmdDarkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          MarkupText(
            context.i18n.consequencesPart1,
            style: context.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w300),
          ),
          const Gap(16),
          const Image(
            image: AssetImage('assets/dead_zones_4deg.webp'),
            fit: BoxFit.contain,
            height: 180,
            width: double.infinity,
          ),
          const Gap(16),
          MarkupText(
            context.i18n.consequencesPart2,
            style: context.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w300),
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
            context.i18n.globalObjectivesTitle,
            style: context.textTheme.subtitle1?.copyWith(
              color: warmdDarkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          MarkupText(
            context.i18n.globalObjectivesPart1,
            style: context.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w300),
          ),
          const Gap(16),
          Center(
            child: SvgPicture.asset(
              'assets/graph_emissions.svg',
              height: 200,
            ),
          ),
          const Gap(16),
          MarkupText(
            context.i18n.globalObjectivesPart2,
            style: context.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w300),
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
            context.i18n.globalActionsTitle,
            style: context.textTheme.subtitle1?.copyWith(
              color: warmdDarkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          MarkupText(
            context.i18n.globalActionsPart1,
            style: context.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w300),
          ),
          const Gap(16),
          Center(
            child: SvgPicture.asset(
              'assets/emissions_sectors.svg',
              height: 250,
            ),
          ),
          const Gap(16),
          MarkupText(
            context.i18n.globalActionsPart2,
            style: context.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
