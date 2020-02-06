import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'common/criterias.dart';
import 'criterias_screen/criterias_page.dart';
import 'generated/i18n.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp(
        title: 'Warmd',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey[900],
          sliderTheme: SliderTheme.of(context).copyWith(
            valueIndicatorTextStyle: TextStyle(color: Colors.white),
          ),
        ),
        home: Home(),
        localizationsDelegates: [S.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CriteriasState(context),
      child: CriteriasPage(),
    );
  }
}
