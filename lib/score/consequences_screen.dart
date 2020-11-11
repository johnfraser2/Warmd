import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markup_text/markup_text.dart';

import '../common/blue_card.dart';
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
          Gaps.h48,
          Text(
            'What is climate change?',
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
            'Consequences of global warming',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: warmdDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Gaps.h16,
          MarkupText(
            'We already gained (b)+1°C(/b) from pre-industrial levels, with non-negligeable impacts.\n\nBy reaching (b)+2°C(/b) in 2100, (a https://www.wwf.org.uk/updates/our-warming-world-how-much-difference-will-half-degree-really-make)we will certainly suffer(/a) a major loss in our biodiversity (-18% insects, -16% plants, -8% vertebrates, -99% corals), 49 million people will be impacted by sea-level rise and 410 million people will suffer severe drought, leading to massive emigration, financial and political instabilities.\n\nAt (b)+4°C(/b) humans will not be able to live around the equator (a http://www.uhm.hawaii.edu/news/article.php?aId=8657)due to deadly heat(/a):',
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
            'Billions of people will emigrate to other area with a very high risk of famines, wars and millions or billions of deaths.\n\n(b)+6°C(/b) is the same difference of average temperature between the previous (b)ice age and the 20th century(/b).',
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
            'How should we start?',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: warmdDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Gaps.h16,
          MarkupText(
            'Emissions essentially come from few main sectors (source: IPCC, 2014, global emissions).',
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
            '• The first thing to do is to (b)completely stop using fossil fuels(/b) (coal, oil, gas) and replace them with non-carbonated electricity ((a https://www.ipcc.ch/site/assets/uploads/2018/02/ipcc_wg3_ar5_chapter7.pdf)IPCC(/a) recommands an increased use of both nuclear and renewable energy).\n\n• Then there is a need for (b)better food management(/b), with less meat and waste.\n\n• To finish, it could be necessary to start organizing a global degrowth and a birth rate control since it could be the only solution to reach a complete decarbonation.',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
