import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markup_text/markup_text.dart';

import '../common/blue_card.dart';
import '../common/common.dart';
import '../common/screen_template.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      body: Column(
        children: [
          SvgPicture.asset(
            'assets/splash.svg',
          ),
          Gaps.h48,
          _buildWarmdProjectCard(context),
          _buildSourcesCard(context),
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

  Widget _buildWarmdProjectCard(BuildContext context) {
    return BlueCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Warmd project',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: warmdDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Gaps.h16,
          MarkupText(
            'Warmd is a free and non-lucrative open-source project. You can contribute to it (a https://github.com/FredJul/Warmd)here(/a) or help translating it (a https://frju.crowdin.com/warmd)here(/a).\n\nWarmd design has been generously provided by (a https://mnstudio.net)mn studio(/a).',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget _buildSourcesCard(BuildContext context) {
    return BlueCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sources',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: warmdDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Gaps.h16,
          MarkupText(
            "The carbone footprint calculator is mainly based on (a https://coolclimate.org)CoolClimate(/a) results, with the help of other data from (a https://www.bbc.com/news/science-environment-49349566)BBC(/a), (a https://www.lowcvp.org.uk/assets/workingdocuments/MC-P-11-15a%20Lifecycle%20emissions%20report.pdf)LowCVP(/a), (a https://www.frontiersin.org/articles/10.3389/fnut.2019.00126/full)Frontiers(/a), (a https://theshiftproject.org/en/article/unsustainable-use-online-video/)The Shift Project(/a) or (a https://riftapp.fr/)Rift(/a).\n\nDue to the complexity of the task, I do not expect this app to be very accurate, but it gives you an idea of your impact.\n\nIn addition, this app focuses only on the climate change, but we should not forget the other types of pollutions (plastics, pesticides, …).\n\nI'm not affiliated with any of the mentioned organizations.",
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
