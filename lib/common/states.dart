import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/locale_keys.g.dart';
import 'criterias.dart';

class CriteriasState with ChangeNotifier {
  List<CriteriaCategory> _categories;
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

  String getFormatedFootprint() => LocaleKeys.co2EqTonsValue.tr(args: [co2EqTonsPerYear().toStringAsFixed(1)]);

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
  static const _scoresKey = 'SCORES_KEY';
  Map<DateTime, double> _scores;
  Map<DateTime, double> get scores => _scores != null ? Map.unmodifiable(_scores) : null;

  void addScore(DateTime date, double score) {
    _scores[date] = score;

    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_scoresKey, json.encode(_scores));
    });
  }

  HistoryState() {
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    _scores = prefs.containsKey(_scoresKey) ? json.decode(prefs.getString(_scoresKey)) as Map<DateTime, double> : {};

    notifyListeners();
  }
}
