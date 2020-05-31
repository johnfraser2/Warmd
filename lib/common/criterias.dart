import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/i18n.dart';
import 'currencies.dart';
import 'warmd_icons_icons.dart';

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
  IconData leftIcon;
  IconData rightIcon;

  double co2EqTonsPerYear();
  String advice();
}

abstract class CriteriaCategory {
  String key;
  String title;
  List<Criteria> criterias;

  double co2EqTonsPerYear() => criterias.map((crit) => crit.co2EqTonsPerYear()).reduce((a, b) => a + b);
}

class MoneyChangeCriteria extends Criteria {
  final BuildContext _context;

  MoneyChangeCriteria(this._context) {
    key = 'money_change';
    minValue = 0;
    maxValue = currencies.length.toDouble() - 1;
    step = 1;
    currentValue = 145; // USD
  }

  @override
  String get title => S.of(_context).moneyChangeCriteriaTitle;

  @override
  List<String> get labels => Localizations.localeOf(_context).languageCode == 'fr'
      ? currencies.entries.map((entry) => entry.key + ' - ' + entry.value['fr'].toString()).toList()
      : currencies.entries.map((entry) => entry.key + ' - ' + entry.value['en'].toString()).toList();

  @override
  double co2EqTonsPerYear() => 0;

  @override
  String advice() => null;

  double getCurrencyRate() {
    return 1 / (currencies.entries.elementAt(currentValue.toInt()).value['value'] as double);
  }

  String getCurrencyCode() {
    return currencies.keys.elementAt(currentValue.toInt());
  }
}

class UnitCriteria extends Criteria {
  final BuildContext _context;

  UnitCriteria(this._context) {
    key = 'unit';
    minValue = 0;
    maxValue = 2;
    step = 1;
    currentValue = 0;
  }

  @override
  String get title => S.of(_context).unitCriteriaTitle;

  @override
  List<String> get labels => [
        S.of(_context).unitCriteriaLabel1,
        S.of(_context).unitCriteriaLabel2,
        S.of(_context).unitCriteriaLabel3,
      ];

  @override
  double co2EqTonsPerYear() => 0;

  @override
  String advice() => null;
}

class GeneralCategory extends CriteriaCategory {
  final BuildContext _context;

  GeneralCategory(this._context) {
    key = 'general';
    criterias = [UnitCriteria(_context), MoneyChangeCriteria(_context)];
  }

  @override
  String get title => S.of(_context).generalCategoryTitle;
}

class PeopleCriteria extends Criteria {
  final BuildContext _context;

  PeopleCriteria(this._context) {
    key = 'people';
    minValue = 1;
    maxValue = 3;
    step = 1;
    currentValue = 1;
    leftIcon = Icons.person;
    rightIcon = WarmdIcons.account_group;
  }

  @override
  String get title => S.of(_context).peopleCriteriaTitle;

  @override
  String get explanation => S.of(_context).peopleCriteriaExplanation;

  @override
  double co2EqTonsPerYear() => 0;

  @override
  String advice() => null;
}

class HeatingFuelCriteria extends Criteria {
  final BuildContext _context;
  final PeopleCriteria _peopleCriteria;
  final MoneyChangeCriteria _moneyChangeCriteria;

  HeatingFuelCriteria(this._context, this._peopleCriteria, this._moneyChangeCriteria) {
    key = 'heating_fuel';
    minValue = 0;
    step = 100;
    currentValue = 0;
    leftIcon = WarmdIcons.piggy_bank;
    rightIcon = WarmdIcons.radiator;
  }

  @override
  String get title => S.of(_context).heatingFuelCriteriaTitle;

  @override
  String get explanation => S.of(_context).heatingFuelCriteriaExplanation(_moneyChangeCriteria.getCurrencyCode());

  @override
  double get maxValue => (((5000 / _moneyChangeCriteria.getCurrencyRate()) / step).truncate() * step).toDouble();

  @override
  double get currentValue => min(maxValue, super.currentValue);

  @override
  String get unit => _moneyChangeCriteria.getCurrencyCode();

