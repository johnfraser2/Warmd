import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';
import 'package:warmd/common/extensions.dart';
import 'package:warmd/common/states.dart';
import 'package:warmd/common/steps_progress_indicator.dart';
import 'package:warmd/common/widgets.dart';

class CountryScreen extends StatelessWidget {
  final Function(BuildContext) onCountrySelected;

  const CountryScreen({Key? key, required this.onCountrySelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyState = context.watch<HistoryState>();
    final state = context.watch<CriteriaState>();
    final c = state.generalCategory.countryCriteria;
    final labels = c.labels(context);

    return Scaffold(
      resizeToAvoidBottomInset: false, // Usefull to have a better display when the keyboard is up
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: StepsProgressIndicator(value: 0.2),
            ),
            if (historyState.scores!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: buildBackButton(context),
              ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.i18n.countrySelectionTitle,
                      style: context.textTheme.headline6?.copyWith(color: warmdBlue, fontWeight: FontWeight.bold),
                    ),
                    const Gap(32),
                    Text(
                      context.i18n.countrySelectionQuestion,
                      textAlign: TextAlign.center,
                      style: context.textTheme.headline5?.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
                    ),
                    const Gap(32),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                        child: SearchChoices<String>.single(
                          items: labels.mapIndexed((idx, label) {
                            return DropdownMenuItem<String>(
                              value: label,
                              child: Text(label),
                            );
                          }).toList(),
                          displayClearIcon: false,
                          underline: Container(
                            height: 1,
                            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: warmdBlue, width: 2))),
                          ),
                          value: labels[c.currentValue.toInt()],
                          onChanged: (String value) {
                            c.currentValue = labels.indexOf(value).toDouble();
                            state.persist(c);
                          },
                          isExpanded: true,
                        ),
                      ),
                    ),
                    const Gap(32),
                    Text(
                      context.i18n.countrySelectionExplanation,
                      style: context.textTheme.subtitle2?.copyWith(color: warmdDarkBlue),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  onCountrySelected(context);
                },
                child: Text(context.i18n.continueAction),
              ),
            ),
            const Gap(48),
            SvgPicture.asset(
              'assets/bear.svg',
              height: MediaQuery.of(context).size.height / 6,
            ),
          ],
        ),
      ),
    );
  }
}
