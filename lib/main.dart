import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'categories/categories_screens.dart';
import 'common/common.dart';
import 'common/delayable_state.dart';
import 'common/states.dart';
import 'generated/codegen_loader.g.dart';
import 'onboarding/country_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'onboarding/welcome_screen.dart';
import 'score/about_screen.dart';
import 'score/advices_screen.dart';
import 'score/climate_change_screen.dart';
import 'score/footprint_screen.dart';
import 'splash_screen.dart';

void main() async {
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [const Locale('en'), const Locale('fr')],
    fallbackLocale: const Locale('en'),
    saveLocale: false,
    path: 'resources/langs',
    assetLoader: const CodegenLoader(),
    useOnlyLangCode: true,
  ));

  await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends DelayableState<MyApp> {
  var _splashScreenSeen = false;
  var _onboardingStepsNum = 0;
  var _showAdvicesScreen = false;
  var _showClimateChangeScreen = false;
  var _showClimateChangeScreenFromActions = false;
  var _showAboutScreen = false;
  var _questionnaireStepsNum = 0;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    delay(const Duration(seconds: 2), () {
      setState(() {
        _splashScreenSeen = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warmd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
          ChangeNotifierProvider(create: (_) => CriteriasState()),
        ],
        child: Builder(
          builder: (context) {
            final historyState = context.watch<HistoryState>();

            return historyState.scores == null
                ? Container()
                : WillPopScope(
                    onWillPop: () async {
                      _onPopPage();
                      return false;
                    },
                    child: Navigator(
                      key: _navigatorKey,
                      pages: [
                        if (!_splashScreenSeen)
                          const MaterialPage<SplashScreen>(
                            child: SplashScreen(),
                          ),
                        if (_splashScreenSeen && historyState.scores.isEmpty && _onboardingStepsNum == 0)
                          MaterialPage<OnboardingScreen>(
                            child: OnboardingScreen(
                              onOnboardingFinished: () {
                                setState(() {
                                  _onboardingStepsNum++;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && historyState.scores.isEmpty && _onboardingStepsNum == 1)
                          MaterialPage<WelcomeScreen>(
                            child: WelcomeScreen(
                              onStartSelected: () {
                                setState(() {
                                  _onboardingStepsNum++; // Will remove all onboarding screens from stack
                                  _questionnaireStepsNum = 1; // We start the questionnaire
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && historyState.scores.isNotEmpty)
                          MaterialPage<FootprintScreen>(
                            child: FootprintScreen(
                              onSeeClimateChangeTapped: () {
                                setState(() {
                                  _showClimateChangeScreen = true;
                                });
                              },
                              onSeeAdvicesTapped: () {
                                setState(() {
                                  _showAdvicesScreen = true;
                                });
                              },
                              onRestartTapped: () {
                                setState(() {
                                  _questionnaireStepsNum = 1;
                                });
                              },
                              onSeeAboutTapped: () {
                                setState(() {
                                  _showAboutScreen = true;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && _showAdvicesScreen)
                          MaterialPage<AdvicesScreen>(
                            child: AdvicesScreen(
                              onSeeClimateChangeTapped: () {
                                setState(() {
                                  _showClimateChangeScreenFromActions = true;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && (_showClimateChangeScreen || _showClimateChangeScreenFromActions))
                          const MaterialPage<ClimateChangeScreen>(
                            child: ClimateChangeScreen(),
                          ),
                        if (_splashScreenSeen && _showAboutScreen)
                          const MaterialPage<AboutScreen>(
                            child: AboutScreen(),
                          ),
                        if (_splashScreenSeen && _questionnaireStepsNum >= 1)
                          MaterialPage<CountryScreen>(
                            child: CountryScreen(
                              onCountrySelected: () {
                                setState(() {
                                  _questionnaireStepsNum++;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && _questionnaireStepsNum >= 2)
                          MaterialPage<UtilitiesCategoryScreen>(
                            child: UtilitiesCategoryScreen(
                              onContinueTapped: () {
                                setState(() {
                                  _questionnaireStepsNum++;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && _questionnaireStepsNum >= 3)
                          MaterialPage<TravelCategoryScreen>(
                            child: TravelCategoryScreen(
                              onContinueTapped: () {
                                setState(() {
                                  _questionnaireStepsNum++;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && _questionnaireStepsNum >= 4)
                          MaterialPage<FoodCategoryScreen>(
                            child: FoodCategoryScreen(
                              onContinueTapped: () {
                                setState(() {
                                  _questionnaireStepsNum++;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && _questionnaireStepsNum >= 5)
                          MaterialPage<GoodsCategoryScreen>(
                            child: GoodsCategoryScreen(
                              onContinueTapped: () {
                                setState(() {
                                  final now = DateTime.now();
                                  historyState.addScore(
                                    DateTime.utc(now.year, now.month),
                                    context.read<CriteriasState>().co2EqTonsPerYear(),
                                  );
                                  _questionnaireStepsNum = 0;
                                });
                              },
                            ),
                          ),
                      ],
                      onPopPage: (route, dynamic result) {
                        if (!route.didPop(result)) {
                          return false;
                        }

                        _onPopPage();
                        return true;
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }

  void _onPopPage() {
    setState(() {
      if (_showClimateChangeScreenFromActions) {
        _showClimateChangeScreenFromActions = false;
      } else if (_showAdvicesScreen) {
        _showAdvicesScreen = false;
      } else if (_showClimateChangeScreen) {
        _showClimateChangeScreen = false;
      } else if (_showAboutScreen) {
        _showAboutScreen = false;
      } else if (_questionnaireStepsNum > 0) {
        _questionnaireStepsNum--;
      } else if (_onboardingStepsNum > 0) {
        _onboardingStepsNum--;
      }
    });
  }
}
