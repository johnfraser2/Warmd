import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../common/blue_card.dart';
import '../common/common.dart';
import '../common/criterias.dart';
import '../common/screen_template.dart';

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({Key key}) : super(key: key);

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
            'What should you do?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
          ),
          Gaps.h48,
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Text(
              'Small acts are welcomed, but they should not hide the truth: they are not enough to face the climate emergency, we need to focus on the big ones.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
            ),
          ),
          Gaps.h32,
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

    // Special treatment for the CountryCriteria one, which is certainly the first one to be displayed but can't be measured
    final countryCriteria = orderedAdvices.firstWhere((element) => element is CountryCriteria);
    orderedAdvices.remove(countryCriteria);
    orderedAdvices.insert(0, countryCriteria);

    return orderedAdvices;
  }

  Widget _buildAdviceCard(BuildContext context, int position, Criteria crit, CriteriaCategory category) {
    return BlueCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${position + 1}.',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: position == 0 || crit.co2EqTonsPerYear() > 1 ? warmdRed : warmdBlue,
                      ),
                ),
                Gaps.w16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        category.title,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color: warmdDarkBlue,
                            ),
                      ),
                      if (crit.co2EqTonsPerYear() > 0)
                        Text(
                          crit.getFormatedFootprint(),
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.bold,
                                color: warmdDarkBlue,
                              ),
                        ),
                      Gaps.h12,
                    ],
                  ),
                ),
                if (category is! GeneralCategory)
                  SvgPicture.asset(
                    'assets/${category.key}.svg',
                    height: 48,
                  ),
              ],
            ),
          ),
          Gaps.h8,
          Text(
            crit.advice(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w300,
                ),
          ),
        ],
      ),
    );
  }
}
