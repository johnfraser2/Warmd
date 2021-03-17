import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:warmd/common/delayable_state.dart';
import 'package:warmd/common/extensions.dart';
import 'package:warmd/common/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  final Function(BuildContext) onOnboardingFinished;

  const OnboardingScreen({required this.onOnboardingFinished, Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends DelayableState<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/sky.svg',
            ),
            Expanded(
              child: PageIndicatorContainer(
                length: 2,
                padding: const EdgeInsets.all(10),
                indicatorColor: Colors.grey[300]!,
                indicatorSelectorColor: warmdDarkBlue,
                shape: IndicatorShape.circle(),
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/narwhal.svg',
                                height: MediaQuery.of(context).size.height / 4,
                              ),
                              Text(
                                context.i18n.onboardingStep1Title,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                              ),
                              const Gap(32),
                              Text(
                                context.i18n.onboardingStep1Description,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[600], fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/pinguin.svg',
                                height: MediaQuery.of(context).size.height / 4,
                              ),
                              Text(
                                context.i18n.onboardingStep2Title,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                              ),
                              const Gap(32),
                              Text(
                                context.i18n.onboardingStep2Description,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[600], fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    // else {
                    //   return Center(
                    //     child: ConstrainedBox(
                    //       constraints: const BoxConstraints(maxWidth: 350),
                    //       child: Column(
                    //         children: [
                    //           SvgPicture.asset(
                    //             'assets/seal.svg',
                    //             height: MediaQuery.of(context).size.height / 4,
                    //           ),
                    //           const Text(
                    //             'A climate-conscious community',
                    //             style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    //           ),
                    //           const Gap(32),
                    //           Text(
                    //             'Be part of a community to share your ideas, progress & much more.',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(color: Colors.grey[600], fontSize: 18),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   );
                    // }
                  },
                ),
              ),
            ),
            const Gap(24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  widget.onOnboardingFinished(context);
                },
                child: Text(context.i18n.onboardingAction),
              ),
            ),
            const Gap(64),
          ],
        ),
      ),
    );
  }
}
