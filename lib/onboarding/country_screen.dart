import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../common/common.dart';
import '../common/criterias.dart';
import '../common/steps_progress_indicator.dart';
import '../generated/locale_keys.g.dart';

class CountryScreen extends StatelessWidget {
  final Function onCountrySelected;

  const CountryScreen({@required this.onCountrySelected, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();
    final c = state.categories[0].criterias[0];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.h16,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: StepsProgressIndicator(value: 0.1),
            ),
            Gaps.h64,
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.countrySelectionTitle.tr(),
                      style: Theme.of(context).textTheme.headline6.copyWith(color: warmdBlue, fontWeight: FontWeight.bold),
                    ),
                    Gaps.h32,
                    Text(
                      LocaleKeys.countrySelectionQuestion.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
                    ),
                    Gaps.h64,
                    Container(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          selectedItemBuilder: (BuildContext context) {
                            return c.labels.map((String item) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              );
                            }).toList();
                          },
                          value: c.currentValue.toInt(),
                          underline: Container(),
                          onChanged: (int value) {
                            c.currentValue = value.toDouble();
                            state.persist(c);
                          },
                          items: c.labels
                              .mapIndexed((index, label) => DropdownMenuItem<int>(
                                    value: index,
                                    child: Text(
                                      label,
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    Gaps.h32,
                    Text(
                      LocaleKeys.countrySelectionExplanation.tr(),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(color: warmdDarkBlue),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  onCountrySelected();
                },
                child: Text(LocaleKeys.continueAction.tr()),
              ),
            ),
            Gaps.h64,
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
