import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../common/common.dart';
import '../common/criterias.dart';
import '../generated/locale_keys.g.dart';

class CriteriasScreen extends StatelessWidget {
  final Function onSeeScoreTapped;

  const CriteriasScreen({@required this.onSeeScoreTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CriteriasState>();

    return _buildContent(context, state);
  }

  Widget _buildContent(BuildContext context, CriteriasState state) {
    return Scaffold(
      body: ListView(
          key: ValueKey(state),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          scrollDirection: Axis.vertical,
          children: [
            Gaps.h8,
            buildBackButton(context),
            ..._buildCategories(context, state),
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'You can always update the data later on.',
                textAlign: TextAlign.center,
                style: TextStyle(color: warmdDarkBlue, fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 32),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    onSeeScoreTapped();
                  },
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ]),
    );
  }

  List<Widget> _buildCategories(BuildContext context, CriteriasState state) {
    final cats = state.categories.clone()..removeAt(0); // We hide the country criteria since we selected it before

    return [
      for (CriteriaCategory cat in cats)
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                color: warmdLightBlue,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: [
                  Image(
                    image: AssetImage('assets/${cat.key}.webp'),
                    fit: BoxFit.cover,
                    height: 164,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
                    child: Builder(
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (Criteria crit in cat.criterias) ..._buildCriteria(context, state, crit),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ];
  }

  List<Widget> _buildCriteria(BuildContext context, CriteriasState state, Criteria c) {
    var unit = c.unit != null ? ' ' + c.unit : '';
    var valueWithUnit = NumberFormat.decimalPattern().format(c.currentValue.abs()).toString() + unit;

    return [
      Gaps.h32,
      Text(
        c.title,
        style: Theme.of(context).textTheme.subtitle1.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.bold),
      ),
      Gaps.h8,
      if (c.explanation != null) buildSmartText(context, c.explanation),
      Gaps.h8,
      if (c.labels != null) _buildDropdown(context, c, state) else _buildSlider(c, valueWithUnit, context, state),
      Gaps.h8,
    ];
  }

  Widget _buildDropdown(BuildContext context, Criteria c, CriteriasState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[50],
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
                        style: Theme.of(context).textTheme.bodyText2.copyWith(color: _getDropdownTextColor(c, index)),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Color _getDropdownTextColor(Criteria c, int value) {
    if (c is CountryCriteria) return Colors.black;

    if (value == c.minValue) {
      return Colors.green;
    } else if (value == c.maxValue) {
      return Colors.orange;
    } else {
      return Colors.black;
    }
  }

  Widget _buildSlider(Criteria c, String valueWithUnit, BuildContext context, CriteriasState state) {
    const valueTextStyle = TextStyle(color: warmdDarkBlue);

    final valueText1 = valueToShortString(c.minValue);
    final valueText2 = valueToShortString((c.maxValue + c.minValue) * 0.25);
    final valueText3 = valueToShortString((c.maxValue + c.minValue) * 0.5);
    final valueText4 = valueToShortString((c.maxValue + c.minValue) * 0.75);
    final valueText5 = valueToShortString(c.maxValue);

    final shouldDisplayOnlyThreeValues =
        valueText2 == valueText1 || valueText2 == valueText3 || valueText4 == valueText3 || valueText4 == valueText5;

    return Column(
      children: [
        Slider(
          min: c.minValue,
          max: c.maxValue,
          divisions: (c.maxValue - c.minValue) ~/ c.step,
          label: c.labels != null
              ? c.labels[c.currentValue.toInt()]
              : c.currentValue != c.maxValue || c is CleanElectricityCriteria
                  ? valueWithUnit
                  : LocaleKeys.valueWithMore.tr(args: [valueWithUnit]),
          value: c.currentValue,
          onChanged: (double value) {
            c.currentValue = value;
            state.persist(c);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(valueText1, style: valueTextStyle),
              if (!shouldDisplayOnlyThreeValues) Text(valueText2, style: valueTextStyle),
              Text(valueText3, style: valueTextStyle),
              if (!shouldDisplayOnlyThreeValues) Text(valueText4, style: valueTextStyle),
              Text(valueText5 + '+', style: valueTextStyle),
            ],
          ),
        )
      ],
    );
  }

  String valueToShortString(double value) {
    var intValue = value.toInt();
    if (intValue < 1000) {
      return intValue.toString();
    } else {
      return (intValue ~/ 1000).toString() + 'K';
    }
  }
}
