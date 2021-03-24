import 'dart:math';
import 'dart:ui';

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'categories/categories_screens.dart';
import 'common/states.dart';
import 'common/widgets.dart';
import 'onboarding/country_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'onboarding/welcome_screen.dart';
import 'score/about_screen.dart';
import 'score/advices_screen.dart';
import 'score/climate_change_screen.dart';
import 'score/footprint_screen.dart';
import 'splash_screen.dart';

void main() {
  runApp(MyApp());

  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  // Block rotation on small screens (smartphones) since current UI is not always adapted to small height
  final windowSize = MediaQueryData.fromWindow(window).size;
  if (min(windowSize.height, windowSize.width) < 600) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warmd',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('fr', ''),
        Locale('it', ''),
        Locale('de', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        sliderTheme: SliderTheme.of(context).copyWith(
          activeTrackColor: warmdRed,
          inactiveTrackColor: Colors.grey[300],
          thumbColor: Colors.white,
          tickMarkShape: SliderTickMarkShape.noTickMark,
          trackHeight: 8,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(warmdRed),
            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            )),
            textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
              fontFamily: 'VarelaRound',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
            elevation: MaterialStateProperty.all<double>(0),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 72, vertical: 14)),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'VarelaRound',
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HistoryState()),
          ChangeNotifierProvider(create: (_) => CriteriaState()),
        ],
        child: Builder(
          builder: (context) {
            final historyState = context.watch<HistoryState>();

            return FlowBuilder<NavState>(
              state: NavState(),
              onGeneratePages: (navState, pages) => [
                if (historyState.scores == null || !navState.splashScreenSeen)
                  MaterialPage<SplashScreen>(
                    child: SplashScreen(
                      onFinished: (context) => context.navUpdate((navState) => navState.copyWith(splashScreenSeen: true)),
                    ),
                  ),
                if (navState.splashScreenSeen) ...[
                  if (historyState.scores!.isEmpty && navState.onboardingStepsNum == 0)
                    MaterialPage<OnboardingScreen>(
                      child: OnboardingScreen(
                        onOnboardingFinished: (context) => context
                            .navUpdate((navState) => navState.copyWith(onboardingStepsNum: navState.onboardingStepsNum + 1)),
                      ),
                    ),
                  if (historyState.scores!.isEmpty && navState.onboardingStepsNum == 1)
                    MaterialPage<WelcomeScreen>(
                      child: WelcomeScreen(
                        onStartSelected: (context) => context.navUpdate((navState) => navState.copyWith(
                              onboardingStepsNum:
                                  navState.onboardingStepsNum + 1, // Will remove all onboarding screens from stack
                              questionnaireStepsNum: 1, // We start the questionnaire
                            )),
                      ),
                    ),
                  if (historyState.scores!.isNotEmpty)
                    MaterialPage<FootprintScreen>(
                      child: FootprintScreen(
                        onSeeClimateChangeTapped: (context) =>
                            context.navUpdate((navState) => navState.copyWith(showClimateChangeScreen: true)),
                        onSeeAdvicesTapped: (context) =>
                            context.navUpdate((navState) => navState.copyWith(showAdvicesScreen: true)),
                        onRestartTapped: (context) =>
                            context.navUpdate((navState) => navState.copyWith(questionnaireStepsNum: 1)),
                        onSeeAboutTapped: (context) => context.navUpdate((navState) => navState.copyWith(showAboutScreen: true)),
                      ),
                    ),
                  if (navState.showAdvicesScreen)
                    MaterialPage<AdvicesScreen>(
                      child: AdvicesScreen(
                        onSeeClimateChangeTapped: (context) =>
                            context.navUpdate((navState) => navState.copyWith(showClimateChangeScreenFromActions: true)),
                      ),
                    ),
                  if (navState.showClimateChangeScreen || navState.showClimateChangeScreenFromActions)
                    const MaterialPage<ClimateChangeScreen>(
                      child: ClimateChangeScreen(),
                    ),
                  if (navState.showAboutScreen)
                    const MaterialPage<AboutScreen>(
                      child: AboutScreen(),
                    ),
                  if (navState.questionnaireStepsNum >= 1)
                    MaterialPage<CountryScreen>(
                      child: CountryScreen(
                        onCountrySelected: (context) => context.navUpdate(
                            (navState) => navState.copyWith(questionnaireStepsNum: navState.questionnaireStepsNum + 1)),
                      ),
                    ),
                  if (navState.questionnaireStepsNum >= 2)
                    MaterialPage<UtilitiesCategoryScreen>(
                      child: UtilitiesCategoryScreen(
                        onContinueTapped: (context) => context.navUpdate(
                            (navState) => navState.copyWith(questionnaireStepsNum: navState.questionnaireStepsNum + 1)),
                      ),
                    ),
                  if (navState.questionnaireStepsNum >= 3)
                    MaterialPage<TravelCategoryScreen>(
                      child: TravelCategoryScreen(
                        onContinueTapped: (context) => context.navUpdate(
                            (navState) => navState.copyWith(questionnaireStepsNum: navState.questionnaireStepsNum + 1)),
                      ),
                    ),
                  if (navState.questionnaireStepsNum >= 4)
                    MaterialPage<FoodCategoryScreen>(
                      child: FoodCategoryScreen(
                        onContinueTapped: (context) => context.navUpdate(
                            (navState) => navState.copyWith(questionnaireStepsNum: navState.questionnaireStepsNum + 1)),
                      ),
                    ),
                  if (navState.questionnaireStepsNum >= 5)
                    MaterialPage<GoodsCategoryScreen>(
                      child: GoodsCategoryScreen(
                        onContinueTapped: (context) {
                          final now = DateTime.now();
                          historyState.addScore(
                            DateTime.utc(now.year, now.month),
                            context.read<CriteriaState>().co2EqTonsPerYear(),
                          );
                          context.navUpdate((navState) => navState.copyWith(questionnaireStepsNum: 0));
                        },
                      ),
                    ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

extension _NavFlow on BuildContext {
  void navUpdate(NavState Function(NavState) f) => flow<NavState>().update(f);
}
