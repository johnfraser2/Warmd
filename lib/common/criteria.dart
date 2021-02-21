import 'dart:math';

import 'package:flutter/material.dart';

import 'common.dart';
import 'countries.dart';

const _oneMileInKms = 1.61;

abstract class Criteria {
  String key;
  double minValue;
  double maxValue;
  String? unit;
  double step;
  double currentValue;

  Criteria(
      {required this.key,
      required this.minValue,
      required this.maxValue,
      this.unit,
      required this.step,
      required this.currentValue});

  List<String>? labels(BuildContext context) => null;
  double co2EqTonsPerYear() => 0;
  String title(BuildContext context);
  String? explanation(BuildContext context) => null;
  String? advice(BuildContext context) => null;
  Map<String, double>? shortcuts(BuildContext context) => null;
  Map<String, Map<String, String>>? links() => null;
}

abstract class CriteriaCategory {
  String key;

  CriteriaCategory({required this.key});

  String title(BuildContext context);
  List<Criteria> getCriteriaList();
  double co2EqTonsPerYear() => getCriteriaList().map((crit) => crit.co2EqTonsPerYear()).reduce((a, b) => a + b);
}

enum UnitSystem { metric, us, uk }

class CountryCriteria extends Criteria {
  CountryCriteria()
      : super(
            key: 'country',
            minValue: 0,
            maxValue: countries.length.toDouble() - 1,
            step: 1,
            currentValue: _getCurrentCountryPos().toDouble());

  @override
  List<String> labels(BuildContext context) => countries.map((c) => c['name']!).toList();

  double getCurrencyRate() {
    return 1 / currencyRates[countries[currentValue.toInt()]['currency']]!;
  }

  String getCountryCode() {
    return countries[currentValue.toInt()]['code']!;
  }

  String getCurrencyCode() {
    return countries[currentValue.toInt()]['currency']!;
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

  static int _getCurrentCountryPos() {
    final locales = WidgetsBinding.instance?.window.locales;
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

  @override
  String title(BuildContext context) => ''; // This special criteria is never displayed
}

class GeneralCategory extends CriteriaCategory {
  final countryCriteria = CountryCriteria();

  GeneralCategory() : super(key: 'general');

  @override
  String title(BuildContext context) => ''; // This special criteria is never displayed

  @override
  List<Criteria> getCriteriaList() => [countryCriteria];
}

class HeatingFuelCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  HeatingFuelCriteria(this._countryCriteria)
      : super(
            key: 'heating_fuel',
            minValue: 0,
            maxValue: 0, // is overriden below
            step: 10,
            currentValue: 0);

  @override
  String title(BuildContext context) => context.i18n.heatingFuelCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.inUnitPerMonth(_countryCriteria.getCurrencyCode());

  @override
  double get maxValue => (((300 / _countryCriteria.getCurrencyRate()) / step).truncate() * step).toDouble();

  @override
  double get currentValue => super.currentValue > maxValue
      ? min(maxValue, super.currentValue / 12)
      : super.currentValue; // Necessary since I switched from year to month

  @override
  String get unit => _countryCriteria.getCurrencyCode();

  @override
  double co2EqTonsPerYear() {
    final moneyChange = _countryCriteria.getCurrencyRate();

    final fuelBill = currentValue * moneyChange;
    const co2TonsPerFuelDollar = 0.005;

    return fuelBill * co2TonsPerFuelDollar * 12; // x12 for the yearly value
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 2) {
      return context.i18n.heatingFuelCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, double> shortcuts(BuildContext context) {
    return {
      // People who don't know generally rent an apartment with common heating.
      // After few searches, seems the average monthly cost is between 50$ and 80$ for fuel-based heating, let's arbitrary take 70$.
      // Of course it will again depends of the country/city so it's not really precise.
      context.i18n.shortcutUnknown: 70 / _countryCriteria.getCurrencyRate(),
    };
  }
}

class ElectricityBillCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  ElectricityBillCriteria(this._countryCriteria)
      : super(
            key: 'electricity_bill',
            minValue: 0,
            maxValue: 0, // is overriden below
            step: 10,
            currentValue: 100);

  @override
  String title(BuildContext context) => context.i18n.electricityBillCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.inUnitPerMonth(_countryCriteria.getCurrencyCode());

  @override
  double get maxValue => (((500 / _countryCriteria.getCurrencyRate()) / step).truncate() * step).toDouble();

  @override
  double get currentValue => super.currentValue > maxValue
      ? min(maxValue, super.currentValue / 12)
      : super.currentValue; // Necessary since I switched from year to month

  @override
  String get unit => _countryCriteria.getCurrencyCode();
}

class CleanElectricityCriteria extends Criteria {
  final CountryCriteria _countryCriteria;
  final ElectricityBillCriteria _electricityBillCriteria;

