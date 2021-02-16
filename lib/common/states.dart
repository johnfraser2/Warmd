import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'criterias.dart';

part 'states.freezed.dart';

@freezed
abstract class NavState with _$NavState {
  factory NavState({
    @Default(false) bool splashScreenSeen,
    @Default(0) int onboardingStepsNum,
    @Default(false) bool showAdvicesScreen,
    @Default(false) bool showClimateChangeScreen,
    @Default(false) bool showClimateChangeScreenFromActions,
    @Default(false) bool showAboutScreen,
    @Default(0) int questionnaireStepsNum,
  }) = _NavState;
}

class CriteriasState with ChangeNotifier {
  late List<CriteriaCategory> _categories;
  List<CriteriaCategory> get categories => _categories;

  CriteriasState() {
    final generalCategory = GeneralCategory();
    final countryCriteria = generalCategory.criterias[0] as CountryCriteria;
    final utilitiesCategory = UtilitiesCategory(countryCriteria);

    _categories = [
      generalCategory,
      utilitiesCategory,
      TravelCategory(countryCriteria),
      FoodCategory(),
      GoodsCategory(countryCriteria)
    ];

    _loadState();
  }

  double co2EqTonsPerYear() => _categories.map((cat) => cat.co2EqTonsPerYear()).reduce((a, b) => a + b);

  void persist(Criteria c) {
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble(c.key, c.currentValue);
    });
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();

    for (final cat in _categories) {
      for (final crit in cat.criterias) {
        crit.currentValue = prefs.getDouble(crit.key) ?? crit.currentValue;

        if (crit.currentValue > crit.maxValue) {
          crit.currentValue = crit.maxValue;
        } else if (crit.currentValue < crit.minValue) {
          crit.currentValue = crit.minValue;
        }
      }
    }

    notifyListeners();
  }
}

class HistoryState with ChangeNotifier {
  static const _improvementPercentKey = 'IMPROVEMENT_PERCENT_KEY';
  int _improvementPercent = 6;
  int get improvementPercent => _improvementPercent;
  set improvementPercent(int newValue) {
    _improvementPercent = newValue;

    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_improvementPercentKey, _improvementPercent);
    });
  }

  static const _scoresKey = 'SCORES_KEY';
  Map<String, double>? _scores;
  Map<DateTime, double>? get scores =>
      _scores?.map((key, value) => MapEntry(DateTime.fromMillisecondsSinceEpoch(int.parse(key)), value));

  void addScore(DateTime date, double score) {
    _scores?[date.millisecondsSinceEpoch.toString()] = score;

    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_scoresKey, json.encode(_scores));
    });
  }

  void resetHistory() {
    final lastScore = _scores?.entries.last;
    _scores?.clear();
    if (lastScore != null) {
      _scores?[lastScore.key] = lastScore.value;
    }

    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_scoresKey, json.encode(_scores));
    });
  }

  static const _isReminderEnabledKey = 'IS_REMINDER_ENABLED_KEY';
  bool _isReminderEnabled = Platform.isAndroid; // Enable this feature by default for Android only (no runtime permission)
  bool get isReminderEnable => _isReminderEnabled;
  set isReminderEnable(bool newValue) {
    _isReminderEnabled = newValue;

    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_isReminderEnabledKey, _isReminderEnabled);
    });
  }

  HistoryState() {
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    _scores = prefs.containsKey(_scoresKey)
        ? (json.decode(prefs.getString(_scoresKey)!) as Map<String, dynamic>)
            .map((key, dynamic value) => MapEntry(key, value as double))
        : {};

    if (prefs.containsKey(_improvementPercentKey)) {
      _improvementPercent = prefs.getInt(_improvementPercentKey)!;
    }

    if (prefs.containsKey(_isReminderEnabledKey)) {
      _isReminderEnabled = prefs.getBool(_isReminderEnabledKey)!;
    }

    notifyListeners();
  }
}
