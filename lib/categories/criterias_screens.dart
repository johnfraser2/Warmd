import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../common/common.dart';
import '../common/criterias.dart';
import '../common/screen_template.dart';
import '../generated/locale_keys.g.dart';

class UtilitiesCategoryScreen extends StatelessWidget {
  final Function onContinueTapped;

  const UtilitiesCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[1], progressValue: 0.2, onContinueTapped: onContinueTapped);
  }
}

class TravelCategoryScreen extends StatelessWidget {
  final Function onContinueTapped;

  const TravelCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[2], progressValue: 0.4, onContinueTapped: onContinueTapped);
  }
}

class FoodCategoryScreen extends StatelessWidget {
  final Function onContinueTapped;

  const FoodCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[3], progressValue: 0.6, onContinueTapped: onContinueTapped);
  }
}

class GoodsCategoryScreen extends StatelessWidget {
  final Function onContinueTapped;

  const GoodsCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[4], progressValue: 0.8, onContinueTapped: onContinueTapped);
  }
}

class _CriteriasScreen extends StatelessWidget {
  final CriteriaCategory criteriaCategory;
  final double progressValue;
  final Function onContinueTapped;

  const _CriteriasScreen(
      {@required this.criteriaCategory, @required this.progressValue, @required this.onContinueTapped, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CriteriasState>();

    return ScreenTemplate(
      progressValue: progressValue,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/${criteriaCategory.key}.svg',
              height: 96,
            ),
            Gaps.h16,
            Text(
              criteriaCategory.title,
              style: Theme.of(context).textTheme.headline5.copyWith(color: warmdGreen, fontWeight: FontWeight.bold),
            ),
            Gaps.h32,
            for (Criteria crit in criteriaCategory.criterias) _buildCriteria(context, state, crit),
            Gaps.h32,
            Text(
              'You can always update the data later on.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: warmdDarkBlue),
            ),
            Gaps.h24,
            Center(
              child: ElevatedButton(
                onPressed: () {
                  onContinueTapped();
                },
                child: const Text('CONTINUE'),
              ),
            ),
            Gaps.h48,
          ],
        ),
      ),
    );
  }

  Widget _buildCriteria(BuildContext context, CriteriasState state, Criteria c) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: warmdLightBlue,
      ),
      padding: const EdgeInsets.symmetric(vertical: 32),
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              c.title,
              style: Theme.of(context).textTheme.subtitle1.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.bold),
            ),
          ),
          Gaps.h8,
          if (c.explanation != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: buildSmartText(context, c.explanation),
            ),
          Gaps.h8,
          if (c.labels != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _buildDropdown(context, c, state),
            )
          else
            _buildSlider(c, context, state),
        ],
      ),
    );
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

  Widget _buildSlider(Criteria c, BuildContext context, CriteriasState state) {
    var unit = c.unit != null ? ' ' + c.unit : '';
    var valueWithUnit = NumberFormat.decimalPattern().format(c.currentValue.abs()).toString() + unit;

    const valueTextStyle = TextStyle(color: warmdDarkBlue);

    final quarter = (c.maxValue - c.minValue) / 4;
    final valueText1 = valueToShortString(c.minValue);
    final valueText2 = valueToShortString(c.minValue + quarter);
    final valueText3 = valueToShortString(c.minValue + 2 * quarter);
    final valueText4 = valueToShortString(c.minValue + 3 * quarter);
    final valueText5 = valueToShortString(c.maxValue);

    final shouldDisplayOnlyThreeValues =
        valueText2 == valueText1 || valueText2 == valueText3 || valueText4 == valueText3 || valueText4 == valueText5;

    return Column(
      children: [
        FractionallySizedBox(
          widthFactor:
              0.92, // We need this to be aligned with the number's row below. Not perfect, could this be improved by using LayoutBuilder?
          child: Slider(
            min: c.minValue,
            max: c.maxValue,
            divisions: (c.maxValue - c.minValue) ~/ c.step,
            label: c.labels != null
                ? c.labels[c.currentValue.toInt()]
                : c.currentValue != c.maxValue || c.unit == '%' // We can't go above 100% so we don't display "or more"
                    ? valueWithUnit
                    : c.minValue < 0 // Some values are negatives because more is better (like mpg)
                        ? LocaleKeys.valueWithLess.tr(args: [valueWithUnit])
                        : LocaleKeys.valueWithMore.tr(args: [valueWithUnit]),
            value: c.currentValue,
            onChanged: (double value) {
              c.currentValue = value;
              state.persist(c);
            },
          ),
        ),
        Row(
          children: [
            Expanded(child: Center(child: Text(valueText1, style: valueTextStyle))),
            if (!shouldDisplayOnlyThreeValues) Expanded(child: Center(child: Text(valueText2, style: valueTextStyle))),
            Expanded(child: Center(child: Text(valueText3, style: valueTextStyle))),
            if (!shouldDisplayOnlyThreeValues) Expanded(child: Center(child: Text(valueText4, style: valueTextStyle))),
            Expanded(child: Center(child: Text(valueText5 + (c.minValue < 0 ? '' : '+'), style: valueTextStyle))),
          ],
        )
      ],
    );
  }

  String valueToShortString(double value) {
    var intValue = value.abs().round();
    if (intValue < 1000) {
      return intValue.toString();
    } else {
      return (intValue ~/ 1000).toString() + 'K';
    }
  }
}