  CleanElectricityCriteria(this._countryCriteria, this._electricityBillCriteria)
      : super(
            key: 'clean_electricity',
            minValue: 0, // is overriden below
            maxValue: 100,
            step: 1,
            currentValue: 0, // is changed just below
            unit: '%') {
    currentValue = _meanValue;
  }

  @override
  String title(BuildContext context) => context.i18n.cleanElectricityCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.cleanElectricityCriteriaExplanation;

  @override
  double get minValue {
    switch (_countryCriteria.getCountryCode()) {
      case 'IS':
      case 'NO':
        return 100;
      case 'FR':
      case 'SE':
        return 90;
      default:
        return 0;
    }
  }

  @override
  double get currentValue => min(maxValue, max(minValue, super.currentValue));

  @override
  double co2EqTonsPerYear() {
    final moneyChange = _countryCriteria.getCurrencyRate();

    final electricityBillPerYear = _electricityBillCriteria.currentValue * 12 * moneyChange;
    final co2ElectricityPercent = min(100, 100 - currentValue + 5); // +5% because nothing is 100% clean
    const kWhPrice = 0.15; // in dollars
    const co2TonsPerKWh = 0.00065;

    return (electricityBillPerYear / 100 * co2ElectricityPercent) / kWhPrice * co2TonsPerKWh;
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.cleanElectricityCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, double> shortcuts(BuildContext context) {
    return {context.i18n.shortcutUnknown: _meanValue};
  }

  double get _meanValue => max(15, minValue);
}

class UtilitiesCategory extends CriteriaCategory {
  late HeatingFuelCriteria heatingFuelCriteria;
  late ElectricityBillCriteria electricityBillCriteria;
  late CleanElectricityCriteria cleanElectricityCriteria;

  UtilitiesCategory(CountryCriteria countryCriteria) : super(key: 'utilities') {
    electricityBillCriteria = ElectricityBillCriteria(countryCriteria);
    heatingFuelCriteria = HeatingFuelCriteria(countryCriteria);
    cleanElectricityCriteria = CleanElectricityCriteria(countryCriteria, electricityBillCriteria);
  }

  @override
  String title(BuildContext context) => context.i18n.utilitiesCategoryTitle;

  @override
  List<Criteria> getCriteriaList() => [heatingFuelCriteria, electricityBillCriteria, cleanElectricityCriteria];
}

class FlightsCriteria extends Criteria {
  static const _airlinerKmsPerHour = 800;

  FlightsCriteria()
      : super(
          key: 'flights',
          minValue: 0,
          maxValue: 40,
          step: 1,
          currentValue: 0, // is overriden below
        );

  @override
  String title(BuildContext context) => context.i18n.flightsCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.inUnitPerMonth(unit);

  @override
  String get unit => 'h';

  @override
  double get currentValue => super.currentValue > maxValue
      ? min(maxValue, super.currentValue / 12)
      : super.currentValue; // Necessary since I switched from year to month

