import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:warmd/common/blue_card.dart';
import 'package:warmd/common/common.dart';
import 'package:warmd/common/criterias.dart';
import 'package:warmd/common/screen_template.dart';
import 'package:warmd/generated/locale_keys.g.dart';

class AdvicesScreen extends StatelessWidget {
  final Function onSeeClimateChangeTapped;

  const AdvicesScreen({@required this.onSeeClimateChangeTapped, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CriteriasState>();

    final orderedAdvices = _getOrderedAdvices(state).asMap();

    return ScreenTemplate(
      body: Column(
        children: [
          SvgPicture.asset(
            'assets/sky.svg',
          ),
          Gaps.h48,
          Text(
            LocaleKeys.advicesTitle.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
          ),
          Gaps.h48,
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Text(
              LocaleKeys.advicesExplanation.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
            ),
          ),
          Gaps.h32,
          _buildPolicalAdviceCard(context),
          for (int position in orderedAdvices.keys)
            _buildAdviceCard(context, position, orderedAdvices[position],
                state.categories.firstWhere((cat) => cat.criterias.contains(orderedAdvices[position]))),
          Gaps.h128,
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

  List<Criteria> _getOrderedAdvices(CriteriasState state) {
    final orderedAdvices = <Criteria>[];
    state.categories.forEach((cat) {
      cat.criterias.forEach((crit) {
        if (crit.advice() != null) orderedAdvices.add(crit);
      });
    });

    orderedAdvices.sort((a, b) => a.co2EqTonsPerYear().compareTo(b.co2EqTonsPerYear()) * -1);

    return orderedAdvices;
  }

  Widget _buildPolicalAdviceCard(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: BlueCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    '1.',
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: warmdRed,
                        ),
                  ),
                  Gaps.w16,
                  Expanded(
                    child: Text(
                      LocaleKeys.advicesPoliticsCategory.tr(),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: warmdDarkBlue,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.h8,
            Text(
              LocaleKeys.politicalAdvice.tr(),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => onSeeClimateChangeTapped(),
                child: Text(
                  LocaleKeys.advicesSeeClimateChange.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdviceCard(BuildContext context, int position, Criteria crit, CriteriaCategory category) {
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
                    '${position + 2}.',
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: crit.co2EqTonsPerYear() > 1 ? warmdRed : warmdBlue,
                        ),
                  ),
                  Gaps.w16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          crit.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                fontWeight: FontWeight.bold,
                                color: warmdDarkBlue,
                              ),
                        ),
                        Gaps.h8,
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/${category.key}.svg',
                    height: 48,
                  ),
                ],
              ),
            ),
            if (crit.co2EqTonsPerYear() > 0) Gaps.h12,
            if (crit.co2EqTonsPerYear() > 0)
              Text(
                crit.getFormatedFootprint(),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: warmdDarkBlue,
                    ),
              ),
            Gaps.h16,
            Text(
              crit.advice(),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
