import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:markup_text/markup_text.dart';
import 'package:warmd/common/blue_card.dart';
import 'package:warmd/common/extensions.dart';
import 'package:warmd/common/screen_template.dart';
import 'package:warmd/common/widgets.dart';
import 'package:warmd/translations/gen/l10n.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      body: Column(
        children: [
          SvgPicture.asset(
            'assets/splash.svg',
          ),
          const Gap(48),
          _buildWarmdProjectCard(context),
          _buildSourcesCard(context),
          const Gap(48),
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

  Widget _buildWarmdProjectCard(BuildContext context) {
    return BlueCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translation.current.aboutProjectTitle,
            style: context.textTheme.subtitle1?.copyWith(
              color: warmdDarkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          MarkupText(
            Translation.current.aboutProjectDescription,
            style: context.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w300),
          ),
          const Gap(16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async {
                final inAppReview = InAppReview.instance;

                //TODO it seems the requestReview never works on Android, not sure why
                // see https://github.com/britannio/in_app_review/issues/12
                if (Platform.isIOS && await inAppReview.isAvailable()) {
                  await inAppReview.requestReview();
                } else {
                  await inAppReview.openStoreListing();
                }
              },
              child: Text(
                Translation.current.aboutRateIt,
                textAlign: TextAlign.right,
                style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourcesCard(BuildContext context) {
    return BlueCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translation.current.aboutSourcesTitle,
            style: context.textTheme.subtitle1?.copyWith(
              color: warmdDarkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          MarkupText(
            Translation.current.aboutSourcesDescription,
            style: context.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