  @override
  double co2EqTonsPerYear() {
    const co2TonsPerKm = 0.00016; // Around 0.8t per 5000km if we believe the CoolClimate's advanced air traval results
    return currentValue * _airlinerKmsPerHour * co2TonsPerKm * 12; // x12 for the yearly value
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.flightsCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class CarCriteria extends Criteria {
  final CarConsumptionCriteria _carConsumptionCriteria;
  final CountryCriteria _countryCriteria;

  CarCriteria(this._carConsumptionCriteria, this._countryCriteria)
      : super(
          key: 'car',
          minValue: 0,
          maxValue: 5000,
          step: 50,
          currentValue: 0, // is overriden below
        );

  @override
  String title(BuildContext context) => context.i18n.carCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.inUnitPerMonth(unit);

  @override
  String get unit => _countryCriteria.unitSystem() == UnitSystem.metric ? 'km' : 'miles';

  @override
  double get currentValue => super.currentValue > maxValue
      ? min(maxValue, super.currentValue / 12)
      : super.currentValue; // Necessary since I switched from year to month

  @override
  double co2EqTonsPerYear() {
    // We use -value for US/UK mpg because they are negative values (to have min < max)
    final litersPerKm = (_countryCriteria.unitSystem() == UnitSystem.metric
            ? _carConsumptionCriteria.currentValue
            : _countryCriteria.unitSystem() == UnitSystem.us
                ? 235.2 / -_carConsumptionCriteria.currentValue
                : 282.5 / -_carConsumptionCriteria.currentValue) /
        100;
    final milesToKmFactor = _countryCriteria.unitSystem() == UnitSystem.metric ? 1 : _oneMileInKms;
    const co2TonsPerLiter = 0.0033;
    return currentValue * milesToKmFactor * litersPerKm * co2TonsPerLiter * 12; // x12 for the yearly value
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 1.5) {
      return context.i18n.carCriteriaAdviceHigh;
    } else if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.carCriteriaAdviceLow;
    } else {
      return null;
    }
  }

  @override
  Map<String, double> shortcuts(BuildContext context) {
    final kmToMilesFactor = _countryCriteria.unitSystem() == UnitSystem.metric ? 1.0 : _oneMileInKms;

    // I arbitrary took 50km/h as an average, I didn't find a viable source
    return {
      context.i18n.carCriteriaShortcutOneHourPerDay: (50 * 20) / kmToMilesFactor,
      context.i18n.carCriteriaShortcutTwoHoursPerDay: (50 * 20 * 2) / kmToMilesFactor,
    };
  }
}

class CarConsumptionCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  CarConsumptionCriteria(this._countryCriteria)
      : super(
          key: 'car_consumption',
          minValue: 0, // is overriden below
          maxValue: 0, // is overriden below
          step: 1,
          currentValue: 0, // is changed just below
        ) {
    currentValue = _meanValue;
  }

  @override
  String title(BuildContext context) => context.i18n.carConsumptionCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.inUnit(unit);

  @override
  double get minValue =>
      _countryCriteria.unitSystem() == UnitSystem.metric ? 2 : -141; // Minus to have a correct ordering (min < max)

  @override
  double get maxValue =>
      _countryCriteria.unitSystem() == UnitSystem.metric ? 15 : -15; // Minus to have a correct ordering (min < max)

  @override
  double get currentValue => (super.currentValue > maxValue || super.currentValue < minValue) ? _meanValue : super.currentValue;

  @override
  String get unit => _countryCriteria.unitSystem() == UnitSystem.metric
      ? 'L/100km'
      : 'mpg'; // Actually there is 2 different mpg, we mix them two here and will do the diff in carbon calculation

  @override
  Map<String, double> shortcuts(BuildContext context) {
    return {
      context.i18n.shortcutUnknown: _meanValue,
    };
  }

  double get _meanValue => _countryCriteria.unitSystem() == UnitSystem.metric
      ? 6
      : _countryCriteria.unitSystem() == UnitSystem.us
          ? -40
          : -50;
}

class PublicTransportCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  PublicTransportCriteria(this._countryCriteria)
      : super(
          key: 'public_transport',
          minValue: 0,
          maxValue: 3000,
          step: 50,
          currentValue: 0, // is changed just below
        );

  @override
  String title(BuildContext context) => context.i18n.publicTransportCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.inUnitPerMonth(unit);

  @override
  String get unit => _countryCriteria.unitSystem() == UnitSystem.metric ? 'km' : 'miles';

  @override
  double get currentValue => super.currentValue > maxValue
      ? min(maxValue, super.currentValue / 12)
      : super.currentValue; // Necessary since I switched from year to month

