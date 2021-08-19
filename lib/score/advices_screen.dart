import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:markup_text/markup_text.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warmd/common/blue_card.dart';
import 'package:warmd/common/criteria.dart';
import 'package:warmd/common/extensions.dart';
import 'package:warmd/common/screen_template.dart';
import 'package:warmd/common/states.dart';
import 'package:warmd/common/widgets.dart';
import 'package:warmd/translations/gen/l10n.dart';

class AdvicesScreen extends StatelessWidget {
  final Function(BuildContext) onSeeClimateChangeTapped;

  const AdvicesScreen({Key? key, required this.onSeeClimateChangeTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriaState>();

    final orderedAdvices = _getOrderedAdvices(context, state).asMap();

    return ScreenTemplate(
      body: Column(
        children: [
          SvgPicture.asset(
            'assets/sky.svg',
          ),
          const Gap(48),
          Text(
            Translation.current.advicesTitle,
            textAlign: TextAlign.center,
            style: context.textTheme.headline5?.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
          ),
          const Gap(48),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Text(
              Translation.current.advicesExplanation,
              textAlign: TextAlign.center,
              style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
            ),
          ),
          const Gap(32),
          _buildFirstAdviceCard(context, state),
          for (int position in orderedAdvices.keys) _buildCriteriaAdviceCard(context, position, state, orderedAdvices[position]!),
          _buildOtherPollutionTypesCard(context),
          const Gap(92),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              'assets/ice.svg',
            ),
          ),
        ],
      ),
    );
  }

  List<Criteria> _getOrderedAdvices(BuildContext context, CriteriaState state) {
    final orderedAdvices = <Criteria>[];
    for (final cat in state.categories) {
      for (final crit in cat.getCriteriaList()) {
        if (crit.advice() != null) orderedAdvices.add(crit);
      }
    }

    orderedAdvices.sort((a, b) => a.co2EqTonsPerYear().compareTo(b.co2EqTonsPerYear()) * -1);

    return orderedAdvices;
  }

  Widget _buildFirstAdviceCard(BuildContext context, CriteriaState state) {
    return _buildGenericAdviceCard(
      context: context,
      state: state,
      position: 0,
      title: Translation.current.advicesPoliticsCategory,
      iconName: 'vote',
      description: Translation.current.politicalAdvice,
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () => onSeeClimateChangeTapped(context),
          child: Text(
            Translation.current.advicesSeeClimateChange,
            textAlign: TextAlign.right,
            style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
          ),
        ),
      ),
    );
  }

  Widget _buildCriteriaAdviceCard(BuildContext context, int position, CriteriaState state, Criteria crit) {
    final countryCriteria = state.generalCategory.countryCriteria;

    final allCountriesLinks = crit.links();

    // We merge current country and international links
    final Map<String, Map<String, String>> links = allCountriesLinks != null
        ? ({}..addAll(allCountriesLinks[countryCriteria.getCountryCode()] ?? const {})..addAll(allCountriesLinks[''] ?? const {}))
        : const {};

    // We do not display links for other platforms (ie. we do not display app store links if we are on android)
    final Map<String, String> linksForCurrentPlatform = {};
    for (final l in links.entries) {
      linksForCurrentPlatform[l.key] = l.value.containsKey('all')
          ? l.value['all']!
          : Platform.isAndroid
              ? l.value['android']!
              : l.value['ios']!;
    }

    final linksWidget = links.isNotEmpty
        ? Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () => _showLinksBottomSheet(context, linksForCurrentPlatform),
              child: Text(
                Translation.current.advicesSeeLinks,
                textAlign: TextAlign.right,
                style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
              ),
            ),
          )
        : null;

    return _buildGenericAdviceCard(
      context: context,
      state: state,
      position: position + 1,
      co2EqTonsPerYear: crit.co2EqTonsPerYear(),
      title: crit.title(),
      iconName: crit.key,
      description: crit.advice()!,
      child: linksWidget,
    );
  }

  Widget _buildGenericAdviceCard(
      {required BuildContext context,
      required CriteriaState state,
      required int position,
      double? co2EqTonsPerYear,
      required String title,
      required String iconName,
      required String description,
      Widget? child}) {
    final percentValue = (100 ~/ (state.co2EqTonsPerYear() / (co2EqTonsPerYear ?? 1))).toString();
    final co2EqTonsPerMonth = (co2EqTonsPerYear ?? 1) / 12;

    return BlueCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${position + 1}.',
                  style: context.textTheme.headline3?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: co2EqTonsPerYear == null || co2EqTonsPerYear > 1 ? warmdRed : warmdBlue,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: warmdDarkBlue,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(4),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 42, maxWidth: 42),
                    child: SvgPicture.asset(
                      'assets/$iconName.svg',
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (co2EqTonsPerYear != null) ...[
            const Gap(12),
            Text(
              co2EqTonsPerMonth > 1
                  ? Translation.current.co2EqPercentTonsValue(percentValue, co2EqTonsPerMonth.toShortString(context, 1))
                  : Translation.current.co2EqPercentKgValue(percentValue, (co2EqTonsPerMonth * 1000).round().toString()),
              style: context.textTheme.subtitle2?.copyWith(
                color: warmdDarkBlue,
              ),
            ),
          ],
          const Gap(16),
          MarkupText(
            description,
            style: context.textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          if (child != null) child
        ],
      ),
    );
  }

  Widget _buildOtherPollutionTypesCard(BuildContext context) {
    return BlueCard(
      child: Text(
        Translation.current.advicesOtherPolutionTypes,
        style: context.textTheme.bodyText2,
      ),
    );
  }

  void _showLinksBottomSheet(BuildContext context, Map<String, String> links) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    for (MapEntry<String, String> link in links.entries)
                      ActionChip(
                        backgroundColor: warmdLightBlue,
                        shadowColor: Colors.grey[100],
                        label: Text(
                          link.key,
                          style: context.textTheme.bodyText1?.copyWith(color: warmdDarkBlue),
                        ),
                        onPressed: () async {
                          if (await canLaunch(link.value)) launch(link.value);
                        },
                      ),
                  ],
                ),
                const Gap(24),
                MarkupText(
                  Translation.current.advicesLinksExplanation,
                  style: context.textTheme.caption?.copyWith(color: warmdDarkBlue),
                ),
              ],
            ),
          );
        });
  }
}
