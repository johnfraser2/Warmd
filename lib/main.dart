import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categories/criterias_screens.dart';
import 'common/common.dart';
import 'common/criterias.dart';
import 'common/delayable_state.dart';
import 'generated/codegen_loader.g.dart';
import 'onboarding/country_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'score/actions_screen.dart';
import 'score/consequences_screen.dart';
import 'score/score_screen.dart';
import 'splash_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [const Locale('en'), const Locale('fr')],
    fallbackLocale: const Locale('en'),
    saveLocale: false,
    path: 'resources/langs',
    assetLoader: const CodegenLoader(),
    useOnlyLangCode: true,
  ));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

const _firstCategoryScreenNum = 2;

class _MyAppState extends DelayableState<MyApp> {
  var _splashScreenSeen = false;
  var _stepsNum = _firstCategoryScreenNum;
  var _showActionsScreen = false;
  var _showConsequencesScreen = false;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    delay(const Duration(seconds: 4), () {
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
          inactiveTrackColor: Colors.grey[50],
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
      home: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InitState()),
            ChangeNotifierProvider(create: (_) => CriteriasState()),
          ],
          child: Consumer<InitState>(
            builder: (_, initState, __) => initState.countrySelected == null
                ? Container()
                : WillPopScope(
                    onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
                    child: Navigator(
                      key: _navigatorKey,
                      pages: [
                        if (!_splashScreenSeen)
                          const MaterialPage<SplashScreen>(
                            child: SplashScreen(),
                          ),
                        if (_splashScreenSeen && !initState.countrySelected && _stepsNum == _firstCategoryScreenNum)
                          MaterialPage<OnboardingScreen>(
                            child: OnboardingScreen(
                              onOnboardingFinished: () {
                                setState(() {
                                  _stepsNum = 1;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen &&
                            ((!initState.countrySelected && _stepsNum == 1) || (initState.countrySelected && _stepsNum >= 1)))
                          MaterialPage<CountryScreen>(
                            child: CountryScreen(
                              onCountrySelected: () {
                                initState.countrySelected = true;
                                setState(() {
                                  _stepsNum++;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && initState.countrySelected && _stepsNum >= _firstCategoryScreenNum)
                          MaterialPage<HomeCategoryScreen>(
                            child: HomeCategoryScreen(
                              onContinueTapped: () {
                                setState(() {
                                  _stepsNum++;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && initState.countrySelected && _stepsNum >= _firstCategoryScreenNum + 1)
                          MaterialPage<TravelCategoryScreen>(
                            child: TravelCategoryScreen(
                              onContinueTapped: () {
                                setState(() {
                                  _stepsNum++;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && initState.countrySelected && _stepsNum >= _firstCategoryScreenNum + 2)
                          MaterialPage<FoodCategoryScreen>(
                            child: FoodCategoryScreen(
                              onContinueTapped: () {
                                setState(() {
                                  _stepsNum++;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && initState.countrySelected && _stepsNum >= _firstCategoryScreenNum + 3)
                          MaterialPage<GoodsCategoryScreen>(
                            child: GoodsCategoryScreen(
                              onContinueTapped: () {
                                setState(() {
                                  _stepsNum++;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && initState.countrySelected && _stepsNum >= _firstCategoryScreenNum + 4)
                          MaterialPage<ScoreScreen>(
                            child: ScoreScreen(
                              onSeeConsequencesTapped: () {
                                setState(() {
                                  _showConsequencesScreen = true;
                                });
                              },
                              onSeeActionsTapped: () {
                                setState(() {
                                  _showActionsScreen = true;
                                });
                              },
                              onRestartTapped: () {
                                setState(() {
                                  _stepsNum = _firstCategoryScreenNum;
                                });
                              },
                              onSeeAboutTapped: () {
                                setState(() {});
                              },
                            ),
                          ),
                        if (_splashScreenSeen && _showConsequencesScreen)
                          const MaterialPage<ConsequencesScreen>(
                            child: ConsequencesScreen(),
                          ),
                        if (_splashScreenSeen && _showActionsScreen)
                          const MaterialPage<ActionsScreen>(
                            child: ActionsScreen(),
                          ),
                      ],
                      onPopPage: (route, dynamic result) {
                        if (!route.didPop(result)) {
                          return false;
                        }

                        setState(() {
                          if (_showActionsScreen) {
                            _showActionsScreen = false;
                          } else if (_showConsequencesScreen) {
                            _showConsequencesScreen = false;
                          } else {
                            _stepsNum--;
                          }
                        });

                        return true;
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class InitState with ChangeNotifier {
  static const _countrySelectedKey = 'COUNTRY_SELECTED';
  bool _countrySelected;
  bool get countrySelected => _countrySelected;
  set countrySelected(bool newValue) {
    _countrySelected = newValue;
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_countrySelectedKey, _countrySelected);
    });
  }

  InitState() {
    _loadState();
  }

  Future<void> _loadState() async {
    var prefs = await SharedPreferences.getInstance();
    _countrySelected = prefs.getBool(_countrySelectedKey) ?? false;

    notifyListeners();
  }
}