  @override
  double co2EqTonsPerYear() {
    const co2TonsPerKm = 0.00014;
    final milesToKmFactor = _countryCriteria.unitSystem() == UnitSystem.metric ? 1 : _oneMileInKms;
    return currentValue * milesToKmFactor * co2TonsPerKm * 12; // x12 for the yearly value
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 2) {
      return context.i18n.publicTransportCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, double> shortcuts(BuildContext context) {
    final kmToMilesFactor = _countryCriteria.unitSystem() == UnitSystem.metric ? 1.0 : _oneMileInKms;

    // The first number represents the average km/h for a type a transport, the 20 represents the number of typical working days in a month.
    // Of course this is an approximation and will clearly depends of the place.
    return {
      context.i18n.publicTransportCriteriaShortcutBus: (18 * 20) / kmToMilesFactor,
      context.i18n.publicTransportCriteriaShortcutSubway: (30 * 20) / kmToMilesFactor,
      context.i18n.publicTransportCriteriaShortcutSuburbanTrain: (50 * 20) / kmToMilesFactor,
      context.i18n.publicTransportCriteriaShortcutTrain: (100 * 20) / kmToMilesFactor,
    };
  }
}

class TravelCategory extends CriteriaCategory {
  final flightsCriteria = FlightsCriteria();
  late CarCriteria carCriteria;
  late CarConsumptionCriteria carConsumptionCriteria;
  late PublicTransportCriteria publicTransportCriteria;

  TravelCategory(CountryCriteria countryCriteria) : super(key: 'travel') {
    carConsumptionCriteria = CarConsumptionCriteria(countryCriteria);
    carCriteria = CarCriteria(carConsumptionCriteria, countryCriteria);
    publicTransportCriteria = PublicTransportCriteria(countryCriteria);
  }

  @override
  String title(BuildContext context) => context.i18n.travelCategoryTitle;

  @override
  List<Criteria> getCriteriaList() => [flightsCriteria, carCriteria, carConsumptionCriteria, publicTransportCriteria];
}

const _foodLinks = {
  'FR': {
    'OpenFoodFact scanner': 'https://fr.openfoodfacts.org/application-mobile-open-food-facts',
    'Karbon scanner': 'https://www.karbon.earth/',
    'TooGoodToGo Anti-Gaspi': 'https://toogoodtogo.fr/',
    'Phenix Anti-Gaspi': 'https://phenixapp.page.link/open-app',
    'Etiquettable': 'https://etiquettable.eco2initiative.com/application/',
  },
};

class RuminantMeatCriteria extends Criteria {
  RuminantMeatCriteria()
      : super(
          key: 'ruminant_meat',
          minValue: 0,
          maxValue: 20,
          step: 1,
          currentValue: 0,
        );

  @override
  String title(BuildContext context) => context.i18n.ruminantMeatCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.perWeek;

  @override
  double co2EqTonsPerYear() {
    // Not CoolClimate results here, more like a mean from beek and lamb. I took 40kg CO2e per kg (a meal = 150g).
    // formula = ( (x/10*1.5) * (365/7) ) / 1000
    // See https://ourworldindata.org/food-choice-vs-eating-local
    const co2TonsPerTimePerWeek = 0.31;
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.ruminantMeatCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, Map<String, String>> links() => _foodLinks;
}

class NonRuminantMeatCriteria extends Criteria {
  NonRuminantMeatCriteria()
      : super(
          key: 'non_ruminant_meat',
          minValue: 0,
          maxValue: 20,
          step: 1,
          currentValue: 0,
        );

  @override
  String title(BuildContext context) => context.i18n.nonRuminantMeatCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.perWeek;

  @override
  double co2EqTonsPerYear() {
    // Not CoolClimate results here, more like a mean from pork and fish. I took 6kg CO2e per kg (a meal = 150g).
    // formula = ( (x/10*1.5) * (365/7) ) / 1000
    // See https://ourworldindata.org/food-choice-vs-eating-local
    const co2TonsPerTimePerWeek = 0.046;
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.nonRuminantMeatCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, Map<String, String>> links() => _foodLinks;
}

class CheeseCriteria extends Criteria {
  CheeseCriteria()
      : super(
          key: 'cheese',
          minValue: 0,
          maxValue: 20,
          step: 1,
          currentValue: 0,
        );

  @override
  String title(BuildContext context) => context.i18n.cheeseCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.perWeek;

