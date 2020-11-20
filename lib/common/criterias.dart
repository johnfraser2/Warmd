import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmd/generated/locale_keys.g.dart';

import 'currencies.dart';

abstract class Criteria {
  String key;
  String title;
  String explanation;
  double minValue;
  double maxValue;
  String unit;
  double step;
  double currentValue;
  List<String> labels;

  double co2EqTonsPerYear();
  String advice();

  String getFormatedFootprint() => LocaleKeys.co2EqTonsValue.tr(args: [co2EqTonsPerYear().toStringAsFixed(1)]);
}

abstract class CriteriaCategory {
  String key;
  String title;
  List<Criteria> criterias;

  double co2EqTonsPerYear() => criterias.map((crit) => crit.co2EqTonsPerYear()).reduce((a, b) => a + b);
}

enum UnitSystem { metric, us, uk }

class CountryCriteria extends Criteria {
  CountryCriteria() {
    key = 'country';
    minValue = 0;
    maxValue = countries.length.toDouble() - 1;
    step = 1;
    currentValue = _getCurrentCountryPos().toDouble();
  }

  @override
  List<String> get labels => countries.map((c) => c['name']).toList();

  @override
  double co2EqTonsPerYear() => 0;

  @override
  String advice() => null;

  double getCurrencyRate() {
    return 1 / currencyRates[countries[currentValue.toInt()]['currency']];
  }

  String getCurrencyCode() {
    return countries[currentValue.toInt()]['currency'];
  }

  UnitSystem unitSystem() {
    final countryCode = countries[currentValue.toInt()]['code'];
    if (countryCode == 'US') {
      return UnitSystem.us;
    } else if (countryCode == 'GB') {
      return UnitSystem.uk;
    }

    return UnitSystem.metric;
  }

  int _getCurrentCountryPos() {
    final locales = WidgetsBinding.instance.window.locales;
    if (locales != null && locales.isNotEmpty) {
      final locale = locales.first;
      final idx = countries.indexWhere((c) => c['code'] == (locale.countryCode ?? locale.languageCode.toUpperCase()));
      if (idx != -1) {
        return idx;
      }
    }

    // US by default if not found
    return 234;
  }
}

class GeneralCategory extends CriteriaCategory {
  GeneralCategory() {
    key = 'general';
    criterias = [CountryCriteria()];
  }
}

class HeatingFuelCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  HeatingFuelCriteria(this._countryCriteria) {
    key = 'heating_fuel';
    minValue = 0;
    step = 100;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.heatingFuelCriteriaTitle.tr();

  @override
  String get explanation => LocaleKeys.heatingFuelCriteriaExplanation.tr(args: [_countryCriteria.getCurrencyCode()]);

  @override
  double get maxValue => (((5000 / _countryCriteria.getCurrencyRate()) / step).truncate() * step).toDouble();

  @override
  double get currentValue => min(maxValue, super.currentValue);

  @override
  String get unit => _countryCriteria.getCurrencyCode();

  @override
  double co2EqTonsPerYear() {
    final moneyChange = _countryCriteria.getCurrencyRate();

    final fuelBill = currentValue * moneyChange;
    const co2TonsPerFuelDollar = 0.005;

    return fuelBill * co2TonsPerFuelDollar;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 2) {
      return LocaleKeys.heatingFuelCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class ElectricityBillCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  ElectricityBillCriteria(this._countryCriteria) {
    key = 'electricity_bill';
    minValue = 0;
    step = 100;
    currentValue = 1000;
  }

  @override
  String get title => LocaleKeys.electricityBillCriteriaTitle.tr();

  @override
  String get explanation => LocaleKeys.electricityBillCriteriaExplanation.tr(args: [_countryCriteria.getCurrencyCode()]);

  @override
  double get maxValue => (((5000 / _countryCriteria.getCurrencyRate()) / step).truncate() * step).toDouble();

  @override
  double get currentValue => min(maxValue, super.currentValue);

  @override
  String get unit => _countryCriteria.getCurrencyCode();

  @override
  double co2EqTonsPerYear() => 0;

  @override
  String advice() => null;
}

class CleanElectricityCriteria extends Criteria {
  final CountryCriteria _countryCriteria;
  final ElectricityBillCriteria _electricityBillCriteria;

  CleanElectricityCriteria(this._countryCriteria, this._electricityBillCriteria) {
    key = 'clean_electricity';
    minValue = 0;
    maxValue = 100;
    step = 5;
    currentValue = 10;
    unit = '%';
  }

  @override
  String get title => LocaleKeys.cleanElectricityCriteriaTitle.tr();

  @override
  String get explanation => LocaleKeys.cleanElectricityCriteriaExplanation.tr();

