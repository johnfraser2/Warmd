import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markup_text/markup_text.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warmd/common/blue_card.dart';
import 'package:warmd/common/common.dart';
import 'package:warmd/common/criterias.dart';
import 'package:warmd/common/screen_template.dart';
import 'package:warmd/common/states.dart';

class AdvicesScreen extends StatelessWidget {
  final Function(BuildContext) onSeeClimateChangeTapped;

  const AdvicesScreen({@required this.onSeeClimateChangeTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriasState>();

    final orderedAdvices = _getOrderedAdvices(context, state).asMap();

    return ScreenTemplate(
      body: Column(
        children: [
          SvgPicture.asset(
            'assets/sky.svg',
          ),
          Gaps.h48,
          Text(
            AppLocalizations.of(context).advicesTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
          ),
          Gaps.h48,
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Text(
              AppLocalizations.of(context).advicesExplanation,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
            ),
          ),
          Gaps.h32,
          _buildFirstAdviceCard(context, state),
          for (int position in orderedAdvices.keys) _buildCriteriaAdviceCard(context, position, state, orderedAdvices[position]),
          _buildOtherPollutionTypesCard(context),
          Gaps.h92,
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

  List<Criteria> _getOrderedAdvices(BuildContext context, CriteriasState state) {
    final orderedAdvices = <Criteria>[];
    for (final cat in state.categories) {
      for (final crit in cat.criterias) {
        if (crit.advice(context) != null) orderedAdvices.add(crit);
      }
    }

    orderedAdvices.sort((a, b) => a.co2EqTonsPerYear().compareTo(b.co2EqTonsPerYear()) * -1);

    return orderedAdvices;
  }

  Widget _buildFirstAdviceCard(BuildContext context, CriteriasState state) {
    return _buildGenericAdviceCard(
      context: context,
      state: state,
      position: 0,
      title: AppLocalizations.of(context).advicesPoliticsCategory,
      iconName: 'vote',
      description: AppLocalizations.of(context).politicalAdvice,
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () => onSeeClimateChangeTapped(context),
          child: Text(
            AppLocalizations.of(context).advicesSeeClimateChange,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
          ),
        ),
      ),
    );
  }

  Widget _buildCriteriaAdviceCard(BuildContext context, int position, CriteriasState state, Criteria crit) {
    final countryCriteria = state.categories[0].criterias[0] as CountryCriteria;

    final allCountriesLinks = crit.links();
    // We merge current country and international links
    final Map<String, String> links = allCountriesLinks != null
        ? ({}..addAll(allCountriesLinks[countryCriteria.getCountryCode()] ?? const {})..addAll(allCountriesLinks[''] ?? const {}))
        : const {};

    final linksWidget = links.isNotEmpty
        ? Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () => _showLinksBottomSheet(context, links),
              child: Text(
                AppLocalizations.of(context).advicesSeeLinks,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
              ),
            ),
          )
        : null;

    return _buildGenericAdviceCard(
      context: context,
      state: state,
      position: position + 1,
      co2Tons: crit.co2EqTonsPerYear(),
      title: crit.title(context),
      iconName: crit.key,
      description: crit.advice(context),
      child: linksWidget,
    );
  }

  Widget _buildGenericAdviceCard(
      {BuildContext context,
      CriteriasState state,
      int position,
      double co2Tons,
      String title,
      String iconName,
      String description,
      Widget child}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: BlueCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${position + 1}.',
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: co2Tons == null || co2Tons > 1 ? warmdRed : warmdBlue,
                        ),
                  ),
                  Gaps.w16,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                fontWeight: FontWeight.bold,
                                color: warmdDarkBlue,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.w4,
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
            if (co2Tons != null && co2Tons > 0) Gaps.h12,
            if (co2Tons != null && co2Tons > 0)
              Text(
                AppLocalizations.of(context).co2EqPercentValue(
                  (100 ~/ (state.co2EqTonsPerYear() / co2Tons)).toString(),
                  co2Tons.toStringAsFixed(1),
                ),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: warmdDarkBlue,
                    ),
              ),
            Gaps.h16,
            MarkupText(
              description,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
            if (child != null) child
          ],
        ),
      ),
    );
  }

  Widget _buildOtherPollutionTypesCard(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: BlueCard(
        child: Text(
          AppLocalizations.of(context).advicesOtherPolutionTypes,
          style: Theme.of(context).textTheme.bodyText2,
        ),
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
                          style: Theme.of(context).textTheme.bodyText1.copyWith(color: warmdDarkBlue),
                        ),
                        onPressed: () async {
                          if (await canLaunch(link.value)) launch(link.value);
                        },
                      ),
                  ],
                ),
                Gaps.h24,
                MarkupText(
                  AppLocalizations.of(context).advicesLinksExplanation,
                  style: Theme.of(context).textTheme.caption.copyWith(color: warmdDarkBlue),
                ),
              ],
            ),
          );
        });
  }
}
