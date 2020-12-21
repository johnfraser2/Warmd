import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:markup_text/markup_text.dart';
import 'package:provider/provider.dart';
import 'package:warmd/common/blue_card.dart';
import 'package:warmd/common/common.dart';
import 'package:warmd/common/criterias.dart';
import 'package:warmd/common/delayable_state.dart';
import 'package:warmd/common/screen_template.dart';
import 'package:warmd/common/states.dart';
import 'package:warmd/generated/locale_keys.g.dart';

class UtilitiesCategoryScreen extends StatelessWidget {
  final Function(BuildContext) onContinueTapped;

  const UtilitiesCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[1], progressValue: 0.2, onContinueTapped: onContinueTapped);
  }
}

class TravelCategoryScreen extends StatelessWidget {
  final Function(BuildContext) onContinueTapped;

  const TravelCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[2], progressValue: 0.4, onContinueTapped: onContinueTapped);
  }
}

class FoodCategoryScreen extends StatelessWidget {
  final Function(BuildContext) onContinueTapped;

  const FoodCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[3], progressValue: 0.6, onContinueTapped: onContinueTapped);
  }
}

class GoodsCategoryScreen extends StatelessWidget {
  final Function(BuildContext) onContinueTapped;

  const GoodsCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[4], progressValue: 0.8, onContinueTapped: onContinueTapped);
  }
}

class _CriteriasScreen extends StatefulWidget {
  final CriteriaCategory criteriaCategory;
  final double progressValue;
  final Function(BuildContext) onContinueTapped;

  const _CriteriasScreen(
      {@required this.criteriaCategory, @required this.progressValue, @required this.onContinueTapped, Key key})
      : super(key: key);

  @override
  _CriteriasScreenState createState() => _CriteriasScreenState();
}

class _CriteriasScreenState extends DelayableState<_CriteriasScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();

    return ScreenTemplate(
      progressValue: widget.progressValue,
      scrollController: _scrollController,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/${widget.criteriaCategory.key}.svg',
              height: 96,
            ),
            Gaps.h16,
            Text(
              widget.criteriaCategory.title,
              style: Theme.of(context).textTheme.headline5.copyWith(color: warmdGreen, fontWeight: FontWeight.bold),
            ),
            Gaps.h32,
            // We display all criterias, except the one that are necessarily at a specific value (like clean energy percent for some countries)
            for (Criteria crit in widget.criteriaCategory.criterias)
              if (crit.maxValue > crit.minValue) _buildCriteria(context, state, crit),
            Gaps.h32,
            Text(
              LocaleKeys.continueActionExplanation.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: warmdDarkBlue),
            ),
            Gaps.h24,
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // We want to scroll back to the top, so that we can clearly see in what category we arrive
                  delay(const Duration(milliseconds: 500), () => _scrollController.jumpTo(0));

                  widget.onContinueTapped(context);
                },
                child: Text(LocaleKeys.continueAction.tr()),
              ),
            ),
            Gaps.h48,
          ],
        ),
      ),
    );
  }

  Widget _buildCriteria(BuildContext context, CriteriasState state, Criteria c) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: BlueCard(
        padding: const EdgeInsets.symmetric(vertical: 32),
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
                child: MarkupText(
                  c.explanation,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey[600], fontWeight: FontWeight.w300),
                ),
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
    final unit = c.unit != null ? ' ${c.unit}' : '';
    final valueWithUnit = NumberFormat.decimalPattern().format(c.currentValue.abs()).toString() + unit;

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
            Expanded(
                child: Center(child: Text(valueText5 + (c.minValue < 0 || c.unit == '%' ? '' : '+'), style: valueTextStyle))),
          ],
        )
      ],
    );
  }

  String valueToShortString(double value) {
    final intValue = value.abs().round();
    if (intValue < 1000) {
      return intValue.toString();
    } else {
      return '${intValue ~/ 1000}K';
    }
  }
}
