import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, dataMap, state),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Builder(
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (dataMap.isNotEmpty) _buildFootprintRepartition(context, state, dataMap),
                      _buildCountriesComparison(context, state),
                      _buildObjectivesCard(context),
                      _buildAdvicesCard(context, state),
                    ],
                  );
                },
              ),
            ),
            _buildGoToSourcesButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Map<String, double> dataMap, CriteriasState state) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
            color: warmdLightBlue,
          ),
          margin: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gaps.h8,
              Row(
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
              Gaps.h16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Your carbon footprint is',
                  style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: ScoreWidget(state)),
              Gaps.h32,
              Center(
                child: TextButton(
                  onPressed: () => onSeeConsequencesTapped(),
                  child: Text(
                    "See what happens when you don't take action >",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
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
              padding: const EdgeInsets.symmetric(horizontal: 92),
              child: ElevatedButton(
                onPressed: () => onSeeActionsTapped(),
                child: const Text(
                  'SEE WHAT YOU NEED TO DO',
                  textAlign: TextAlign.center,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(warmdGreen),
                  shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                  textStyle: MaterialStateProperty.all<TextStyle>(Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                  padding:
                      MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 32, vertical: 14)),
                ),
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

  Widget _buildCountriesComparison(BuildContext context, CriteriasState state) {
    return Column(
      children: [
        Gaps.h64,
        Text(
          'COMPARISON WITH OTHERS',
          style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold),
        ),
        Gaps.h16,
        _buildCountriesDataTable(context, state),
        Gaps.h32,
        buildSmartText(context, LocaleKeys.otherCountriesMore.tr(), defaultColor: Colors.black),
      ],
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
              style: _buildTitleStyle(context),
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

  Widget _buildAdvicesCard(BuildContext context, CriteriasState state) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: warmdLightBlue,
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.advicesTitle.tr(),
              style: _buildTitleStyle(context),
            ),
            Gaps.h16,
            ..._buildAdviceWidgets(context, state),
          ],
        ),
      ),
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

  Widget _buildCountriesDataTable(BuildContext context, CriteriasState state) {
    final countriesList = _buildCountriesList(context);
    var rows = [
      for (String country in countriesList.keys)
        DataRow(cells: [
          DataCell(Text(country)),
          DataCell(Text(LocaleKeys.otherCountriesTonsValue.tr(args: [countriesList[country].toString()]))),
        ]),
    ];

    final yourCo2 = state.co2EqTonsPerYear();
    const yourTextStyle = TextStyle(color: warmdBlue, fontWeight: FontWeight.bold);
    final yourCell = DataRow(cells: [
      DataCell(Text('⮕ ${LocaleKeys.you.tr()}', style: yourTextStyle)),
      DataCell(Text(LocaleKeys.otherCountriesTonsValue.tr(args: [yourCo2.toStringAsFixed(1)]), style: yourTextStyle)),
    ]);

    var higherCountryIdx = countriesList.values.toList().indexWhere((countryCo2) => countryCo2 < yourCo2);
    if (higherCountryIdx == -1) {
      rows.add(yourCell);
    } else {
      rows.insert(higherCountryIdx, yourCell);
    }

    return IgnorePointer(
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              LocaleKeys.otherCountriesColumn1Title.tr(),
              style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
              label: Text(
                LocaleKeys.otherCountriesColumn2Title.tr(),
                style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold),
              ),
              numeric: true),
        ],
        rows: rows,
      ),
    );
  }

  List<Widget> _buildAdviceWidgets(BuildContext context, CriteriasState state) {
    var list = [
      for (CriteriaCategory cat in state.categories) ..._buildCategoryAdviceWidgets(context, cat),
    ];

    return list.length > 1 ? list : [Text(LocaleKeys.noAdvicesExplanation.tr())];
  }

  List<Widget> _buildCategoryAdviceWidgets(BuildContext context, CriteriaCategory cat) {
    var list = [
      Gaps.h16,
      Text(
        cat.title,
        style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold),
      ),
      Gaps.h8,
      for (Criteria crit in cat.criterias)
        if (crit.advice() != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '• ${crit.advice()}',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
      Gaps.h16,
    ];

    return list.length > 4 ? list : [];
  }

  TextStyle _buildTitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1.copyWith(
          color: warmdDarkBlue,
          fontWeight: FontWeight.bold,
        );
  }

  // Numbers found on coolclimate.org website
  Map<String, int> _buildCountriesList(BuildContext context) {
    return {
      LocaleKeys.countryUSA.tr(): 54,
      LocaleKeys.countryCanada.tr(): 54,
      LocaleKeys.countryAustralia.tr(): 36,
      LocaleKeys.countrySaudiArabia.tr(): 35,
      LocaleKeys.countryUAE.tr(): 34,
      LocaleKeys.countryChina.tr(): 28,
      LocaleKeys.countryIsrael.tr(): 25,
      LocaleKeys.countrySouthKorea.tr(): 25,
      LocaleKeys.countryJapan.tr(): 23,
      LocaleKeys.countryGermany.tr(): 23,
      LocaleKeys.countrySouthAfrica.tr(): 23,
      LocaleKeys.countryRussia.tr(): 22,
      LocaleKeys.countryGreece.tr(): 20,
      LocaleKeys.countryUK.tr(): 19,
      LocaleKeys.countryNorway.tr(): 17,
      LocaleKeys.countryIndia.tr(): 16,
      LocaleKeys.countryFrance.tr(): 16,
      LocaleKeys.countryMexico.tr(): 16,
      LocaleKeys.countryBrasil.tr(): 15,
      LocaleKeys.countryEgypt.tr(): 14,
      LocaleKeys.countryVietnam.tr(): 13,
      LocaleKeys.countryMorocco.tr(): 13,
      LocaleKeys.countryPhilippines.tr(): 13,
      LocaleKeys.countryCongo.tr(): 13,
      LocaleKeys.countrySoudan.tr(): 12,
    };
  }
}