  @override
  double co2EqTonsPerYear() {
    final moneyChange = _countryCriteria.getCurrencyRate();

    final electricityBill = _electricityBillCriteria.currentValue * moneyChange;
    final co2ElectricityPercent = min(100, 100 - currentValue + 15); // +15% because nothing is 100% clean
    const kWhPrice = 0.15; // in dollars
    const co2TonsPerKWh = 0.00065;

    return (electricityBill / 100 * co2ElectricityPercent) / kWhPrice * co2TonsPerKWh;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 0.5) {
      return LocaleKeys.cleanElectricityCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class UtilitiesCategory extends CriteriaCategory {
  UtilitiesCategory(CountryCriteria countryCriteria) {
    key = 'utilities';

    final electricityBillCriteria = ElectricityBillCriteria(countryCriteria);
    criterias = [
      HeatingFuelCriteria(countryCriteria),
      electricityBillCriteria,
      CleanElectricityCriteria(countryCriteria, electricityBillCriteria),
    ];
  }

  @override
  String get title => LocaleKeys.utilitiesCategoryTitle.tr();
}

class FlightsCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  FlightsCriteria(this._countryCriteria) {
    key = 'flights';
    minValue = 0;
    maxValue = 100000;
    step = 5000;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.flightsCriteriaTitle.tr();

  @override
  String get unit => _countryCriteria.unitSystem() == UnitSystem.metric ? 'km' : 'miles';

  @override
  double co2EqTonsPerYear() {
    const co2TonsPerKm = 0.00028;
    final milesToKmFactor = _countryCriteria.unitSystem() == UnitSystem.metric ? 1 : 1.61;
    return currentValue * milesToKmFactor * co2TonsPerKm;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 1) {
      return LocaleKeys.flightsCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class CarCriteria extends Criteria {
  final CarConsumptionCriteria _carConsumptionCriteria;
  final CountryCriteria _countryCriteria;

  CarCriteria(this._carConsumptionCriteria, this._countryCriteria) {
    key = 'car';
    minValue = 0;
    maxValue = 100000;
    step = 5000;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.carCriteriaTitle.tr();

  @override
  String get unit => _countryCriteria.unitSystem() == UnitSystem.metric ? 'km' : 'miles';

  @override
  double co2EqTonsPerYear() {
    // We use -value for US/UK mpg because they are negative values (to have min < max)
    final litersPerKm = (_countryCriteria.unitSystem() == UnitSystem.metric
            ? _carConsumptionCriteria.currentValue
            : _countryCriteria.unitSystem() == UnitSystem.us
                ? 235.2 / -_carConsumptionCriteria.currentValue
                : 282.5 / -_carConsumptionCriteria.currentValue) /
        100;
    final milesToKmFactor = _countryCriteria.unitSystem() == UnitSystem.metric ? 1 : 1.61;
    const co2TonsPerLiter = 0.0033;
    return currentValue * milesToKmFactor * litersPerKm * co2TonsPerLiter;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 1.5) {
      return LocaleKeys.carCriteriaAdviceHigh.tr();
    } else if (co2EqTonsPerYear() > 0.5) {
      return LocaleKeys.carCriteriaAdviceLow.tr();
    } else {
      return null;
    }
  }
}

class CarConsumptionCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  CarConsumptionCriteria(this._countryCriteria) {
    key = 'car_consumption';
    minValue = 2;
    maxValue = 20;
    step = 1;
    currentValue = 8;
  }

  @override
  String get title => LocaleKeys.carConsumptionCriteriaTitle.tr();

  @override
  double get minValue =>
      _countryCriteria.unitSystem() == UnitSystem.metric ? 2 : -141; // Minus to have a correct ordering (min < max)

  @override
  double get maxValue =>
      _countryCriteria.unitSystem() == UnitSystem.metric ? 15 : -15; // Minus to have a correct ordering (min < max)

  @override
  double get currentValue => min(maxValue, max(minValue, super.currentValue));

  @override
  String get unit => _countryCriteria.unitSystem() == UnitSystem.metric ? 'L/100km' : 'mpg';

  @override
  double co2EqTonsPerYear() => 0;

  @override
  String advice() => null;
}

class PublicTransportCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  PublicTransportCriteria(this._countryCriteria) {
    key = 'public_transport';
    minValue = 0;
    maxValue = 100000;
    step = 5000;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.publicTransportCriteriaTitle.tr();

  @override
  String get unit => _countryCriteria.unitSystem() == UnitSystem.metric ? 'km' : 'miles';

  @override
  double co2EqTonsPerYear() {
    const co2TonsPerKm = 0.00014;
    final milesToKmFactor = _countryCriteria.unitSystem() == UnitSystem.metric ? 1 : 1.61;
    return currentValue * milesToKmFactor * co2TonsPerKm;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 2) {
      return LocaleKeys.publicTransportCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class TravelCategory extends CriteriaCategory {
  TravelCategory(CountryCriteria countryCriteria) {
    key = 'travel';

    final carConsumptionCriteria = CarConsumptionCriteria(countryCriteria);
    criterias = [
      FlightsCriteria(countryCriteria),
      CarCriteria(carConsumptionCriteria, countryCriteria),
      carConsumptionCriteria,
      PublicTransportCriteria(countryCriteria)
    ];
  }

  @override
  String get title => LocaleKeys.travelCategoryTitle.tr();
}

class RuminantMeatCriteria extends Criteria {
  RuminantMeatCriteria() {
    key = 'ruminant_meat';
    minValue = 0;
    maxValue = 20;
    step = 1;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.ruminantMeatCriteriaTitle.tr();

  @override
  double co2EqTonsPerYear() {
    // Not CoolClimate results here, more like a mean from beek and lamb. I took 40kg CO2e per kg (a meal = 150g).
    // formula = ( (x/10*1.5) * (365/7) ) / 1000
    // See https://ourworldindata.org/food-choice-vs-eating-local
    const co2TonsPerTimePerWeek = 0.31;
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 1) {
      return LocaleKeys.ruminantMeatCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class NonRuminantMeatCriteria extends Criteria {
  NonRuminantMeatCriteria() {
    key = 'non_ruminant_meat';
    minValue = 0;
    maxValue = 20;
    step = 1;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.nonRuminantMeatCriteriaTitle.tr();

  @override
  double co2EqTonsPerYear() {
    // Not CoolClimate results here, more like a mean from pork and fish. I took 6kg CO2e per kg (a meal = 150g).
    // formula = ( (x/10*1.5) * (365/7) ) / 1000
    // See https://ourworldindata.org/food-choice-vs-eating-local
    const co2TonsPerTimePerWeek = 0.046;
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 0.5) {
      return LocaleKeys.nonRuminantMeatCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class CheeseCriteria extends Criteria {
  CheeseCriteria() {
    key = 'cheese';
    minValue = 0;
    maxValue = 20;
    step = 1;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.cheeseCriteriaTitle.tr();

  @override
  double co2EqTonsPerYear() {
    // Not CoolClimate results here, more like a mean from pork and fish. I took 20kg CO2e per kg (a portion = 50g).
    // formula = ( (x/10*0.5) * (365/7) ) / 1000
    // See https://ourworldindata.org/food-choice-vs-eating-local
    const co2TonsPerTimePerWeek = 0.05;
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 0.5) {
      return LocaleKeys.cheeseCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class SnackCriteria extends Criteria {
  SnackCriteria() {
    key = 'snack';
    minValue = 0;
    maxValue = 20;
    step = 1;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.snacksCriteriaTitle.tr();

  @override
  double co2EqTonsPerYear() {
    const co2TonsPerTimePerWeek = 0.071;
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 0.5) {
      return LocaleKeys.snacksCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class OverweightCriteria extends Criteria {
  final RuminantMeatCriteria _ruminantMeatCriteria;
  final NonRuminantMeatCriteria _nonRuminantMeatCriteria;
  final CheeseCriteria _dairyCriteria;
  final SnackCriteria _snackCriteria;

  OverweightCriteria(this._ruminantMeatCriteria, this._nonRuminantMeatCriteria, this._dairyCriteria, this._snackCriteria) {
    key = 'overweight';
    minValue = 0;
    maxValue = 2;
    step = 1;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.overweightCriteriaTitle.tr();

  @override
  List<String> get labels => [
        LocaleKeys.overweightCriteriaLabel1.tr(),
        LocaleKeys.overweightCriteriaLabel2.tr(),
        LocaleKeys.overweightCriteriaLabel3.tr(),
      ];

  @override
  double co2EqTonsPerYear() {
    final overweightFactor = currentValue == 2 ? 0.5 : (currentValue == 1 ? 0.25 : 0);

    return (_ruminantMeatCriteria.co2EqTonsPerYear() +
            _nonRuminantMeatCriteria.co2EqTonsPerYear() +
            _dairyCriteria.co2EqTonsPerYear() +
            _snackCriteria.co2EqTonsPerYear()) *
        overweightFactor;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 0.5) {
      return LocaleKeys.overweightCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class FoodCategory extends CriteriaCategory {
  FoodCategory() {
    key = 'food';

    final ruminantMeatCriteria = RuminantMeatCriteria();
    final nonRuminantMeatCriteria = NonRuminantMeatCriteria();
    final dairyCriteria = CheeseCriteria();
    final snackCriteria = SnackCriteria();

    criterias = [
      ruminantMeatCriteria,
      nonRuminantMeatCriteria,
      dairyCriteria,
      snackCriteria,
      OverweightCriteria(ruminantMeatCriteria, nonRuminantMeatCriteria, dairyCriteria, snackCriteria),
    ];
  }

  @override
  String get title => LocaleKeys.foodCategoryTitle.tr();

  @override
  double co2EqTonsPerYear() {
    // I add 2 tons to everyone since we all eat vegetables, fruits, ... which I do not ask for quantity.
    // Of course it is not precise.
    return super.co2EqTonsPerYear() + 2;
  }
}

class MaterialGoodsCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  MaterialGoodsCriteria(this._countryCriteria) {
    key = 'material_goods';
    minValue = 0;
    step = 100;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.materialGoodsCriteriaTitle.tr();

  @override
  String get explanation => LocaleKeys.materialGoodsCriteriaExplanation.tr();

  @override
  double get maxValue => (((3000 / _countryCriteria.getCurrencyRate()) / step).truncate() * step).toDouble();

  @override
  double get currentValue => min(maxValue, super.currentValue);

  @override
  String get unit => _countryCriteria.getCurrencyCode();

  @override
  double co2EqTonsPerYear() {
    final moneyChange = _countryCriteria.getCurrencyRate();
    const co2TonsPerDollar = 0.0062;
    return currentValue * moneyChange * co2TonsPerDollar;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 1) {
      return LocaleKeys.materialGoodsCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class SavingsCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  SavingsCriteria(this._countryCriteria) {
    key = 'savings';
    minValue = 0;
    step = 1000;
    currentValue = 0;
  }

  @override
  String get title => LocaleKeys.savingsCriteriaTitle.tr();

  @override
  String get explanation => LocaleKeys.savingsCriteriaExplanation.tr();

  @override
  double get maxValue => (((100000 / _countryCriteria.getCurrencyRate()) / step).truncate() * step).toDouble();

  @override
  double get currentValue => min(maxValue, super.currentValue);

  @override
  String get unit => _countryCriteria.getCurrencyCode();

  @override
  double co2EqTonsPerYear() {
    final moneyChange = _countryCriteria.getCurrencyRate();

    // Based on Rift app's results, but reduced a lot because it is quite unsure due to lack of transparency
    // and it greatly depends on bank/type of account/country, so I prefer to be safe here.
    const co2TonsPerDollar = 0.00025;
    return currentValue * moneyChange * co2TonsPerDollar;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 1) {
      return LocaleKeys.savingsCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class WaterCriteria extends Criteria {
  WaterCriteria() {
    key = 'water';
    minValue = 0;
    maxValue = 2;
    step = 1;
    currentValue = 1;
  }

  @override
  String get title => LocaleKeys.waterCriteriaTitle.tr();

  @override
  String get explanation => LocaleKeys.waterCriteriaExplanation.tr();

  @override
  List<String> get labels => [
        LocaleKeys.waterCriteriaLabel1.tr(),
        LocaleKeys.waterCriteriaLabel2.tr(),
        LocaleKeys.waterCriteriaLabel3.tr(),
      ];

  @override
  double co2EqTonsPerYear() {
    return 1.56 * ((currentValue + 1) / 2);
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 1) {
      return LocaleKeys.waterCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class InternetCriteria extends Criteria {
  InternetCriteria() {
    key = 'internet';
    minValue = 0;
    maxValue = 2;
    step = 1;
    currentValue = 1;
  }

  @override
  String get title => LocaleKeys.internetCriteriaTitle.tr();

  @override
  List<String> get labels => [
        LocaleKeys.internetCriteriaLabel1.tr(),
        LocaleKeys.internetCriteriaLabel2.tr(),
        LocaleKeys.internetCriteriaLabel3.tr(),
      ];

  @override
  double co2EqTonsPerYear() => 0.1 + currentValue * 0.25; // Based on Carbonalyser extension's results

  @override
  String advice() {
    if (co2EqTonsPerYear() > 0.5) {
      return LocaleKeys.internetCriteriaAdvice.tr();
    } else {
      return null;
    }
  }
}

class GoodsCategory extends CriteriaCategory {
  GoodsCategory(CountryCriteria countryCriteria) {
    key = 'goods';
    criterias = [
      MaterialGoodsCriteria(countryCriteria),
      SavingsCriteria(countryCriteria),
      WaterCriteria(),
      InternetCriteria(),
    ];
  }

  @override
  String get title => LocaleKeys.goodsAndServicesCategoryTitle.tr();
}

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
