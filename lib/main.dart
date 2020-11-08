import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/common.dart';
import 'common/criterias.dart';
import 'common/delayable_state.dart';
import 'criterias_screen/criterias_screen.dart';
import 'generated/codegen_loader.g.dart';
import 'onboarding/country_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'score_screen/score_screen.dart';
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

class _MyAppState extends DelayableState<MyApp> {
  var _splashScreenSeen = false;
  var _showCountrySelectionScreen = false;
  var _showScoreScreen = false;
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
          //TODO check how to use Valeda font
          valueIndicatorTextStyle: const TextStyle(color: Colors.white),
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
            //TODO check how to use Valeda font
            textStyle: MaterialStateProperty.all<TextStyle>(Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white, // Does not work, don't know why
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
                        if (_splashScreenSeen && !initState.countrySelected && !_showCountrySelectionScreen)
                          MaterialPage<OnboardingScreen>(
                            child: OnboardingScreen(
                              onOnboardingFinished: () {
                                setState(() {
                                  _showCountrySelectionScreen = true;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && _showCountrySelectionScreen)
                          MaterialPage<CountryScreen>(
                            child: CountryScreen(
                              onCountrySelected: () {
                                initState.countrySelected = true;
                                setState(() {
                                  _showCountrySelectionScreen = false;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && !_showCountrySelectionScreen && initState.countrySelected)
                          MaterialPage<CriteriasScreen>(
                            child: CriteriasScreen(
                              onSeeScoreTapped: () {
                                setState(() {
                                  _showScoreScreen = true;
                                });
                              },
                            ),
                          ),
                        if (_splashScreenSeen && _showScoreScreen)
                          MaterialPage<ScoreScreen>(
                            child: ScoreScreen(
                              onSeeConsequencesTapped: () {
                                setState(() {});
                              },
                              onSeeActionsTapped: () {
                                setState(() {});
                              },
                              onRestartTapped: () {
                                setState(() {
                                  _showScoreScreen = false;
                                });
                              },
                              onSeeAboutTapped: () {
                                setState(() {});
                              },
                            ),
                          ),
                      ],
                      onPopPage: (route, dynamic result) {
                        if (!route.didPop(result)) {
                          return false;
                        }

                        setState(() {
                          if (_showScoreScreen) {
                            _showCountrySelectionScreen = false;
                            _showScoreScreen = false;
                          } else {
                            _showCountrySelectionScreen = true;
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
