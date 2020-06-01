// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'messages_all.dart';

class S {
 
  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }
  
  static Future<S> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new S();
    });
  }
  
  String get moneyChangeCriteriaTitle {
    return Intl.message("What is your local currency?", name: 'moneyChangeCriteriaTitle');
  }

  String get unitCriteriaTitle {
    return Intl.message("Which units do you use?", name: 'unitCriteriaTitle');
  }

  String get unitCriteriaLabel1 {
    return Intl.message("Meters and Liters", name: 'unitCriteriaLabel1');
  }

  String get unitCriteriaLabel2 {
    return Intl.message("Miles and Gallons (US)", name: 'unitCriteriaLabel2');
  }

  String get unitCriteriaLabel3 {
    return Intl.message("Miles and Gallons (UK)", name: 'unitCriteriaLabel3');
  }

  String get generalCategoryTitle {
    return Intl.message("General", name: 'generalCategoryTitle');
  }

  String get generalAdvice {
    return Intl.message("Your own impact is insignificant comparing to governments's ones, and as of today their ecological politics are far from sufficient. If you can, try to influence their decisions, by voting or via other means.", name: 'generalAdvice');
  }

  String get peopleCriteriaTitle {
    return Intl.message("Number of people living in your appartment/house", name: 'peopleCriteriaTitle');
  }

  String get peopleCriteriaExplanation {
    return Intl.message("The more you are, the less energy per person is needed to heat or drive you.", name: 'peopleCriteriaExplanation');
  }

  String get heatingFuelCriteriaTitle {
    return Intl.message("Your heating fuel/gas bill", name: 'heatingFuelCriteriaTitle');
  }

  String heatingFuelCriteriaExplanation(value) {
    return Intl.message("Money spent each year, in ${value}.", name: 'heatingFuelCriteriaExplanation', args: [value]);
  }

  String get heatingFuelCriteriaAdvice {
    return Intl.message("First of all, try to better insulate your home and do not heat more than necessary (you can use smart controls to limit heating and do not heat an adult room above 66°F/19°C since it will actually reduce the sleep quality). Then prefer heating with heat pump, with carbon-free electricity or with wood pellets from local and sustainable forests.", name: 'heatingFuelCriteriaAdvice');
  }

  String get electricityBillCriteriaTitle {
    return Intl.message("Your electricity bill", name: 'electricityBillCriteriaTitle');
  }

  String electricityBillCriteriaExplanation(value) {
    return Intl.message("Money spent each year, in ${value}.", name: 'electricityBillCriteriaExplanation', args: [value]);
  }

  String get cleanElectricityCriteriaTitle {
    return Intl.message("Percent of carbon-free electricity", name: 'cleanElectricityCriteriaTitle');
  }

  String get cleanElectricityCriteriaExplanation {
    return Intl.message("Including nuclear, wind, solar or hydraulic electricity.\n\nIf you don't know, you may be able to find some answers on https://www.electricitymap.org", name: 'cleanElectricityCriteriaExplanation');
  }

  String get cleanElectricityCriteriaAdvice {
    return Intl.message("Choose your electricity provider to only pay for renewable or nuclear electricity.", name: 'cleanElectricityCriteriaAdvice');
  }

  String get waterCriteriaTitle {
    return Intl.message("Your water consumption", name: 'waterCriteriaTitle');
  }

  String get waterCriteriaExplanation {
    return Intl.message("Including the water you use for showers, baths, toilet flushes and gardening.", name: 'waterCriteriaExplanation');
  }

  String get waterCriteriaLabel1 {
    return Intl.message("Low (quick showers, no garden)", name: 'waterCriteriaLabel1');
  }

  String get waterCriteriaLabel2 {
    return Intl.message("Normal", name: 'waterCriteriaLabel2');
  }

  String get waterCriteriaLabel3 {
    return Intl.message("High (long showers or baths, big garden, …)", name: 'waterCriteriaLabel3');
  }

  String get waterCriteriaAdvice {
    return Intl.message("You can easily limit your water consumption by taking short showers (avoid baths) with a water reduction showerhead (up to -70% water). You can also put a plastic bottle in the water tank of your toilet to limit its capacity and buy a water recuperator for your garden.", name: 'waterCriteriaAdvice');
  }

  String get homeCategoryTitle {
    return Intl.message("Home", name: 'homeCategoryTitle');
  }

  String get flightsCriteriaTitle {
    return Intl.message("Distance travelled per year by airplane", name: 'flightsCriteriaTitle');
  }

  String get flightsCriteriaExplanation {
    return Intl.message("An airplane produces between 6x and 40x more greenhouse gas per passenger than a train.", name: 'flightsCriteriaExplanation');
  }

  String get flightsCriteriaAdvice {
    return Intl.message("Ask yourself: do you really need these airplane trips? Consider having holidays in your own country and take the train.", name: 'flightsCriteriaAdvice');
  }

  String get carCriteriaTitle {
    return Intl.message("Distance travelled per year with a gasoline/diesel car", name: 'carCriteriaTitle');
  }

  String get carCriteriaExplanation {
    return Intl.message("If you are alone in your car, it is the equivalent of 70% of the pollution per passenger generated by an aircraft for the same journey.", name: 'carCriteriaExplanation');
  }

  String get carCriteriaAdviceHigh {
    return Intl.message("You drive too much to continue using your gasoline/diesel car like that. You should reduce your car usage by moving house or adopting remote work and use the train/subway/bus for most of your transport. If you can't do this and have access to carbon-free electricity, consider buying a small electric car (avoid big cars).", name: 'carCriteriaAdviceHigh');
  }

  String get carCriteriaAdviceLow {
    return Intl.message("You may further improve your car impact by learning eco-driving or by using train/subway/bus (don't buy an new car, its construction will pollutes more than using your current one).", name: 'carCriteriaAdviceLow');
  }

  String get carConsumptionCriteriaTitle {
    return Intl.message("Your car's fuel consumption", name: 'carConsumptionCriteriaTitle');
  }

  String get publicTransportCriteriaTitle {
    return Intl.message("Distance travelled per year in bus, train or subway", name: 'publicTransportCriteriaTitle');
  }

  String get publicTransportCriteriaAdvice {
    return Intl.message("Consider doing remote work to reduce your transport carbon footprint.", name: 'publicTransportCriteriaAdvice');
  }

  String get travelCategoryTitle {
    return Intl.message("Transport", name: 'travelCategoryTitle');
  }

  String get meatCriteriaTitle {
    return Intl.message("Number of meat, fish or egg meal per week", name: 'meatCriteriaTitle');
  }

  String get meatCriteriaExplanation {
    return Intl.message("The meat is a major greenhouse gas emmiter. The beef and lamb emit more than 3 times more greenhouse gas than chicken and more than 5 times more greenhouse gas than most vegetables.", name: 'meatCriteriaExplanation');
  }

  String get meatCriteriaAdvice {
    return Intl.message("Adults does not need more than 2-3 meat meal per week (a bit more for kids). You also should favorise chicken (3 times less poluting than beef).", name: 'meatCriteriaAdvice');
  }

  String get dairyCriteriaTitle {
    return Intl.message("Number of dairy products per week", name: 'dairyCriteriaTitle');
  }

  String get dairyCriteriaExplanation {
    return Intl.message("It is generally recommended to eat some at least once per day.", name: 'dairyCriteriaExplanation');
  }

  String get snacksCriteriaTitle {
    return Intl.message("Number of snacks, drinks or other highly transformed foods per week", name: 'snacksCriteriaTitle');
  }

  String get snacksCriteriaExplanation {
    return Intl.message("If you are starving to death, they will do the job. Otherwise, just avoid them.", name: 'snacksCriteriaExplanation');
  }

  String get snacksCriteriaAdvice {
    return Intl.message("Prefer water, vegetables and fruits than snacks, transformed foods or drinks. Be careful, buying local products does not necessarily limit carbon emissions and can even make them worse in many cases.", name: 'snacksCriteriaAdvice');
  }

  String get overweightCriteriaTitle {
    return Intl.message("Are you overweight?", name: 'overweightCriteriaTitle');
  }

  String get overweightCriteriaExplanation {
    return Intl.message("Being overweight basically means you absorb more energy than you body needs. Each year, humanity consumes unnecessary 140 billions of tons of food.", name: 'overweightCriteriaExplanation');
  }

  String get overweightCriteriaLabel1 {
    return Intl.message("No", name: 'overweightCriteriaLabel1');
  }

  String get overweightCriteriaLabel2 {
    return Intl.message("A bit", name: 'overweightCriteriaLabel2');
  }

  String get overweightCriteriaLabel3 {
    return Intl.message("Quite a lot", name: 'overweightCriteriaLabel3');
  }

  String get overweightCriteriaAdvice {
    return Intl.message("Overweight has consequences for your health, but also for the planet. You can kill two birds with one stone by simply reducing meats, drinks, snacks and other highly transformed foods that often have a significant carbon impact.", name: 'overweightCriteriaAdvice');
  }

  String get foodCategoryTitle {
    return Intl.message("Food", name: 'foodCategoryTitle');
  }

  String get materialGoodsCriteriaTitle {
    return Intl.message("Money spent per month in material goods", name: 'materialGoodsCriteriaTitle');
  }

  String get materialGoodsCriteriaExplanation {
    return Intl.message("Concerns furnitures, appliances, clothes, electronic devices, medicines, …", name: 'materialGoodsCriteriaExplanation');
  }

  String get materialGoodsCriteriaAdvice {
    return Intl.message("You buy too much goods and should certainly limit them. If you really need to buy new ones, find second-hand ones and sell or give your previous ones.", name: 'materialGoodsCriteriaAdvice');
  }

  String get internetCriteriaTitle {
    return Intl.message("Amount of Internet data used", name: 'internetCriteriaTitle');
  }

  String get internetCriteriaExplanation {
    return Intl.message("Internet is already responsible of more than 4% of total carbon emissions, and it could double before 2025.", name: 'internetCriteriaExplanation');
  }

  String get internetCriteriaLabel1 {
    return Intl.message("Only few emails or search per week", name: 'internetCriteriaLabel1');
  }

  String get internetCriteriaLabel2 {
    return Intl.message("I use some websites or cloud services at least once per day", name: 'internetCriteriaLabel2');
  }

  String get internetCriteriaLabel3 {
    return Intl.message("I watch lot of streaming video (> 30 min / day)", name: 'internetCriteriaLabel3');
  }

  String get internetCriteriaAdvice {
    return Intl.message("Reduce your carbon footprint by reducing the video streaming quality to 480p maximum (SD). You can also use softwares like Ecosia or Cleanfox to limit your impact.", name: 'internetCriteriaAdvice');
  }

  String get goodsAndServicesCategoryTitle {
    return Intl.message("Goods and services", name: 'goodsAndServicesCategoryTitle');
  }

  String get seeResults {
    return Intl.message("See results", name: 'seeResults');
  }

  String get yourCarbonFootprint {
    return Intl.message("Your carbon footprint:", name: 'yourCarbonFootprint');
  }

  String get knowMore {
    return Intl.message("Learn more", name: 'knowMore');
  }

  String valueWithMore(value) {
    return Intl.message("${value} or more", name: 'valueWithMore', args: [value]);
  }

  String footprintRepartitionTitle(footprint) {
    return Intl.message("Repartition of your ${footprint}:", name: 'footprintRepartitionTitle', args: [footprint]);
  }

  String co2EqTonsValue(value) {
    return Intl.message("${value} tons CO₂eq/year", name: 'co2EqTonsValue', args: [value]);
  }

  String get otherCountriesComparaisonTitle {
    return Intl.message("Comparison with others:", name: 'otherCountriesComparaisonTitle');
  }

  String get otherCountriesColumn1Title {
    return Intl.message("Country", name: 'otherCountriesColumn1Title');
  }

  String get otherCountriesColumn2Title {
    return Intl.message("CO₂eq/year/resident", name: 'otherCountriesColumn2Title');
  }

  String otherCountriesTonsValue(value) {
    return Intl.message("${value} tons", name: 'otherCountriesTonsValue', args: [value]);
  }

  String get otherCountriesMore {
    return Intl.message("More countries on https://coolclimate.org/calculator", name: 'otherCountriesMore');
  }

  String get globalObjectivesTitle {
    return Intl.message("Global goals:", name: 'globalObjectivesTitle');
  }

  String get globalObjectivesPart1 {
    return Intl.message("To stay below +34.7°F/+1.5°C, the IPCC consortium declared that the world should cut its emissions by", name: 'globalObjectivesPart1');
  }

  String get globalObjectivesPart2 {
    return Intl.message(" 45% by 2030 and stop emitting any by 2050.", name: 'globalObjectivesPart2');
  }

  String get globalObjectivesPart3 {
    return Intl.message("\n\n\nSo far, it's very unlikely to happen, see ", name: 'globalObjectivesPart3');
  }

  String get globalObjectivesPart4 {
    return Intl.message("this IPCC summary", name: 'globalObjectivesPart4');
  }

  String get globalObjectivesPart5 {
    return Intl.message(" for the consequences, and the below graph to see the current trend of world carbon emissions:", name: 'globalObjectivesPart5');
  }

  String get advicesTitle {
    return Intl.message("Advices:", name: 'advicesTitle');
  }

  String get noAdvicesExplanation {
    return Intl.message("Well, it seems you already does your best, hence I have no advice.", name: 'noAdvicesExplanation');
  }

  String get disclaimerTitle {
    return Intl.message("Disclaimer:", name: 'disclaimerTitle');
  }

  String get disclaimerExplanation {
    return Intl.message("Due to the complexity of the task, I do not expect this app to be very accurate, but it gives you an idea of your impact. It is possible to find different values with other sources, but sometimes they ignore certains elements, such as the impact of imported products.\n\nIn addition, this app focuses only on our carbon footprint, but we should not forget the other types of pollutions (plastics, pesticides, …).\n\nI'm not affiliated with any of the organizations involved.", name: 'disclaimerExplanation');
  }

  String get aboutPart1 {
    return Intl.message("Warmd is open-source (under GPLv3 license):\nhttps://github.com/FredJul/Warmd\n\nMainly based on https://coolclimate.org 's 2019 results, with the help of other sources:", name: 'aboutPart1');
  }

  String get aboutPart2 {
    return Intl.message("Graphical ressources:", name: 'aboutPart2');
  }

  String get you {
    return Intl.message("You", name: 'you');
  }

  String get countryUSA {
    return Intl.message("USA", name: 'countryUSA');
  }

  String get countryCanada {
    return Intl.message("Canada", name: 'countryCanada');
  }

  String get countryAustralia {
    return Intl.message("Australia", name: 'countryAustralia');
  }

  String get countrySaudiArabia {
    return Intl.message("Saudi Arabia", name: 'countrySaudiArabia');
  }

  String get countryUAE {
    return Intl.message("UAE", name: 'countryUAE');
  }

  String get countryChina {
    return Intl.message("China", name: 'countryChina');
  }

  String get countryIsrael {
    return Intl.message("Israel", name: 'countryIsrael');
  }

  String get countrySouthKorea {
    return Intl.message("South Korea", name: 'countrySouthKorea');
  }

  String get countryJapan {
    return Intl.message("Japan", name: 'countryJapan');
  }

  String get countryGermany {
    return Intl.message("Germany", name: 'countryGermany');
  }

  String get countrySouthAfrica {
    return Intl.message("South Africa", name: 'countrySouthAfrica');
  }

  String get countryRussia {
    return Intl.message("Russia", name: 'countryRussia');
  }

  String get countryGreece {
    return Intl.message("Greece", name: 'countryGreece');
  }

  String get countryUK {
    return Intl.message("UK", name: 'countryUK');
  }

  String get countryNorway {
    return Intl.message("Norway", name: 'countryNorway');
  }

  String get countryIndia {
    return Intl.message("India", name: 'countryIndia');
  }

  String get countryFrance {
    return Intl.message("France", name: 'countryFrance');
  }

  String get countryMexico {
    return Intl.message("Mexico", name: 'countryMexico');
  }

  String get countryBrasil {
    return Intl.message("Brasil", name: 'countryBrasil');
  }

  String get countryEgypt {
    return Intl.message("Egypt", name: 'countryEgypt');
  }

  String get countryVietnam {
    return Intl.message("Vietnam", name: 'countryVietnam');
  }

  String get countryMorocco {
    return Intl.message("Morocco", name: 'countryMorocco');
  }

  String get countryPhilippines {
    return Intl.message("Philippines", name: 'countryPhilippines');
  }

  String get countryCongo {
    return Intl.message("Congo", name: 'countryCongo');
  }

  String get countrySoudan {
    return Intl.message("Soudan", name: 'countrySoudan');
  }

  String get doneWith {
    return Intl.message("Done with Warmd - Carbon footprint calculator", name: 'doneWith');
  }


}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
			Locale("en", ""),
			Locale("fr", ""),

    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    return S.load(locale);
  }

  @override
  bool isSupported(Locale locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

// ignore_for_file: unnecessary_brace_in_string_interps