  @override
  double co2EqTonsPerYear() {
    var peopleNumber = _peopleCriteria.currentValue;
    var peopleFactor = peopleNumber > 1 ? peopleNumber / 1.3 : 1;

    var moneyChange = _moneyChangeCriteria.getCurrencyRate();

    var fuelBill = currentValue * moneyChange;
    var co2TonsPerFuelDollar = 0.005;

    return (fuelBill * co2TonsPerFuelDollar) / peopleFactor;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 3) {
      return S.of(_context).heatingFuelCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class ElectricityBillCriteria extends Criteria {
  final BuildContext _context;
  final PeopleCriteria _peopleCriteria;
  final MoneyChangeCriteria _moneyChangeCriteria;
  final CleanElectricityCriteria _cleanElectricityCriteria;

  ElectricityBillCriteria(this._context, this._peopleCriteria, this._moneyChangeCriteria, this._cleanElectricityCriteria) {
    key = 'electricity_bill';
    minValue = 0;
    step = 100;
    currentValue = 1000;
    leftIcon = WarmdIcons.coin_outline;
    rightIcon = WarmdIcons.cash_multiple;
  }

  @override
  String get title => S.of(_context).electricityBillCriteriaTitle;

  @override
  String get explanation => S.of(_context).electricityBillCriteriaExplanation(_moneyChangeCriteria.getCurrencyCode());

  @override
  double get maxValue => (((5000 / _moneyChangeCriteria.getCurrencyRate()) / step).truncate() * step).toDouble();

  @override
  double get currentValue => min(maxValue, super.currentValue);

  @override
  String get unit => _moneyChangeCriteria.getCurrencyCode();

  @override
  double co2EqTonsPerYear() {
    var peopleNumber = _peopleCriteria.currentValue;
    var peopleFactor = peopleNumber > 1 ? peopleNumber / 1.3 : 1;

    var moneyChange = _moneyChangeCriteria.getCurrencyRate();

    var electricityBill = currentValue * moneyChange;
    var co2ElectricityPercent = min(100, 100 - _cleanElectricityCriteria.currentValue + 15); // +15% because nothing is 100% clean
    var kWhPrice = 0.15; // in dollars
    var co2TonsPerKWh = 0.00065;

    return ((electricityBill / 100 * co2ElectricityPercent) / kWhPrice * co2TonsPerKWh) / peopleFactor;
  }

  @override
  String advice() => null;
}

class CleanElectricityCriteria extends Criteria {
  final BuildContext _context;

  CleanElectricityCriteria(this._context) {
    key = 'clean_electricity';
    minValue = 0;
    maxValue = 100;
    step = 5;
    currentValue = 10;
    unit = '%';
    leftIcon = WarmdIcons.fuel;
    rightIcon = WarmdIcons.wind_turbine;
  }

  @override
  String get title => S.of(_context).cleanElectricityCriteriaTitle;

  @override
  String get explanation => S.of(_context).cleanElectricityCriteriaExplanation;

  @override
  double co2EqTonsPerYear() => 0;

  @override
  String advice() {
    if (currentValue < 80) {
      return S.of(_context).cleanElectricityCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class WaterCriteria extends Criteria {
  final BuildContext _context;

  WaterCriteria(this._context) {
    key = 'water';
    minValue = 0;
    maxValue = 2;
    step = 1;
    currentValue = 1;
  }

  @override
  String get title => S.of(_context).waterCriteriaTitle;

  @override
  String get explanation => S.of(_context).waterCriteriaExplanation;

  @override
  List<String> get labels => [
        S.of(_context).waterCriteriaLabel1,
        S.of(_context).waterCriteriaLabel2,
        S.of(_context).waterCriteriaLabel3,
      ];

  @override
  double co2EqTonsPerYear() {
    return 1.56 * ((currentValue + 1) / 2);
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 1) {
      return S.of(_context).waterCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class HomeCategory extends CriteriaCategory {
  final BuildContext _context;

  HomeCategory(this._context, MoneyChangeCriteria moneyChangeCriteria) {
    key = 'home';

    var peopleCriteria = PeopleCriteria(_context);
    var cleanElectricityCriteria = CleanElectricityCriteria(_context);
    criterias = [
      peopleCriteria,
      HeatingFuelCriteria(_context, peopleCriteria, moneyChangeCriteria),
      ElectricityBillCriteria(_context, peopleCriteria, moneyChangeCriteria, cleanElectricityCriteria),
      cleanElectricityCriteria,
      WaterCriteria(_context),
    ];
  }

  @override
  String get title => S.of(_context).homeCategoryTitle;
}

class FlightsCriteria extends Criteria {
  final BuildContext _context;
  final UnitCriteria _unitCriteria;

  FlightsCriteria(this._context, this._unitCriteria) {
    key = 'flights';
    minValue = 0;
    maxValue = 100000;
    step = 5000;
    currentValue = 0;
    leftIcon = Icons.airplanemode_inactive;
    rightIcon = Icons.airplanemode_active;
  }

  @override
  String get title => S.of(_context).flightsCriteriaTitle;

  @override
  String get explanation => S.of(_context).flightsCriteriaExplanation;

  @override
  String get unit => _unitCriteria.currentValue == 0 ? 'km' : 'miles';

  @override
  double co2EqTonsPerYear() {
    var co2TonsPerKm = 0.00028;
    var milesToKmFactor = _unitCriteria.currentValue == 0 ? 1 : 1.61;
    return currentValue * milesToKmFactor * co2TonsPerKm;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 1) {
      return S.of(_context).flightsCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class CarCriteria extends Criteria {
  final BuildContext _context;
  final PeopleCriteria _peopleCriteria;
  final CarConsumptionCriteria _carConsumptionCriteria;
  final UnitCriteria _unitCriteria;

  CarCriteria(this._context, this._peopleCriteria, this._carConsumptionCriteria, this._unitCriteria) {
    key = 'car';
    minValue = 0;
    maxValue = 100000;
    step = 5000;
    currentValue = 0;
    leftIcon = Icons.directions_bike;
    rightIcon = WarmdIcons.car_sports;
  }

  @override
  String get title => S.of(_context).carCriteriaTitle;

  @override
  String get explanation => S.of(_context).carCriteriaExplanation;

  @override
  String get unit => _unitCriteria.currentValue == 0 ? 'km' : 'miles';

  @override
  double co2EqTonsPerYear() {
    var peopleNumber = _peopleCriteria.currentValue;
    var peopleFactor = peopleNumber > 1 ? peopleNumber / 1.8 : 1;

    var litersPerKm = (_unitCriteria.currentValue == 0
            ? _carConsumptionCriteria.currentValue
            : _unitCriteria.currentValue == 1
                ? 235.2 / -_carConsumptionCriteria.currentValue
                : 282.5 / -_carConsumptionCriteria.currentValue) /
        100;
    var milesToKmFactor = _unitCriteria.currentValue == 0 ? 1 : 1.61;
    var co2TonsPerLiter = 0.0033;
    return (currentValue / peopleFactor) * milesToKmFactor * litersPerKm * co2TonsPerLiter;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 1.5) {
      return S.of(_context).carCriteriaAdviceHigh;
    } else if (co2EqTonsPerYear() > 0.5) {
      return S.of(_context).carCriteriaAdviceLow;
    } else {
      return null;
    }
  }
}

class CarConsumptionCriteria extends Criteria {
  final BuildContext _context;
  final UnitCriteria _unitCriteria;

  CarConsumptionCriteria(this._context, this._unitCriteria) {
    key = 'car_consumption';
    minValue = 2;
    maxValue = 20;
    step = 1;
    currentValue = 8;
    leftIcon = WarmdIcons.sprout;
    rightIcon = WarmdIcons.gas_station;
  }

  @override
  String get title => S.of(_context).carConsumptionCriteriaTitle;

  @override
  double get minValue => _unitCriteria.currentValue == 0 ? 2 : -140;

  @override
  double get maxValue => _unitCriteria.currentValue == 0 ? 20 : -11;

  @override
  double get currentValue => min(maxValue, max(minValue, super.currentValue));

  @override
  String get unit => _unitCriteria.currentValue == 0 ? 'L/100km' : 'mpg';

  @override
  double co2EqTonsPerYear() => 0;

  @override
  String advice() => null;
}

class PublicTransportCriteria extends Criteria {
  final BuildContext _context;
  final UnitCriteria _unitCriteria;

  PublicTransportCriteria(this._context, this._unitCriteria) {
    key = 'public_transport';
    minValue = 0;
    maxValue = 100000;
    step = 5000;
    currentValue = 0;
    leftIcon = Icons.directions_bike;
    rightIcon = Icons.train;
  }

  @override
  String get title => S.of(_context).publicTransportCriteriaTitle;

  @override
  String get unit => _unitCriteria.currentValue == 0 ? 'km' : 'miles';

  @override
  double co2EqTonsPerYear() {
    var co2TonsPerKm = 0.00014;
    var milesToKmFactor = _unitCriteria.currentValue == 0 ? 1 : 1.61;
    return currentValue * milesToKmFactor * co2TonsPerKm;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 3) {
      return S.of(_context).publicTransportCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class TravelCategory extends CriteriaCategory {
  final BuildContext _context;

  TravelCategory(this._context, PeopleCriteria peopleCriteria, UnitCriteria unitCriteria) {
    key = 'travel';

    var carConsumptionCriteria = CarConsumptionCriteria(_context, unitCriteria);
    criterias = [
      FlightsCriteria(_context, unitCriteria),
      CarCriteria(_context, peopleCriteria, carConsumptionCriteria, unitCriteria),
      carConsumptionCriteria,
      PublicTransportCriteria(_context, unitCriteria)
    ];
  }

  @override
  String get title => S.of(_context).travelCategoryTitle;
}

class MeatCriteria extends Criteria {
  final BuildContext _context;

  MeatCriteria(this._context) {
    key = 'meat';
    minValue = 0;
    maxValue = 20;
    step = 1;
    currentValue = 0;
    leftIcon = WarmdIcons.food_apple_outline;
    rightIcon = WarmdIcons.cow;
  }

  @override
  String get title => S.of(_context).meatCriteriaTitle;

  @override
  String get explanation => S.of(_context).meatCriteriaExplanation;

  @override
  double co2EqTonsPerYear() {
    var co2TonsPerTimePerWeek = 0.18;
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String advice() {
    if (currentValue >= 0.7) {
      return S.of(_context).meatCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class DairyCriteria extends Criteria {
  final BuildContext _context;

  DairyCriteria(this._context) {
    key = 'dairy';
    minValue = 0;
    maxValue = 20;
    step = 1;
    currentValue = 0;
    leftIcon = WarmdIcons.food_apple_outline;
    rightIcon = WarmdIcons.cheese;
  }

  @override
  String get title => S.of(_context).dairyCriteriaTitle;

  @override
  String get explanation => S.of(_context).dairyCriteriaExplanation;

  @override
  double co2EqTonsPerYear() {
    var co2TonsPerTimePerWeek = 0.076;
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String advice() => null; // I can't advice to eat less
}

class SnackCriteria extends Criteria {
  final BuildContext _context;

  SnackCriteria(this._context) {
    key = 'snack';
    minValue = 0;
    maxValue = 20;
    step = 1;
    currentValue = 0;
    leftIcon = WarmdIcons.food_off;
    rightIcon = WarmdIcons.food;
  }

  @override
  String get title => S.of(_context).snacksCriteriaTitle;

  @override
  String get explanation => S.of(_context).snacksCriteriaExplanation;

  @override
  double co2EqTonsPerYear() {
    var co2TonsPerTimePerWeek = 0.071;
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String advice() {
    if (currentValue > 3) {
      return S.of(_context).snacksCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class OverweightCriteria extends Criteria {
  final BuildContext _context;

  OverweightCriteria(this._context) {
    key = 'overweight';
    minValue = 0;
    maxValue = 2;
    step = 1;
    currentValue = 1;
  }

  @override
  String get title => S.of(_context).overweightCriteriaTitle;

  @override
  String get explanation => S.of(_context).overweightCriteriaExplanation;

  @override
  List<String> get labels => [
        S.of(_context).overweightCriteriaLabel1,
        S.of(_context).overweightCriteriaLabel2,
        S.of(_context).overweightCriteriaLabel3,
      ];

  @override
  double co2EqTonsPerYear() => 0;

  @override
  String advice() {
    if (currentValue > 0) {
      return S.of(_context).overweightCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class FoodCategory extends CriteriaCategory {
  final BuildContext _context;

  FoodCategory(this._context) {
    key = 'food';
    criterias = [
      MeatCriteria(_context),
      DairyCriteria(_context),
      SnackCriteria(_context),
      OverweightCriteria(_context),
    ];
  }

  @override
  String get title => S.of(_context).foodCategoryTitle;

  @override
  double co2EqTonsPerYear() {
    var overweightValue = criterias[3].currentValue;
    var overweightFactor = overweightValue == 2 ? 1.5 : (overweightValue == 1 ? 1.25 : 1);

    return (criterias[0].co2EqTonsPerYear() + criterias[1].co2EqTonsPerYear() + criterias[2].co2EqTonsPerYear()) *
        overweightFactor;
  }
}

class MaterialGoodsCriteria extends Criteria {
  final BuildContext _context;
  final MoneyChangeCriteria _moneyChangeCriteria;

  MaterialGoodsCriteria(this._context, this._moneyChangeCriteria) {
    key = 'material_goods';
    minValue = 0;
    step = 100;
    currentValue = 0;
    leftIcon = WarmdIcons.piggy_bank;
    rightIcon = WarmdIcons.cash_multiple;
  }

  @override
  String get title => S.of(_context).materialGoodsCriteriaTitle;

  @override
  String get explanation => S.of(_context).materialGoodsCriteriaExplanation;

  @override
  double get maxValue => (((3000 / _moneyChangeCriteria.getCurrencyRate()) / step).truncate() * step).toDouble();

  @override
  double get currentValue => min(maxValue, super.currentValue);

  @override
  String get unit => _moneyChangeCriteria.getCurrencyCode();

  @override
  double co2EqTonsPerYear() {
    var moneyChange = _moneyChangeCriteria.getCurrencyRate();
    var co2TonsPerDollar = 0.0062;
    return currentValue * moneyChange * co2TonsPerDollar;
  }

  @override
  String advice() {
    if (co2EqTonsPerYear() > 2) {
      return S.of(_context).materialGoodsCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class InternetCriteria extends Criteria {
  final BuildContext _context;

  InternetCriteria(this._context) {
    key = 'internet';
    minValue = 0;
    maxValue = 2;
    step = 1;
    currentValue = 1;
  }

  @override
  String get title => S.of(_context).internetCriteriaTitle;

  @override
  String get explanation => S.of(_context).internetCriteriaExplanation;

  @override
  List<String> get labels => [
        S.of(_context).internetCriteriaLabel1,
        S.of(_context).internetCriteriaLabel2,
        S.of(_context).internetCriteriaLabel3,
      ];

  @override
  double co2EqTonsPerYear() => 0.1 + currentValue * 0.25; // Based on Carbonalyser extension's results

  @override
  String advice() {
    if (co2EqTonsPerYear() > 0.15) {
      return S.of(_context).internetCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class GoodsCategory extends CriteriaCategory {
  final BuildContext _context;

  GoodsCategory(this._context, MoneyChangeCriteria moneyChangeCriteria) {
    key = 'goods';
    criterias = [
      MaterialGoodsCriteria(_context, moneyChangeCriteria),
      InternetCriteria(_context),
    ];
  }

  @override
  String get title => S.of(_context).goodsAndServicesCategoryTitle;
}

class CriteriaCategorySet {
  final BuildContext _context;
  List<CriteriaCategory> categories;

  CriteriaCategorySet(this._context) {
    var generalCategory = GeneralCategory(_context);
    var homeCategory = HomeCategory(_context, generalCategory.criterias[1] as MoneyChangeCriteria);

    categories = [
      generalCategory,
      homeCategory,
      TravelCategory(_context, homeCategory.criterias[0] as PeopleCriteria, generalCategory.criterias[0] as UnitCriteria),
      FoodCategory(_context),
      GoodsCategory(_context, generalCategory.criterias[1] as MoneyChangeCriteria)
    ];
  }

  double co2EqTonsPerYear() => categories.map((cat) => cat.co2EqTonsPerYear()).reduce((a, b) => a + b);

  String getFormatedFootprint() => S.of(_context).co2EqTonsValue(co2EqTonsPerYear().toStringAsFixed(1));
}

class CriteriasState with ChangeNotifier {
  CriteriaCategorySet _categorySet;
  CriteriaCategorySet get categorySet => _categorySet;
  set categorySet(CriteriaCategorySet newValue) {
    _categorySet = newValue;
    _loadFromPersistence().then((_) {
      notifyListeners();
    });
  }

  CriteriasState(BuildContext context) {
    categorySet = CriteriaCategorySet(context);
  }

  void persist(Criteria c) {
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble(c.key, c.currentValue);
    });
  }

  Future<void> _loadFromPersistence() async {
    var prefs = await SharedPreferences.getInstance();

    categorySet.categories.forEach((cat) {
      cat.criterias.forEach((crit) {
        crit.currentValue = prefs.getDouble(crit.key) ?? crit.currentValue;

        if (crit.currentValue > crit.maxValue) {
          crit.currentValue = crit.maxValue;
        } else if (crit.currentValue < crit.minValue) {
          crit.currentValue = crit.minValue;
        }
      });
    });
  }
}
