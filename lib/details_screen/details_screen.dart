import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/common.dart';
import '../common/criterias.dart';
import '../generated/i18n.dart';

class DetailsScreen extends StatelessWidget {
  final CriteriasState _state;

  DetailsScreen(this._state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var temp = <String, double>{};
    for (var cat in _state.categorySet.categories) {
      if (cat.co2EqTonsPerYear() > 0) {
        temp.putIfAbsent('${cat.title} (${cat.co2EqTonsPerYear().toStringAsFixed(1)}t)', () => cat.co2EqTonsPerYear().toDouble());
      }
    }
    final dataMap = temp.sort((a, b) => -a.value.compareTo(b.value));

    var footprint = _state.categorySet.getFormatedFootprint();

    return Scaffold(
      appBar: AppBar(
        title: const Image(
          height: 64,
          image: AssetImage('assets/text_logo_transparent_small.webp'),
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
              icon: Icon(Platform.isIOS ? CupertinoIcons.share : Icons.share),
              onPressed: () {
                Share.share(
                    "${S.of(context).footprintRepartitionTitle(footprint)}\n\n${dataMap.keys.join("\n")}\n\n${S.of(context).doneWith}\nAndroid app: https://play.google.com/store/apps/details?id=net.frju.verdure\niOS app: https://apps.apple.com/fr/app/warmd/id1487848837",
                    subject: 'Warmd');
              }),
          IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {
                showAboutDialog(
                  context: context,
                  children: [
                    buildSmartText(context, '''
${S.of(context).aboutPart1}

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

${S.of(context).aboutPart2}

https://materialdesignicons.com
https://www.2dimensions.com/a/frju/files/flare/global-warming/preview
https://unsplash.com/photos/tI_DEyjWOkY
https://unsplash.com/photos/561igiTyvSk
https://unsplash.com/photos/Xbh_OGLRfUM
https://unsplash.com/photos/6xeDIZgoPaw
https://unsplash.com/photos/4mQOcabC5AA
                  '''),
                  ],
                );
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Theme(
            data: ThemeData.light(),
            child: Builder(
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (dataMap.isNotEmpty) _buildHeader(context, footprint, dataMap),
                    if (dataMap.isNotEmpty) _buildCountriesCard(context),
                    _buildObjectivesCard(context),
                    _buildAdvicesCard(context),
                    _buildDisclaimerCard(context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String footprint, Map<String, double> dataMap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            S.of(context).footprintRepartitionTitle(footprint),
            style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
          ),
        ),
        PieChart(
          dataMap: dataMap,
        ),
        Gaps.h16,
      ],
    );
  }

  Card _buildCountriesCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).otherCountriesComparaisonTitle,
              style: _buildTitleStyle(context),
            ),
            Gaps.h16,
            _buildCountriesDataTable(context),
            Gaps.h32,
            buildSmartText(context, S.of(context).otherCountriesMore)
          ],
        ),
      ),
    );
  }

  Card _buildObjectivesCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).globalObjectivesTitle,
              style: _buildTitleStyle(context),
            ),
            Gaps.h16,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: S.of(context).globalObjectivesPart1,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: S.of(context).globalObjectivesPart2,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: S.of(context).globalObjectivesPart3,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: S.of(context).globalObjectivesPart4,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.blue[400],
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w300,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch('https://www.ipcc.ch/site/assets/uploads/sites/2/2019/03/ST1.5_final_310119.pdf');
                      },
                  ),
                  TextSpan(
                    text: S.of(context).globalObjectivesPart5,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Image(
              image: const AssetImage('assets/carbon_graph.webp'),
              fit: BoxFit.contain,
              height: 264,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Card _buildAdvicesCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).advicesTitle,
              style: _buildTitleStyle(context),
            ),
            Gaps.h16,
            ..._buildAdviceWidgets(context),
          ],
        ),
      ),
    );
  }

  Card _buildDisclaimerCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).disclaimerTitle,
              style: _buildTitleStyle(context),
            ),
            Gaps.h16,
            buildSmartText(context, S.of(context).disclaimerExplanation),
          ],
        ),
      ),
    );
  }

  Widget _buildCountriesDataTable(BuildContext context) {
    final countriesList = _buildCountriesList(context);
    var rows = [
      for (String country in countriesList.keys)
        DataRow(cells: [
          DataCell(Text(country)),
          DataCell(Text(S.of(context).otherCountriesTonsValue(countriesList[country]))),
        ]),
    ];

    final yourCo2 = _state.categorySet.co2EqTonsPerYear();
    final yourCell = DataRow(cells: [
      DataCell(Text(S.of(context).you, style: TextStyle(color: warmdGreen, fontWeight: FontWeight.bold))),
      DataCell(Text(S.of(context).otherCountriesTonsValue(yourCo2.toStringAsFixed(1)),
          style: TextStyle(color: warmdGreen, fontWeight: FontWeight.bold))),
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
            S.of(context).otherCountriesColumn1Title,
            style: Theme.of(context).textTheme.subtitle2,
          )),
          DataColumn(
              label: Text(
                S.of(context).otherCountriesColumn2Title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              numeric: true),
        ],
        rows: rows,
      ),
    );
  }

  List<Widget> _buildAdviceWidgets(BuildContext context) {
    var list = [
      for (CriteriaCategory cat in _state.categorySet.categories) ..._buildCategoryAdviceWidgets(context, cat),
    ];

    return list.length > 1 ? list : [Text(S.of(context).noAdvicesExplanation)];
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
    return Theme.of(context).textTheme.headline6.copyWith(
          color: warmdGreen,
        );
  }

  // Numbers found on coolclimate.org website
  Map<String, int> _buildCountriesList(BuildContext context) {
    return {
      S.of(context).countryUSA: 54,
      S.of(context).countryCanada: 54,
      S.of(context).countryAustralia: 36,
      S.of(context).countrySaudiArabia: 35,
      S.of(context).countryUAE: 34,
      S.of(context).countryChina: 28,
      S.of(context).countryIsrael: 25,
      S.of(context).countrySouthKorea: 25,
      S.of(context).countryJapan: 23,
      S.of(context).countryGermany: 23,
      S.of(context).countrySouthAfrica: 23,
      S.of(context).countryRussia: 22,
      S.of(context).countryGreece: 20,
      S.of(context).countryUK: 19,
      S.of(context).countryNorway: 17,
      S.of(context).countryIndia: 16,
      S.of(context).countryFrance: 16,
      S.of(context).countryMexico: 16,
      S.of(context).countryBrasil: 15,
      S.of(context).countryEgypt: 14,
      S.of(context).countryVietnam: 13,
      S.of(context).countryMorocco: 13,
      S.of(context).countryPhilippines: 13,
      S.of(context).countryCongo: 13,
      S.of(context).countrySoudan: 12,
    };
  }
}
