import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

class UtilitiesCategoryScreen extends StatelessWidget {
  final Function(BuildContext) onContinueTapped;

  const UtilitiesCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[1], progressValue: 0.3, onContinueTapped: onContinueTapped);
  }
}

class TravelCategoryScreen extends StatelessWidget {
  final Function(BuildContext) onContinueTapped;

  const TravelCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[2], progressValue: 0.5, onContinueTapped: onContinueTapped);
  }
}

class FoodCategoryScreen extends StatelessWidget {
  final Function(BuildContext) onContinueTapped;

  const FoodCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[3], progressValue: 0.7, onContinueTapped: onContinueTapped);
  }
}

class GoodsCategoryScreen extends StatelessWidget {
  final Function(BuildContext) onContinueTapped;

  const GoodsCategoryScreen({@required this.onContinueTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();

    return _CriteriasScreen(criteriaCategory: state.categories[4], progressValue: 0.9, onContinueTapped: onContinueTapped);
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
              widget.criteriaCategory.title(context),
              style: Theme.of(context).textTheme.headline5.copyWith(color: warmdGreen, fontWeight: FontWeight.bold),
            ),
            Gaps.h32,
            // We display all criterias, except the one that are necessarily at a specific value (like clean energy percent for some countries)
            for (Criteria crit in widget.criteriaCategory.criterias)
              if (crit.maxValue > crit.minValue) _buildCriteria(context, state, crit),
            Gaps.h32,
            Text(
              AppLocalizations.of(context).continueActionExplanation,
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
                child: Text(AppLocalizations.of(context).continueAction),
              ),
            ),
            Gaps.h48,
          ],
        ),
      ),
    );
  }

  Widget _buildCriteria(BuildContext context, CriteriasState state, Criteria c) {
    final explanation = c.explanation(context);

    return BlueCard(
      padding: const EdgeInsets.only(top: 28, bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    c.title(context),
                    style: Theme.of(context).textTheme.subtitle1.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.bold),
                  ),
                ),
                Gaps.w12,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 42, maxWidth: 42),
                  child: SvgPicture.asset(
                    'assets/${c.key}.svg',
                  ),
                ),
              ],
            ),
          ),
          Gaps.h12,
          if (explanation != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: MarkupText(
                explanation,
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey[600], fontWeight: FontWeight.w300),
              ),
            ),
          Gaps.h8,
          if (c.labels(context) != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _buildDropdown(context, c, state),
            )
          else
            _buildSlider(c, context, state),
          if (c.shortcuts(context) != null)
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 32, right: 32),
              child: _buildShortcutChips(context, state, c),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdown(BuildContext context, Criteria c, CriteriasState state) {
    final labels = c.labels(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<int>(
            isExpanded: true,
            selectedItemBuilder: (BuildContext context) {
              return labels.map((String item) {
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
            items: labels
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

    String valueToShortString(double value) {
      final intValue = value.abs().round();
      if (intValue < 1000) {
        return intValue.toString();
      } else {
        return '${intValue ~/ 1000}K';
      }
    }

    final quarter = (c.maxValue - c.minValue) / 4;
    final valueText1 = valueToShortString(c.minValue);
    final valueText2 = valueToShortString(c.minValue + quarter);
    final valueText3 = valueToShortString(c.minValue + 2 * quarter);
    final valueText4 = valueToShortString(c.minValue + 3 * quarter);
    final valueText5 = valueToShortString(c.maxValue);

    final shouldDisplayOnlyThreeValues =
        valueText2 == valueText1 || valueText2 == valueText3 || valueText4 == valueText3 || valueText4 == valueText5;

    final labels = c.labels(context);

    return Column(
      children: [
        FractionallySizedBox(
          widthFactor:
              0.92, // We need this to be aligned with the number's row below. Not perfect, could this be improved by using LayoutBuilder?
          child: Slider(
            min: c.minValue,
            max: c.maxValue,
            divisions: (c.maxValue - c.minValue) ~/ c.step,
            label: labels != null
                ? labels[c.currentValue.toInt()]
                : c.currentValue != c.maxValue || c.unit == '%' // We can't go above 100% so we don't display "or more"
                    ? valueWithUnit
                    : c.minValue < 0 // Some values are negatives because more is better (like mpg)
                        ? AppLocalizations.of(context).valueWithLess(valueWithUnit)
                        : AppLocalizations.of(context).valueWithMore(valueWithUnit),
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

  Widget _buildShortcutChips(BuildContext context, CriteriasState state, Criteria c) {
    final shortcuts = c.shortcuts(context);

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        children: [
          ...shortcuts.entries.map((entry) => ActionChip(
                label: Text(
                  entry.key,
                  style: const TextStyle(color: warmdDarkBlue),
                ),
                shape: const StadiumBorder(side: BorderSide(color: warmdDarkBlue)),
                backgroundColor: warmdLightBlue,
                onPressed: () {
                  c.currentValue = entry.value;
                  state.persist(c);
                },
              ))
        ],
      ),
    );
  }
}
