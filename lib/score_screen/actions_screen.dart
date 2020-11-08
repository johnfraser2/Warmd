import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/common.dart';
import '../common/criterias.dart';
import '../common/screen_template.dart';
import '../generated/locale_keys.g.dart';

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CriteriasState>();

    return ScreenTemplate(
      body: Column(
        children: [
          Gaps.h32,
          Text(
            'What should you do?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.w700),
          ),
          Gaps.h32,
          _buildAdvicesCard(context, state),
        ],
      ),
    );
  }

  Widget _buildAdvicesCard(BuildContext context, CriteriasState state) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: warmdLightBlue,
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildAdviceWidgets(context, state),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAdviceWidgets(BuildContext context, CriteriasState state) {
    var list = [
      for (CriteriaCategory cat in state.categories) ..._buildCategoryAdviceWidgets(context, cat),
    ];

    return list.length > 1 ? list : [Text(LocaleKeys.noAdvicesExplanation.tr())];
  }

  List<Widget> _buildCategoryAdviceWidgets(BuildContext context, CriteriaCategory cat) {
    var list = [
      Gaps.h16,
      Text(
        cat.title,
        style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold),
      ),
      Gaps.h8,
      for (Criteria crit in cat.criterias)
        if (crit.advice() != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '• ${crit.advice()}',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
      Gaps.h16,
    ];

    return list.length > 4 ? list : [];
  }
}
