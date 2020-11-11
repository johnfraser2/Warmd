import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../common/common.dart';
import '../common/criterias.dart';
import '../generated/locale_keys.g.dart';
import 'score_widget.dart';

class ScoreScreen extends StatelessWidget {
  final Function onSeeConsequencesTapped;
  final Function onSeeActionsTapped;
  final Function onRestartTapped;
  final Function onSeeAboutTapped;

  const ScoreScreen(
      {@required this.onSeeConsequencesTapped,
      @required this.onSeeActionsTapped,
      @required this.onRestartTapped,
      @required this.onSeeAboutTapped,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CriteriasState>();

    var temp = <String, double>{};
    for (var cat in state.categories) {
      if (cat.co2EqTonsPerYear() > 0) {
        temp.putIfAbsent('${cat.title} (${cat.co2EqTonsPerYear().toStringAsFixed(1)}t)', () => cat.co2EqTonsPerYear().toDouble());
      }
    }
    final dataMap = temp.sort((a, b) => -a.value.compareTo(b.value));

    return Scaffold(
      body: ListView(
        children: [
          _buildHeader(context, dataMap, state),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildFootprintRepartition(context, state, dataMap),
          ),
          Gaps.h64,
          _buildGoToSourcesButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Map<String, double> dataMap, CriteriasState state) {
    final greenButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(warmdGreen),
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )),
      textStyle: MaterialStateProperty.all<TextStyle>(Theme.of(context).textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.bold,
          )),
      minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(64)),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 32, vertical: 14)),
    );
    final greyButtonStyle = greenButtonStyle.copyWith(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[200]),
    );

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
            color: warmdLightBlue,
          ),
          margin: const EdgeInsets.only(bottom: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 44),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    buildBackButton(context),
                    Expanded(child: Container()),
                    IconButton(
                        icon: Icon(Platform.isIOS ? CupertinoIcons.share : Icons.share),
                        onPressed: () {
                          var footprint = state.getFormatedFootprint();

                          Share.share(
                              "${LocaleKeys.footprintRepartitionTitle.tr(args: [
                                footprint
                              ])}\n\n${dataMap.keys.join("\n")}\n\n${LocaleKeys.doneWith.tr()}\nAndroid app: https://play.google.com/store/apps/details?id=net.frju.verdure\niOS app: https://apps.apple.com/fr/app/warmd/id1487848837",
                              subject: 'Warmd');
                        }),
                  ],
                ),
              ),
              Gaps.h16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Text(
                  'Your carbon footprint is',
                  style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: ScoreWidget(state)),
              Gaps.h32,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Center(
                  child: TextButton(
                    onPressed: () => onSeeConsequencesTapped(),
                    child: Text(
                      "See what happens when you don't take action >",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
                    ),
                  ),
                ),
              ),
              Gaps.h48,
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => onSeeActionsTapped(),
                      child: const Text(
                        'SEE WHAT YOU NEED TO DO',
                        textAlign: TextAlign.center,
                      ),
                      style: greenButtonStyle,
                    ),
                  ),
                  Gaps.w16,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => onRestartTapped(),
                      child: Text(
                        'REDO QUESTIONNAIRE',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[600]),
                      ),
                      style: greyButtonStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFootprintRepartition(BuildContext context, CriteriasState state, Map<String, double> dataMap) {
    return Column(
      children: [
        Gaps.h64,
        Text(
          'FOOTPRINT ANALYSIS',
          style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold),
        ),
        Gaps.h24,
        SizedBox(
          height: 200,
          child: Center(
            child: PieChart(
              dataMap: dataMap,
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: false,
                chartValueStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoToSourcesButton(BuildContext context) {
    return InkWell(
      child: Ink(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
          color: warmdLightBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Understand how your carbon footprint is calculated and how you could help this project.',
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: warmdDarkBlue,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Gaps.w24,
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: warmdDarkBlue,
                ),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        showAboutDialog(
          context: context,
          children: [
            buildSmartText(context, '''
${LocaleKeys.aboutPart1.tr()}

https://www.ipcc.ch/site/assets/uploads/sites/2/2019/03/ST1.5_final_310119.pdf
http://www.uhm.hawaii.edu/news/article.php?aId=8657
https://www.bbc.com/news/science-environment-49349566
https://www.lowcvp.org.uk/assets/workingdocuments/MC-P-11-15a%20Lifecycle%20emissions%20report.pdf
http://www.fao.org/3/a-i3437e.pdf
https://www.frontiersin.org/articles/10.3389/fnut.2019.00126/full
https://www.ipcc.ch/site/assets/uploads/2018/02/ipcc_wg3_ar5_full.pdf
https://www.energuide.be/en/questions-answers/is-electric-heating-polluting/1369/
https://theshiftproject.org/en/article/unsustainable-use-online-video/
https://en.wikipedia.org/wiki/Greenhouse_gas
https://fr.wikipedia.org/wiki/Population_mondiale
https://www.wwf.fr/sites/default/files/doc-2017-07/161027_rapport_planete_vivante.pdf
https://www.ewg.org/meateatersguide/frequently-asked-questions/

${LocaleKeys.disclaimerTitle.tr()}
${LocaleKeys.disclaimerExplanation.tr()}
                      '''),
          ],
        );
      },
    );
  }
}
