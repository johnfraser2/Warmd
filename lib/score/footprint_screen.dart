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

class FootprintScreen extends StatelessWidget {
  final Function onSeeClimateChangeTapped;
  final Function onSeeAdvicesTapped;
  final Function onRestartTapped;
  final Function onSeeAboutTapped;

  const FootprintScreen(
      {@required this.onSeeClimateChangeTapped,
      @required this.onSeeAdvicesTapped,
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
        temp.putIfAbsent(
            LocaleKeys.category_short_footprint
                .tr(namedArgs: {'cat': cat.title, 'tons': cat.co2EqTonsPerYear().toStringAsFixed(1)}),
            () => cat.co2EqTonsPerYear().toDouble());
      }
    }
    final dataMap = temp.sort((a, b) => -a.value.compareTo(b.value));

    return Scaffold(
      backgroundColor: warmdLightBlue, // for iOS scrolling effect
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
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
          ),
        ),
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
                          Share.share(
                              "${LocaleKeys.footprintTitle.tr()}\n\n${dataMap.keys.join("\n")}\n\n${LocaleKeys.doneWith.tr()}\nAndroid app: https://play.google.com/store/apps/details?id=net.frju.verdure\niOS app: https://apps.apple.com/fr/app/warmd/id1487848837",
                              subject: 'Warmd');
                        }),
                  ],
                ),
              ),
              Gaps.h16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Text(
                  LocaleKeys.footprintTitle.tr(),
                  style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: ScoreWidget(state)),
              Gaps.h32,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Center(
                  child: TextButton(
                    onPressed: () => onSeeClimateChangeTapped(),
                    child: Text(
                      LocaleKeys.footprintWarning.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => onSeeAdvicesTapped(),
                        child: Text(
                          LocaleKeys.seeAdvices.tr(),
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
                          LocaleKeys.redoQuestionnaire.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontWeight: FontWeight.bold, color: Colors.grey[600]),
                        ),
                        style: greyButtonStyle,
                      ),
                    ),
                  ],
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
          LocaleKeys.footprintAnalysisTitle.tr(),
          style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold),
        ),
        Gaps.h24,
        SizedBox(
          height: 200,
          child: Center(
            child: PieChart(
              dataMap: dataMap,
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                chartValueStyle: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoToSourcesButton(BuildContext context) {
    return GestureDetector(
      child: Container(
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
                  LocaleKeys.seeAbout.tr(),
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
      onTap: () => onSeeAboutTapped(),
    );
  }
}
