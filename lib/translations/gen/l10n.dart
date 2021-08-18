// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Translation {
  Translation();

  static Translation? _current;

  static Translation get current {
    assert(_current != null,
        'No instance of Translation was loaded. Try to initialize the Translation delegate before accessing Translation.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Translation> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Translation();
      Translation._current = instance;

      return instance;
    });
  }

  static Translation of(BuildContext context) {
    final instance = Translation.maybeOf(context);
    assert(instance != null,
        'No instance of Translation present in the widget tree. Did you add Translation.delegate in localizationsDelegates?');
    return instance!;
  }

  static Translation? maybeOf(BuildContext context) {
    return Localizations.of<Translation>(context, Translation);
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Understand your impact`
  String get onboardingStep1Title {
    return Intl.message(
      'Understand your impact',
      name: 'onboardingStep1Title',
      desc: '',
      args: [],
    );
  }

  /// `See how your activities impact planet, animals & more.`
  String get onboardingStep1Description {
    return Intl.message(
      'See how your activities impact planet, animals & more.',
      name: 'onboardingStep1Description',
      desc: '',
      args: [],
    );
  }

  /// `Take action to reduce impact`
  String get onboardingStep2Title {
    return Intl.message(
      'Take action to reduce impact',
      name: 'onboardingStep2Title',
      desc: '',
      args: [],
    );
  }

  /// `Taking small steps, everyday, are cornerstone to drive big changes for the future.`
  String get onboardingStep2Description {
    return Intl.message(
      'Taking small steps, everyday, are cornerstone to drive big changes for the future.',
      name: 'onboardingStep2Description',
      desc: '',
      args: [],
    );
  }

  /// `GET STARTED`
  String get onboardingAction {
    return Intl.message(
      'GET STARTED',
      name: 'onboardingAction',
      desc: '',
      args: [],
    );
  }

  /// `Hello there,`
  String get welcomeTitle {
    return Intl.message(
      'Hello there,',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for downloading Warmd and taking the first step to making our future generations safer.\n\n\nBefore you get started, we’ll ask you few questions to create personalized recommendations. Are you ready?`
  String get welcomeDescription {
    return Intl.message(
      'Thank you for downloading Warmd and taking the first step to making our future generations safer.\n\n\nBefore you get started, we’ll ask you few questions to create personalized recommendations. Are you ready?',
      name: 'welcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `LET'S GO`
  String get welcomeAction {
    return Intl.message(
      'LET\'S GO',
      name: 'welcomeAction',
      desc: '',
      args: [],
    );
  }

  /// `COUNTRY`
  String get countrySelectionTitle {
    return Intl.message(
      'COUNTRY',
      name: 'countrySelectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Which country do you reside in?`
  String get countrySelectionQuestion {
    return Intl.message(
      'Which country do you reside in?',
      name: 'countrySelectionQuestion',
      desc: '',
      args: [],
    );
  }

  /// `This information allows us to correctly compute your carbon footprint.`
  String get countrySelectionExplanation {
    return Intl.message(
      'This information allows us to correctly compute your carbon footprint.',
      name: 'countrySelectionExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Search a country`
  String get countrySelectionSearchHint {
    return Intl.message(
      'Search a country',
      name: 'countrySelectionSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `We didn't recognize that country, please try to write it in the country official language or select it in the list.`
  String get countrySelectionNotFound {
    return Intl.message(
      'We didn\'t recognize that country, please try to write it in the country official language or select it in the list.',
      name: 'countrySelectionNotFound',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE`
  String get continueAction {
    return Intl.message(
      'CONTINUE',
      name: 'continueAction',
      desc: '',
      args: [],
    );
  }

  /// `You can always update the data later on.`
  String get continueActionExplanation {
    return Intl.message(
      'You can always update the data later on.',
      name: 'continueActionExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Per week.`
  String get perWeek {
    return Intl.message(
      'Per week.',
      name: 'perWeek',
      desc: '',
      args: [],
    );
  }

  /// `In {unit}.`
  String inUnit(Object unit) {
    return Intl.message(
      'In $unit.',
      name: 'inUnit',
      desc: '',
      args: [unit],
    );
  }

  /// `In {unit} for last month.`
  String inUnitPerMonth(Object unit) {
    return Intl.message(
      'In $unit for last month.',
      name: 'inUnitPerMonth',
      desc: '',
      args: [unit],
    );
  }

  /// `Your own impact is insignificant compared to that of companies or governments, and for the moment their ecological policies are far from sufficient.\nTry to influence their decisions by voting, by writing to your representatives, by joigning a climate action group or via other means.\n\nIf there is one thing to do it is certainly this one.`
  String get politicalAdvice {
    return Intl.message(
      'Your own impact is insignificant compared to that of companies or governments, and for the moment their ecological policies are far from sufficient.\nTry to influence their decisions by voting, by writing to your representatives, by joigning a climate action group or via other means.\n\nIf there is one thing to do it is certainly this one.',
      name: 'politicalAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Your heating fuel/gas bill`
  String get heatingFuelCriteriaTitle {
    return Intl.message(
      'Your heating fuel/gas bill',
      name: 'heatingFuelCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Try to better insulate your home and avoid heating more than necessary (an adult sleep quality is best at 66°F/19°C). Smart controls can help you switching off the heating when you are outside.\n\nAlso prefer heating with heat pump, with low-carbon electricity, with wood from local and sustainable forests or with biogas.`
  String get heatingFuelCriteriaAdvice {
    return Intl.message(
      'Try to better insulate your home and avoid heating more than necessary (an adult sleep quality is best at 66°F/19°C). Smart controls can help you switching off the heating when you are outside.\n\nAlso prefer heating with heat pump, with low-carbon electricity, with wood from local and sustainable forests or with biogas.',
      name: 'heatingFuelCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Your electricity bill`
  String get electricityBillCriteriaTitle {
    return Intl.message(
      'Your electricity bill',
      name: 'electricityBillCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Percent of low-carbon electricity`
  String get cleanElectricityCriteriaTitle {
    return Intl.message(
      'Percent of low-carbon electricity',
      name: 'cleanElectricityCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Including nuclear, wind, solar or hydraulic electricity.\n\nIf you don't know, you may be able to find some answers on (a https://www.electricitymap.org)ElectricityMap(/a).`
  String get cleanElectricityCriteriaExplanation {
    return Intl.message(
      'Including nuclear, wind, solar or hydraulic electricity.\n\nIf you don\'t know, you may be able to find some answers on (a https://www.electricitymap.org)ElectricityMap(/a).',
      name: 'cleanElectricityCriteriaExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Choose your electricity provider to only pay for renewable or nuclear electricity.\n\nIf you cannot use more low-carbon electricity, then consider reducing your use of electric car or electric heater.`
  String get cleanElectricityCriteriaAdvice {
    return Intl.message(
      'Choose your electricity provider to only pay for renewable or nuclear electricity.\n\nIf you cannot use more low-carbon electricity, then consider reducing your use of electric car or electric heater.',
      name: 'cleanElectricityCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Utilities`
  String get utilitiesCategoryTitle {
    return Intl.message(
      'Utilities',
      name: 'utilitiesCategoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hours spent in an airplane`
  String get flightsCriteriaTitle {
    return Intl.message(
      'Hours spent in an airplane',
      name: 'flightsCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `An airplane produces between 6x and 40x more greenhouse gas per passenger than a train.\n\nAsk yourself: do you really need these airplane trips? Consider having holidays in your own country and take the train.`
  String get flightsCriteriaAdvice {
    return Intl.message(
      'An airplane produces between 6x and 40x more greenhouse gas per passenger than a train.\n\nAsk yourself: do you really need these airplane trips? Consider having holidays in your own country and take the train.',
      name: 'flightsCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Distance travelled with a gasoline/diesel car`
  String get carCriteriaTitle {
    return Intl.message(
      'Distance travelled with a gasoline/diesel car',
      name: 'carCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `You should reduce your car usage by moving house, adopting remote work or using the train/subway/tram/bus for most of your transport.\n\nIf you can't do this and have access to low-carbon electricity, consider buying a small electric car (always avoid big or sport cars).`
  String get carCriteriaAdviceHigh {
    return Intl.message(
      'You should reduce your car usage by moving house, adopting remote work or using the train/subway/tram/bus for most of your transport.\n\nIf you can\'t do this and have access to low-carbon electricity, consider buying a small electric car (always avoid big or sport cars).',
      name: 'carCriteriaAdviceHigh',
      desc: '',
      args: [],
    );
  }

  /// `You may further improve your car impact by learning eco-driving or by using train/subway/tram/bus (don't buy an new car, its construction will pollutes more than using your current one).`
  String get carCriteriaAdviceLow {
    return Intl.message(
      'You may further improve your car impact by learning eco-driving or by using train/subway/tram/bus (don\'t buy an new car, its construction will pollutes more than using your current one).',
      name: 'carCriteriaAdviceLow',
      desc: '',
      args: [],
    );
  }

  /// `1 hr/day`
  String get carCriteriaShortcutOneHourPerDay {
    return Intl.message(
      '1 hr/day',
      name: 'carCriteriaShortcutOneHourPerDay',
      desc: '',
      args: [],
    );
  }

  /// `2 hrs/day`
  String get carCriteriaShortcutTwoHoursPerDay {
    return Intl.message(
      '2 hrs/day',
      name: 'carCriteriaShortcutTwoHoursPerDay',
      desc: '',
      args: [],
    );
  }

  /// `Your car's fuel consumption`
  String get carConsumptionCriteriaTitle {
    return Intl.message(
      'Your car\'s fuel consumption',
      name: 'carConsumptionCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Distance travelled in bus, train, subway or tram`
  String get publicTransportCriteriaTitle {
    return Intl.message(
      'Distance travelled in bus, train, subway or tram',
      name: 'publicTransportCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Consider doing remote work to reduce your transport carbon footprint.`
  String get publicTransportCriteriaAdvice {
    return Intl.message(
      'Consider doing remote work to reduce your transport carbon footprint.',
      name: 'publicTransportCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `1 hr/day of bus`
  String get publicTransportCriteriaShortcutBus {
    return Intl.message(
      '1 hr/day of bus',
      name: 'publicTransportCriteriaShortcutBus',
      desc: '',
      args: [],
    );
  }

  /// `1 hr/day of subway`
  String get publicTransportCriteriaShortcutSubway {
    return Intl.message(
      '1 hr/day of subway',
      name: 'publicTransportCriteriaShortcutSubway',
      desc: '',
      args: [],
    );
  }

  /// `1 hr/day of suburban train`
  String get publicTransportCriteriaShortcutSuburbanTrain {
    return Intl.message(
      '1 hr/day of suburban train',
      name: 'publicTransportCriteriaShortcutSuburbanTrain',
      desc: '',
      args: [],
    );
  }

  /// `1 hr/day of train`
  String get publicTransportCriteriaShortcutTrain {
    return Intl.message(
      '1 hr/day of train',
      name: 'publicTransportCriteriaShortcutTrain',
      desc: '',
      args: [],
    );
  }

  /// `Transportation`
  String get travelCategoryTitle {
    return Intl.message(
      'Transportation',
      name: 'travelCategoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Number of beef, lamb or mutton meal`
  String get ruminantMeatCriteriaTitle {
    return Intl.message(
      'Number of beef, lamb or mutton meal',
      name: 'ruminantMeatCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ruminant meat production is (a https://ourworldindata.org/uploads/2020/02/Environmental-impact-of-food-by-life-cycle-stage-1536x1380.png)a major greenhouse gas emiter(/a) since it requires a large land use and emits methane, a powerful greenhouse gas. It emits more than 4 times more greenhouse gas than chicken production and at least 10 times more than most fruit and vegetable production, even if we add transport cost to bring them from distant countries.\n\nAdults don't need more than 3 meat meals per week (slightly more for kids). You should not exceed that number and should consider buying chicken instead or even becoming vegetarian.`
  String get ruminantMeatCriteriaAdvice {
    return Intl.message(
      'Ruminant meat production is (a https://ourworldindata.org/uploads/2020/02/Environmental-impact-of-food-by-life-cycle-stage-1536x1380.png)a major greenhouse gas emiter(/a) since it requires a large land use and emits methane, a powerful greenhouse gas. It emits more than 4 times more greenhouse gas than chicken production and at least 10 times more than most fruit and vegetable production, even if we add transport cost to bring them from distant countries.\n\nAdults don\'t need more than 3 meat meals per week (slightly more for kids). You should not exceed that number and should consider buying chicken instead or even becoming vegetarian.',
      name: 'ruminantMeatCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Number of pig, chicken, fish or egg meal`
  String get nonRuminantMeatCriteriaTitle {
    return Intl.message(
      'Number of pig, chicken, fish or egg meal',
      name: 'nonRuminantMeatCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Although less polluting than ruminant meat production, non-ruminant meat production still emits (a https://ourworldindata.org/uploads/2020/02/Environmental-impact-of-food-by-life-cycle-stage-1536x1380.png)at least 4 times more(/a) greenhouse gas than most fruit and vegetable production.\n\nAdults don't need more than 3 meat meals per week (slightly more for kids). You should not exceed that number and could even consider becoming vegetarian.`
  String get nonRuminantMeatCriteriaAdvice {
    return Intl.message(
      'Although less polluting than ruminant meat production, non-ruminant meat production still emits (a https://ourworldindata.org/uploads/2020/02/Environmental-impact-of-food-by-life-cycle-stage-1536x1380.png)at least 4 times more(/a) greenhouse gas than most fruit and vegetable production.\n\nAdults don\'t need more than 3 meat meals per week (slightly more for kids). You should not exceed that number and could even consider becoming vegetarian.',
      name: 'nonRuminantMeatCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Number of cheese portion (1.5 oz)`
  String get cheeseCriteriaTitle {
    return Intl.message(
      'Number of cheese portion (1.5 oz)',
      name: 'cheeseCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `If you want or need dairy product, you can take milk or yogurt instead, which are 5 to 8 times less polluting than cheese.`
  String get cheeseCriteriaAdvice {
    return Intl.message(
      'If you want or need dairy product, you can take milk or yogurt instead, which are 5 to 8 times less polluting than cheese.',
      name: 'cheeseCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Number of snacks, drinks or other highly transformed foods`
  String get snacksCriteriaTitle {
    return Intl.message(
      'Number of snacks, drinks or other highly transformed foods',
      name: 'snacksCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Prefer fruits and vegetables over snacks, chocolate or transformed foods. Also prefer water or home-made drinks over sodas or store-bought juices.`
  String get snacksCriteriaAdvice {
    return Intl.message(
      'Prefer fruits and vegetables over snacks, chocolate or transformed foods. Also prefer water or home-made drinks over sodas or store-bought juices.',
      name: 'snacksCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Overweight and obesity`
  String get overweightCriteriaTitle {
    return Intl.message(
      'Overweight and obesity',
      name: 'overweightCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `I am normal`
  String get overweightCriteriaLabel1 {
    return Intl.message(
      'I am normal',
      name: 'overweightCriteriaLabel1',
      desc: '',
      args: [],
    );
  }

  /// `I am overweight`
  String get overweightCriteriaLabel2 {
    return Intl.message(
      'I am overweight',
      name: 'overweightCriteriaLabel2',
      desc: '',
      args: [],
    );
  }

  /// `I am obese`
  String get overweightCriteriaLabel3 {
    return Intl.message(
      'I am obese',
      name: 'overweightCriteriaLabel3',
      desc: '',
      args: [],
    );
  }

  /// `Being overweight basically means you absorb more energy than your body needs. Each year, humanity consumes an unnecessary 140 billions of tons of food.\n\nTry to increase the share of fruits and vegetables in your diet, or simply reduce the amount of ingested food.`
  String get overweightCriteriaAdvice {
    return Intl.message(
      'Being overweight basically means you absorb more energy than your body needs. Each year, humanity consumes an unnecessary 140 billions of tons of food.\n\nTry to increase the share of fruits and vegetables in your diet, or simply reduce the amount of ingested food.',
      name: 'overweightCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get foodCategoryTitle {
    return Intl.message(
      'Food',
      name: 'foodCategoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Money spent in material goods`
  String get materialGoodsCriteriaTitle {
    return Intl.message(
      'Money spent in material goods',
      name: 'materialGoodsCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `In {unit} for last month.\n\nConcerns furnitures, appliances, clothes, electronic devices, tools, vehicles, vehicles parts, medicines, …`
  String materialGoodsCriteriaExplanation(Object unit) {
    return Intl.message(
      'In $unit for last month.\n\nConcerns furnitures, appliances, clothes, electronic devices, tools, vehicles, vehicles parts, medicines, …',
      name: 'materialGoodsCriteriaExplanation',
      desc: '',
      args: [unit],
    );
  }

  /// `Their construction, especially for electronic and mechanical devices, is generally very polluting.\n\nYou can greatly reduce your footprint by keeping them longer or by simply limiting your purchases. Moreover, there is often several solutions available to repair/sell/give your current goods, find second-hand ones or rent them.`
  String get materialGoodsCriteriaAdvice {
    return Intl.message(
      'Their construction, especially for electronic and mechanical devices, is generally very polluting.\n\nYou can greatly reduce your footprint by keeping them longer or by simply limiting your purchases. Moreover, there is often several solutions available to repair/sell/give your current goods, find second-hand ones or rent them.',
      name: 'materialGoodsCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Money sleeping on a non-decarbonated bank account`
  String get savingsCriteriaTitle {
    return Intl.message(
      'Money sleeping on a non-decarbonated bank account',
      name: 'savingsCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `If you don't know, you can consider that most of your savings are concerned.`
  String get savingsCriteriaExplanation {
    return Intl.message(
      'If you don\'t know, you can consider that most of your savings are concerned.',
      name: 'savingsCriteriaExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Most of today's banks still invest the majority of your savings on companies with big carbon impact. Fortunately, some banks now allow you to choose for low-carbon investments.`
  String get savingsCriteriaAdvice {
    return Intl.message(
      'Most of today\'s banks still invest the majority of your savings on companies with big carbon impact. Fortunately, some banks now allow you to choose for low-carbon investments.',
      name: 'savingsCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Your water consumption`
  String get waterCriteriaTitle {
    return Intl.message(
      'Your water consumption',
      name: 'waterCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Including the water you use for showers, baths, toilet flushes and gardening.`
  String get waterCriteriaExplanation {
    return Intl.message(
      'Including the water you use for showers, baths, toilet flushes and gardening.',
      name: 'waterCriteriaExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Low (quick showers, no garden)`
  String get waterCriteriaLabel1 {
    return Intl.message(
      'Low (quick showers, no garden)',
      name: 'waterCriteriaLabel1',
      desc: '',
      args: [],
    );
  }

  /// `Normal`
  String get waterCriteriaLabel2 {
    return Intl.message(
      'Normal',
      name: 'waterCriteriaLabel2',
      desc: '',
      args: [],
    );
  }

  /// `High (long showers or baths, big garden, …)`
  String get waterCriteriaLabel3 {
    return Intl.message(
      'High (long showers or baths, big garden, …)',
      name: 'waterCriteriaLabel3',
      desc: '',
      args: [],
    );
  }

  /// `You can easily limit your water consumption by taking short showers (avoid baths) with a water reduction showerhead (up to -70% water).\n\nYou can also put a plastic bottle in the water tank of your toilet to limit its capacity and buy a water recuperator for your garden.`
  String get waterCriteriaAdvice {
    return Intl.message(
      'You can easily limit your water consumption by taking short showers (avoid baths) with a water reduction showerhead (up to -70% water).\n\nYou can also put a plastic bottle in the water tank of your toilet to limit its capacity and buy a water recuperator for your garden.',
      name: 'waterCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Amount of Internet data used`
  String get internetCriteriaTitle {
    return Intl.message(
      'Amount of Internet data used',
      name: 'internetCriteriaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Only few emails or search per week`
  String get internetCriteriaLabel1 {
    return Intl.message(
      'Only few emails or search per week',
      name: 'internetCriteriaLabel1',
      desc: '',
      args: [],
    );
  }

  /// `I use some websites or cloud services at least once per day`
  String get internetCriteriaLabel2 {
    return Intl.message(
      'I use some websites or cloud services at least once per day',
      name: 'internetCriteriaLabel2',
      desc: '',
      args: [],
    );
  }

  /// `I watch lot of streaming video (> 30 min / day)`
  String get internetCriteriaLabel3 {
    return Intl.message(
      'I watch lot of streaming video (> 30 min / day)',
      name: 'internetCriteriaLabel3',
      desc: '',
      args: [],
    );
  }

  /// `Internet is already responsible for about 4% of total carbon emissions, more than aviation, and it could double before 2025. This is mostly due to a increasing use of high resolution video.\n\nTry to limit the use of video streaming or simply reduce the video streaming quality to 480p maximum (SD).`
  String get internetCriteriaAdvice {
    return Intl.message(
      'Internet is already responsible for about 4% of total carbon emissions, more than aviation, and it could double before 2025. This is mostly due to a increasing use of high resolution video.\n\nTry to limit the use of video streaming or simply reduce the video streaming quality to 480p maximum (SD).',
      name: 'internetCriteriaAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Goods and services`
  String get goodsAndServicesCategoryTitle {
    return Intl.message(
      'Goods and services',
      name: 'goodsAndServicesCategoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `I don't know`
  String get shortcutUnknown {
    return Intl.message(
      'I don\'t know',
      name: 'shortcutUnknown',
      desc: '',
      args: [],
    );
  }

  /// `{value} or more`
  String valueWithMore(Object value) {
    return Intl.message(
      '$value or more',
      name: 'valueWithMore',
      desc: '',
      args: [value],
    );
  }

  /// `{value} or less`
  String valueWithLess(Object value) {
    return Intl.message(
      '$value or less',
      name: 'valueWithLess',
      desc: '',
      args: [value],
    );
  }

  /// `Your total carbon footprint is`
  String get footprintTitle {
    return Intl.message(
      'Your total carbon footprint is',
      name: 'footprintTitle',
      desc: '',
      args: [],
    );
  }

  /// `Or (b){number} {unit}(/b) with a typical petrol car`
  String footprintCarKmEquivalent(Object number, Object unit) {
    return Intl.message(
      'Or (b)$number $unit(/b) with a typical petrol car',
      name: 'footprintCarKmEquivalent',
      desc: '',
      args: [number, unit],
    );
  }

  /// `See what happens when you don't take action >`
  String get footprintWarning {
    return Intl.message(
      'See what happens when you don\'t take action >',
      name: 'footprintWarning',
      desc: '',
      args: [],
    );
  }

  /// `CARBON FOOTPRINT REPARTITION`
  String get footprintRepartitionTitle {
    return Intl.message(
      'CARBON FOOTPRINT REPARTITION',
      name: 'footprintRepartitionTitle',
      desc: '',
      args: [],
    );
  }

  /// `CARBON FOOTPRINT EVOLUTION`
  String get footprintEvolutionTitle {
    return Intl.message(
      'CARBON FOOTPRINT EVOLUTION',
      name: 'footprintEvolutionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Compute your carbon footprint every month and see your evolution.\n\nThe world must reduce its emissions by at least 6% per year. What about you?`
  String get footprintEvolutionExplanation {
    return Intl.message(
      'Compute your carbon footprint every month and see your evolution.\n\nThe world must reduce its emissions by at least 6% per year. What about you?',
      name: 'footprintEvolutionExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Tons CO₂e / month`
  String get footprintEvolutionTonsAxis {
    return Intl.message(
      'Tons CO₂e / month',
      name: 'footprintEvolutionTonsAxis',
      desc: '',
      args: [],
    );
  }

  /// `My carbon footprint`
  String get footprintShareTitle {
    return Intl.message(
      'My carbon footprint',
      name: 'footprintShareTitle',
      desc: '',
      args: [],
    );
  }

  /// `Done with Warmd: https://fredjul.github.io/Warmd/`
  String get footprintShareLink {
    return Intl.message(
      'Done with Warmd: https://fredjul.github.io/Warmd/',
      name: 'footprintShareLink',
      desc: '',
      args: [],
    );
  }

  /// `SEE WHAT YOU COULD DO`
  String get seeAdvices {
    return Intl.message(
      'SEE WHAT YOU COULD DO',
      name: 'seeAdvices',
      desc: '',
      args: [],
    );
  }

  /// `Reset history?`
  String get resetFootprintHistoryQuestion {
    return Intl.message(
      'Reset history?',
      name: 'resetFootprintHistoryQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to reset your carbon footprint history?`
  String get resetFootprintHistoryConfirmation {
    return Intl.message(
      'Are you sure you want to reset your carbon footprint history?',
      name: 'resetFootprintHistoryConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Remind me to do the test again in 1 month`
  String get redoQuestionnaireReminder {
    return Intl.message(
      'Remind me to do the test again in 1 month',
      name: 'redoQuestionnaireReminder',
      desc: '',
      args: [],
    );
  }

  /// `What is your carbon footprint?`
  String get reminderNotificationTitle {
    return Intl.message(
      'What is your carbon footprint?',
      name: 'reminderNotificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Compute your new carbon footprint and see your progression.`
  String get reminderNotificationDescription {
    return Intl.message(
      'Compute your new carbon footprint and see your progression.',
      name: 'reminderNotificationDescription',
      desc: '',
      args: [],
    );
  }

  /// `REDO QUESTIONNAIRE`
  String get redoQuestionnaire {
    return Intl.message(
      'REDO QUESTIONNAIRE',
      name: 'redoQuestionnaire',
      desc: '',
      args: [],
    );
  }

  /// `Understand how your carbon footprint is calculated and how you could help this project.`
  String get seeAbout {
    return Intl.message(
      'Understand how your carbon footprint is calculated and how you could help this project.',
      name: 'seeAbout',
      desc: '',
      args: [],
    );
  }

  /// `tons\nCO₂e / month`
  String get scoreTonsUnit {
    return Intl.message(
      'tons\nCO₂e / month',
      name: 'scoreTonsUnit',
      desc: '',
      args: [],
    );
  }

  /// `kg\nCO₂e / month`
  String get scoreKgUnit {
    return Intl.message(
      'kg\nCO₂e / month',
      name: 'scoreKgUnit',
      desc: '',
      args: [],
    );
  }

  /// `{value} kg`
  String co2EqKgValue(Object value) {
    return Intl.message(
      '$value kg',
      name: 'co2EqKgValue',
      desc: '',
      args: [value],
    );
  }

  /// `{percent}% ({co2EqTons} tons CO₂e / month)`
  String co2EqPercentTonsValue(Object percent, Object co2EqTons) {
    return Intl.message(
      '$percent% ($co2EqTons tons CO₂e / month)',
      name: 'co2EqPercentTonsValue',
      desc: '',
      args: [percent, co2EqTons],
    );
  }

  /// `{percent}% ({co2EqKg} kg CO₂e / month)`
  String co2EqPercentKgValue(Object percent, Object co2EqKg) {
    return Intl.message(
      '$percent% ($co2EqKg kg CO₂e / month)',
      name: 'co2EqPercentKgValue',
      desc: '',
      args: [percent, co2EqKg],
    );
  }

  /// `What is climate change?`
  String get climateChangeTitle {
    return Intl.message(
      'What is climate change?',
      name: 'climateChangeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Consequences of global warming`
  String get consequencesTitle {
    return Intl.message(
      'Consequences of global warming',
      name: 'consequencesTitle',
      desc: '',
      args: [],
    );
  }

  /// `We already gained (b)+1°C(/b) (in average) from pre-industrial levels, with an already visible increase in the number of heat waves, droughts, fires or cyclones. Despite what some climate skeptics say, scientists (a https://climate.nasa.gov/evidence/)are over 95% sure(/a) that this is due to greenhouse gas emissions from human activities (CO₂, CH₄, N₂O). Nature cannot absorb such a amount of greenhouse gases and, as if that were not enough, we keep adding more to the atmosphere every year.\n\nBy reaching (b)+2°C(/b) in 2100, (a https://www.wwf.org.uk/updates/our-warming-world-how-much-difference-will-half-degree-really-make)we will certainly suffer(/a) a major loss in our biodiversity (-18% insects, -16% plants, -8% vertebrates, -99% corals), 49 million people will be impacted by sea-level rise and 410 million people will suffer severe droughts, leading to massive emigration, financial and political instabilities.\n\nAt (b)+4°C(/b) humans will not be able to live around the equator (a http://www.uhm.hawaii.edu/news/article.php?aId=8657)due to deadly heat(/a):`
  String get consequencesPart1 {
    return Intl.message(
      'We already gained (b)+1°C(/b) (in average) from pre-industrial levels, with an already visible increase in the number of heat waves, droughts, fires or cyclones. Despite what some climate skeptics say, scientists (a https://climate.nasa.gov/evidence/)are over 95% sure(/a) that this is due to greenhouse gas emissions from human activities (CO₂, CH₄, N₂O). Nature cannot absorb such a amount of greenhouse gases and, as if that were not enough, we keep adding more to the atmosphere every year.\n\nBy reaching (b)+2°C(/b) in 2100, (a https://www.wwf.org.uk/updates/our-warming-world-how-much-difference-will-half-degree-really-make)we will certainly suffer(/a) a major loss in our biodiversity (-18% insects, -16% plants, -8% vertebrates, -99% corals), 49 million people will be impacted by sea-level rise and 410 million people will suffer severe droughts, leading to massive emigration, financial and political instabilities.\n\nAt (b)+4°C(/b) humans will not be able to live around the equator (a http://www.uhm.hawaii.edu/news/article.php?aId=8657)due to deadly heat(/a):',
      name: 'consequencesPart1',
      desc: '',
      args: [],
    );
  }

  /// `Billions of people will emigrate to other area with a very high risk of famines, wars and millions or billions of deaths.\n\n(b)+6°C(/b) is the same difference of average temperature between the previous (b)ice age(/b) and the (b)20th century(/b).`
  String get consequencesPart2 {
    return Intl.message(
      'Billions of people will emigrate to other area with a very high risk of famines, wars and millions or billions of deaths.\n\n(b)+6°C(/b) is the same difference of average temperature between the previous (b)ice age(/b) and the (b)20th century(/b).',
      name: 'consequencesPart2',
      desc: '',
      args: [],
    );
  }

  /// `What should you do?`
  String get advicesTitle {
    return Intl.message(
      'What should you do?',
      name: 'advicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Small acts are welcomed, but they should not hide the truth: they are not significative enough to face the climate emergency, we need to focus on the big ones.`
  String get advicesExplanation {
    return Intl.message(
      'Small acts are welcomed, but they should not hide the truth: they are not significative enough to face the climate emergency, we need to focus on the big ones.',
      name: 'advicesExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Please note that this app only focuses on climate change, but we should not forget the other types of pollution (air, water, land, noise and light pollution) since they also greatly deserve our attention.`
  String get advicesOtherPolutionTypes {
    return Intl.message(
      'Please note that this app only focuses on climate change, but we should not forget the other types of pollution (air, water, land, noise and light pollution) since they also greatly deserve our attention.',
      name: 'advicesOtherPolutionTypes',
      desc: '',
      args: [],
    );
  }

  /// `Express your concerns`
  String get advicesPoliticsCategory {
    return Intl.message(
      'Express your concerns',
      name: 'advicesPoliticsCategory',
      desc: '',
      args: [],
    );
  }

  /// `Understand what is at stake >`
  String get advicesSeeClimateChange {
    return Intl.message(
      'Understand what is at stake >',
      name: 'advicesSeeClimateChange',
      desc: '',
      args: [],
    );
  }

  /// `See some solutions >`
  String get advicesSeeLinks {
    return Intl.message(
      'See some solutions >',
      name: 'advicesSeeLinks',
      desc: '',
      args: [],
    );
  }

  /// `This list is non-exhaustive and has not be sponsored, it is simply links we believe to be helpful.\nIf you have any suggestion or remark, (a mailto:warmd_app@icloud.com)please tell us(/a).`
  String get advicesLinksExplanation {
    return Intl.message(
      'This list is non-exhaustive and has not be sponsored, it is simply links we believe to be helpful.\nIf you have any suggestion or remark, (a mailto:warmd_app@icloud.com)please tell us(/a).',
      name: 'advicesLinksExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Global goals`
  String get globalObjectivesTitle {
    return Intl.message(
      'Global goals',
      name: 'globalObjectivesTitle',
      desc: '',
      args: [],
    );
  }

  /// `To stay below +2°C, greenhouse gas emissions must be (a https://folk.universitetetioslo.no/roberan/t/global_mitigation_curves.shtml)divided by 3 by 2050(/a), i.e. about (b)-6% per year(/b) starting from 2020.`
  String get globalObjectivesPart1 {
    return Intl.message(
      'To stay below +2°C, greenhouse gas emissions must be (a https://folk.universitetetioslo.no/roberan/t/global_mitigation_curves.shtml)divided by 3 by 2050(/a), i.e. about (b)-6% per year(/b) starting from 2020.',
      name: 'globalObjectivesPart1',
      desc: '',
      args: [],
    );
  }

  /// `So far, it is unlikely to happen. Until now we constantly increased our emissions and there is still no clear sign of reduction.\n\nWith the current trend and without effective efforts, we will end up with at least (b)+3.2°C by 2100(/b), and it will continue to increase thereafter.`
  String get globalObjectivesPart2 {
    return Intl.message(
      'So far, it is unlikely to happen. Until now we constantly increased our emissions and there is still no clear sign of reduction.\n\nWith the current trend and without effective efforts, we will end up with at least (b)+3.2°C by 2100(/b), and it will continue to increase thereafter.',
      name: 'globalObjectivesPart2',
      desc: '',
      args: [],
    );
  }

  /// `Where should we start?`
  String get globalActionsTitle {
    return Intl.message(
      'Where should we start?',
      name: 'globalActionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Emissions essentially come from few main sectors (source: IPCC, 2014, global emissions).`
  String get globalActionsPart1 {
    return Intl.message(
      'Emissions essentially come from few main sectors (source: IPCC, 2014, global emissions).',
      name: 'globalActionsPart1',
      desc: '',
      args: [],
    );
  }

  /// `• The first thing to do is to (b)completely stop using fossil fuels(/b) (coal, oil, gas) and replace them with low-carbon electricity ((a https://www.ipcc.ch/site/assets/uploads/2018/02/ipcc_wg3_ar5_chapter7.pdf)IPCC(/a) recommands an increased use of both nuclear and renewable energy).\n\n• Then there is a need for (b)better food management(/b), with less meat production and waste.\n\n• To finish, it could be necessary to start organizing a global degrowth and a birth rate control since it could be the only solution to reach a complete decarbonization.`
  String get globalActionsPart2 {
    return Intl.message(
      '• The first thing to do is to (b)completely stop using fossil fuels(/b) (coal, oil, gas) and replace them with low-carbon electricity ((a https://www.ipcc.ch/site/assets/uploads/2018/02/ipcc_wg3_ar5_chapter7.pdf)IPCC(/a) recommands an increased use of both nuclear and renewable energy).\n\n• Then there is a need for (b)better food management(/b), with less meat production and waste.\n\n• To finish, it could be necessary to start organizing a global degrowth and a birth rate control since it could be the only solution to reach a complete decarbonization.',
      name: 'globalActionsPart2',
      desc: '',
      args: [],
    );
  }

  /// `Warmd project`
  String get aboutProjectTitle {
    return Intl.message(
      'Warmd project',
      name: 'aboutProjectTitle',
      desc: '',
      args: [],
    );
  }

  /// `Warmd is a non-lucrative open-source project. You can contribute to it (a https://github.com/FredJul/Warmd)here(/a) or help translating it (a https://frju.crowdin.com/warmd)here(/a).\n\nWarmd's design has been generously provided by (a https://mnstudio.net)mn studio(/a).\n\nOur only goal is to reduce a bit the human impact on our planet.`
  String get aboutProjectDescription {
    return Intl.message(
      'Warmd is a non-lucrative open-source project. You can contribute to it (a https://github.com/FredJul/Warmd)here(/a) or help translating it (a https://frju.crowdin.com/warmd)here(/a).\n\nWarmd\'s design has been generously provided by (a https://mnstudio.net)mn studio(/a).\n\nOur only goal is to reduce a bit the human impact on our planet.',
      name: 'aboutProjectDescription',
      desc: '',
      args: [],
    );
  }

  /// `Help us by rating it 5 stars >`
  String get aboutRateIt {
    return Intl.message(
      'Help us by rating it 5 stars >',
      name: 'aboutRateIt',
      desc: '',
      args: [],
    );
  }

  /// `Sources`
  String get aboutSourcesTitle {
    return Intl.message(
      'Sources',
      name: 'aboutSourcesTitle',
      desc: '',
      args: [],
    );
  }

  /// `This carbon footprint calculator is mainly based on (a https://coolclimate.org)CoolClimate(/a) results, with the help of other sources like (a https://ourworldindata.org/food-choice-vs-eating-local)OurWorldInData(/a), (a https://www.bbc.com/news/science-environment-49349566)BBC(/a), (a https://www.lowcvp.org.uk/assets/workingdocuments/MC-P-11-15a%20Lifecycle%20emissions%20report.pdf)LowCVP(/a), (a https://www.frontiersin.org/articles/10.3389/fnut.2019.00126/full)Frontiers(/a), (a https://theshiftproject.org/en/article/unsustainable-use-online-video/)The Shift Project(/a) or (a https://riftapp.fr/)Rift(/a).\n\nDue to the complexity of the task, we do not expect this app to be very accurate, but it gives you an idea of your impact.\n\nI'm not affiliated with any of the mentioned organizations.`
  String get aboutSourcesDescription {
    return Intl.message(
      'This carbon footprint calculator is mainly based on (a https://coolclimate.org)CoolClimate(/a) results, with the help of other sources like (a https://ourworldindata.org/food-choice-vs-eating-local)OurWorldInData(/a), (a https://www.bbc.com/news/science-environment-49349566)BBC(/a), (a https://www.lowcvp.org.uk/assets/workingdocuments/MC-P-11-15a%20Lifecycle%20emissions%20report.pdf)LowCVP(/a), (a https://www.frontiersin.org/articles/10.3389/fnut.2019.00126/full)Frontiers(/a), (a https://theshiftproject.org/en/article/unsustainable-use-online-video/)The Shift Project(/a) or (a https://riftapp.fr/)Rift(/a).\n\nDue to the complexity of the task, we do not expect this app to be very accurate, but it gives you an idea of your impact.\n\nI\'m not affiliated with any of the mentioned organizations.',
      name: 'aboutSourcesDescription',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Translation> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'af'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'cs'),
      Locale.fromSubtags(languageCode: 'da'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el'),
      Locale.fromSubtags(languageCode: 'eo'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fi'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'he'),
      Locale.fromSubtags(languageCode: 'hu'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'no'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'sr'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Translation> load(Locale locale) => Translation.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