  @override
  double co2EqTonsPerYear() {
    // Not CoolClimate results here, more like a mean from pork and fish. I took 20kg CO2e per kg (a portion = 50g).
    // formula = ( (x/10*0.5) * (365/7) ) / 1000
    // See https://ourworldindata.org/food-choice-vs-eating-local
    const co2TonsPerTimePerWeek = 0.05;
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.cheeseCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, Map<String, String>> links() => _foodLinks;
}

class SnackCriteria extends Criteria {
  SnackCriteria()
      : super(
          key: 'snack',
          minValue: 0,
          maxValue: 20,
          step: 1,
          currentValue: 0,
        );

  @override
  String title(BuildContext context) => context.i18n.snacksCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.perWeek;

  @override
  double co2EqTonsPerYear() {
    const co2TonsPerTimePerWeek = 0.068; // CoolClimate numbers, I didn't find any other source which confirm that
    return currentValue * co2TonsPerTimePerWeek;
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.snacksCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, Map<String, String>> links() => _foodLinks;
}

class OverweightCriteria extends Criteria {
  final RuminantMeatCriteria _ruminantMeatCriteria;
  final NonRuminantMeatCriteria _nonRuminantMeatCriteria;
  final CheeseCriteria _dairyCriteria;
  final SnackCriteria _snackCriteria;

  OverweightCriteria(this._ruminantMeatCriteria, this._nonRuminantMeatCriteria, this._dairyCriteria, this._snackCriteria)
      : super(
          key: 'overweight',
          minValue: 0,
          maxValue: 2,
          step: 1,
          currentValue: 0,
        );

  @override
  String title(BuildContext context) => context.i18n.overweightCriteriaTitle;

  @override
  List<String> labels(BuildContext context) => [
        context.i18n.overweightCriteriaLabel1,
        context.i18n.overweightCriteriaLabel2,
        context.i18n.overweightCriteriaLabel3,
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
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.overweightCriteriaAdvice;
    } else {
      return null;
    }
  }
}

class FoodCategory extends CriteriaCategory {
  final ruminantMeatCriteria = RuminantMeatCriteria();
  final nonRuminantMeatCriteria = NonRuminantMeatCriteria();
  final dairyCriteria = CheeseCriteria();
  final snackCriteria = SnackCriteria();
  late OverweightCriteria overweightCriteria =
      OverweightCriteria(ruminantMeatCriteria, nonRuminantMeatCriteria, dairyCriteria, snackCriteria);

  FoodCategory() : super(key: 'food');

  @override
  String title(BuildContext context) => context.i18n.foodCategoryTitle;

  @override
  double co2EqTonsPerYear() {
    // I add 2 tons to everyone since we all eat vegetables, fruits, ... which I do not ask for quantity.
    // Of course it is not precise.
    return super.co2EqTonsPerYear() + 2;
  }

  @override
  List<Criteria> getCriteriaList() =>
      [ruminantMeatCriteria, nonRuminantMeatCriteria, dairyCriteria, snackCriteria, overweightCriteria];
}

class MaterialGoodsCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  MaterialGoodsCriteria(this._countryCriteria)
      : super(
          key: 'material_goods',
          minValue: 0,
          maxValue: 0, // is overriden below
          step: 10,
          currentValue: 0, // is overriden below
        );

  @override
  String title(BuildContext context) => context.i18n.materialGoodsCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.materialGoodsCriteriaExplanation(unit);

  @override
  double get maxValue => (((10000 / _countryCriteria.getCurrencyRate()) / step).truncate() * step).toDouble();

  @override
  double get currentValue => super.currentValue > maxValue
      ? min(maxValue, super.currentValue / 12)
      : super.currentValue; // Necessary since I switched from year to month

  @override
  String get unit => _countryCriteria.getCurrencyCode();

  @override
  double co2EqTonsPerYear() {
    final moneyChange = _countryCriteria.getCurrencyRate();
    const co2TonsPerDollarPerMonth = 0.0062; // CoolClimate provides a value per month
    return currentValue * moneyChange * co2TonsPerDollarPerMonth; // returns a yearly value
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.materialGoodsCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, Map<String, String>> links() => const {
        'FR': {
          'BackMarket : produits reconditionnés': 'https://www.backmarket.fr/',
          'LeBonCoin : petites annonces': 'https://www.leboncoin.fr/',
          'Vinted : vêtements de seconde main': 'https://www.vinted.fr/',
          "Geev : dons d'objets": 'https://www.geev.com/fr',
          "Emmaüs : dons/achat d'occasions": 'https://www.label-emmaus.co/fr/nos-boutiques/',
          "Zack : revend/répare/recycle l'électronique": 'https://www.zack.eco/',
          'Murphy : réparation électroménager': 'https://murfy.fr/',
          "Bricolib : location d'outils": 'https://www.bricolib.net/',
        },
      };
}

class SavingsCriteria extends Criteria {
  final CountryCriteria _countryCriteria;

