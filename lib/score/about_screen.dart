import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            'assets/sky.svg',
          ),
          Gaps.h48,
          Text(
            'About Warmd',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
          ),
          Gaps.h32,
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
// showAboutDialog(
//           context: context,
//           children: [
//             MarkupText('''
// ${LocaleKeys.aboutPart1.tr()}

// https://www.bbc.com/news/science-environment-49349566
// https://www.lowcvp.org.uk/assets/workingdocuments/MC-P-11-15a%20Lifecycle%20emissions%20report.pdf
// http://www.fao.org/3/a-i3437e.pdf
// https://www.frontiersin.org/articles/10.3389/fnut.2019.00126/full
// https://www.energuide.be/en/questions-answers/is-electric-heating-polluting/1369/
// https://theshiftproject.org/en/article/unsustainable-use-online-video/
// https://en.wikipedia.org/wiki/Greenhouse_gas
// https://fr.wikipedia.org/wiki/Population_mondiale
// https://www.wwf.fr/sites/default/files/doc-2017-07/161027_rapport_planete_vivante.pdf
// https://www.ewg.org/meateatersguide/frequently-asked-questions/

// ${LocaleKeys.disclaimerTitle.tr()}
// ${LocaleKeys.disclaimerExplanation.tr()}
//                       '''),
//           ],
//         );