  SavingsCriteria(this._countryCriteria)
      : super(
          key: 'savings',
          minValue: 0,
          maxValue: 0, // is overriden below
          step: 1000,
          currentValue: 0, // is overriden below
        );

  @override
  String title(BuildContext context) => context.i18n.savingsCriteriaTitle;

  @override
  String explanation(BuildContext context) => '${context.i18n.inUnit(unit)}\n\n${context.i18n.savingsCriteriaExplanation}';

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
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.savingsCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, Map<String, String>> links() => const {
        'FR': {
          'Calculateur Rift': 'https://riftapp.fr/',
          'Banque mobile Helios': 'https://www.helios.do/',
        },
      };
}

class WaterCriteria extends Criteria {
  WaterCriteria()
      : super(
          key: 'water',
          minValue: 0,
          maxValue: 2,
          step: 1,
          currentValue: 1,
        );

  @override
  String title(BuildContext context) => context.i18n.waterCriteriaTitle;

  @override
  String explanation(BuildContext context) => context.i18n.waterCriteriaExplanation;

  @override
  List<String> labels(BuildContext context) => [
        context.i18n.waterCriteriaLabel1,
        context.i18n.waterCriteriaLabel2,
        context.i18n.waterCriteriaLabel3,
      ];

  @override
  double co2EqTonsPerYear() {
    return 1.56 * ((currentValue + 1) / 2);
  }

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 1) {
      return context.i18n.waterCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, Map<String, String>> links() => const {
        'FR': {
          "Douchette à réduction d'eau Hansgrohe":
              'https://www.hansgrohe.fr/articledetail-crometta-douchette-a-main-vario-green-6l-min-26336400',
          "Mousseurs robinet à réduction d'eau Hansgrohe":
              'https://www.hansgrohe.fr/articledetail-2-mousseurs-ecosmart-lavabo-et-bidet-sous-blister-13958002',
        },
      };
}

class InternetCriteria extends Criteria {
  InternetCriteria()
      : super(
          key: 'internet',
          minValue: 0,
          maxValue: 2,
          step: 1,
          currentValue: 1,
        );

  @override
  String title(BuildContext context) => context.i18n.internetCriteriaTitle;

  @override
  List<String> labels(BuildContext context) => [
        context.i18n.internetCriteriaLabel1,
        context.i18n.internetCriteriaLabel2,
        context.i18n.internetCriteriaLabel3,
      ];

  @override
  double co2EqTonsPerYear() => 0.1 + currentValue * 0.25; // Based on Carbonalyser extension's results

  @override
  String? advice(BuildContext context) {
    if (co2EqTonsPerYear() > 0.5) {
      return context.i18n.internetCriteriaAdvice;
    } else {
      return null;
    }
  }

  @override
  Map<String, Map<String, String>> links() => const {
        // All countries
        '': {
          'Ecosia': 'https://www.ecosia.org/',
          'Cleanfox mail cleaner': 'https://www.cleanfox.io/',
          'Mobile Carbonalyser': 'https://primezone.orange.com/app/Mobile-Carbonalyser/367',
        },
      };
}

class GoodsCategory extends CriteriaCategory {
  late MaterialGoodsCriteria materialGoodsCriteria;
  late SavingsCriteria savingsCriteria;
  final waterCriteria = WaterCriteria();
  final internetCriteria = InternetCriteria();

  GoodsCategory(CountryCriteria countryCriteria) : super(key: 'goods') {
    materialGoodsCriteria = MaterialGoodsCriteria(countryCriteria);
    savingsCriteria = SavingsCriteria(countryCriteria);
  }

  @override
  String title(BuildContext context) => context.i18n.goodsAndServicesCategoryTitle;

  @override
  List<Criteria> getCriteriaList() => [materialGoodsCriteria, savingsCriteria, waterCriteria, internetCriteria];
}
