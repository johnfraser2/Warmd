import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/i18n.dart';
import 'warmd_icons_icons.dart';

var _currencies = {
  "AED": {
    "en": "United Arab Emirates Dirham",
    "fr": "Dirham des Émirats arabes unis",
    "value": 3.672857,
  },
  "AFN": {
    "en": "Afghanistan Afghani",
    "fr": "Afghanistan Afghani",
    "value": 78.11786,
  },
  "ALL": {
    "en": "Albania Lek",
    "fr": "Albanie Lek",
    "value": 110.471189,
  },
  "AMD": {
    "en": "Armenia Dram",
    "fr": "Arménie Dram",
    "value": 476.485579,
  },
  "ANG": {
    "en": "Netherlands Antilles Guilder",
    "fr": "Antilles néerlandaises Florin",
    "value": 1.735003,
  },
  "AOA": {
    "en": "Angola Kwanza",
    "fr": "Angola Kwanza",
    "value": 496.7435,
  },
  "ARS": {
    "en": "Argentina Peso",
    "fr": "Argentine Peso",
    "value": 59.642893,
  },
  "AUD": {
    "en": "Australia Dollar",
    "fr": "Dollar d’Australie",
    "value": 1.4474,
  },
  "AWG": {
    "en": "Aruba Guilder",
    "fr": "Aruba Florin",
    "value": 1.801,
  },
  "AZN": {
    "en": "Azerbaijan Manat",
    "fr": "Azerbaïdjan Manat",
    "value": 1.7025,
  },
  "BAM": {
    "en": "Bosnia and Herzegovina Convertible Mark",
    "fr": "Bosnie-Herzégovine Mark convertible",
    "value": 1.753188,
  },
  "BBD": {
    "en": "Barbados Dollar",
    "fr": "Barbade Dollar",
    "value": 2.0,
  },
  "BDT": {
    "en": "Bangladesh Taka",
    "fr": "Bangladesh Taka",
    "value": 84.774813,
  },
  "BGN": {
    "en": "Bulgaria Lev",
    "fr": "Bulgarie Lev",
    "value": 1.75109,
  },
  "BHD": {
    "en": "Bahrain Dinar",
    "fr": "Bahreïn Dinar",
    "value": 0.376784,
  },
  "BIF": {
    "en": "Burundi Franc",
    "fr": "Burundi Franc",
    "value": 1866.620736,
  },
  "BMD": {
    "en": "Bermuda Dollar",
    "fr": "Bermudes Dollar",
    "value": 1.0,
  },
  "BND": {
    "en": "Brunei Darussalam Dollar",
    "fr": "Brunei Dollar",
    "value": 1.357793,
  },
  "BOB": {
    "en": "Bolivia Bolíviano",
    "fr": "Bolivie Bolíviano",
    "value": 6.914913,
  },
  "BRL": {
    "en": "Brazil Real",
    "fr": "Brésil Réal",
    "value": 3.9896,
  },
  "BSD": {
    "en": "Bahamas Dollar",
    "fr": "Bahamas Dollar",
    "value": 1.0,
  },
  "BTN": {
    "en": "Bhutan Ngultrum",
    "fr": "Bhoutan Ngultrum",
    "value": 70.769344,
  },
  "BWP": {
    "en": "Botswana Pula",
    "fr": "Pula Pula",
    "value": 10.977088,
  },
  "BYN": {
    "en": "Belarus Ruble",
    "fr": "Biélorussie Rouble",
    "value": 2.051928,
  },
  "BZD": {
    "en": "Belize Dollar",
    "fr": "Belize Dollar",
    "value": 2.015669,
  },
  "CAD": {
    "en": "Canada Dollar",
    "fr": "Dollar du Canada",
    "value": 1.315963,
  },
  "CDF": {
    "en": "Congo/Kinshasa Franc",
    "fr": "République démocratique du Congo/Kinshasa Franc",
    "value": 1654.768439,
  },
  "CHF": {
    "en": "Switzerland Franc",
    "fr": "Franc de Suisse",
    "value": 0.985544,
  },
  "CLP": {
    "en": "Chile Peso",
    "fr": "Chili Peso",
    "value": 742.4,
  },
  "CNY": {
    "en": "China Yuan Renminbi",
    "fr": "Yuan ou renminbi de Chine",
    "value": 7.0373,
  },
  "COP": {
    "en": "Colombia Peso",
    "fr": "Colombie Peso",
    "value": 3376.405081,
  },
  "CRC": {
    "en": "Costa Rica Colon",
    "fr": "Costa Rica Colon",
    "value": 582.12925,
  },
  "CUC": {
    "en": "Cuba Convertible Peso",
    "fr": "Cuba Peso convertible",
    "value": 1.0,
  },
  "CUP": {
    "en": "Cuba Peso",
    "fr": "Cuba Peso",
    "value": 25.75,
  },
  "CVE": {
    "en": "Cape Verde Escudo",
    "fr": "Cap-Vert Escudo",
    "value": 99.425,
  },
  "CZK": {
    "en": "Czech Republic Koruna",
    "fr": "République tchèque Couronne",
    "value": 22.845,
  },
  "DJF": {
    "en": "Djibouti Franc",
    "fr": "Djibouti Franc",
    "value": 178,
  },
  "DKK": {
    "en": "Denmark Krone",
    "fr": "Danemark Couronne",
    "value": 6.6915,
  },
  "DOP": {
    "en": "Dominican Republic Peso",
    "fr": "République dominicaine Peso",
    "value": 52.799492,
  },
  "DZD": {
    "en": "Algeria Dinar",
    "fr": "Algérie Dinar",
    "value": 119.448611,
  },
  "EGP": {
    "en": "Egypt Pound",
    "fr": "Égypte Livre",
    "value": 16.139691,
  },
  "ERN": {
    "en": "Eritrea Nakfa",
    "fr": "Érythrée Nakfa",
    "value": 14.999786,
  },
  "ETB": {
    "en": "Ethiopia Birr",
    "fr": "Éthiopie Birr",
    "value": 29.584601,
  },
  "EUR": {
    "en": "Euro Member Countries",
    "fr": "États membres de la zone euro",
    "value": 0.895456,
  },
  "FJD": {
    "en": "Fiji Dollar",
    "fr": "Fidji Dollar",
    "value": 2.17775,
  },
  "FKP": {
    "en": "Falkland Islands (Malvinas) Pound",
    "fr": "Îles Falkland (Malouines) Livre",
    "value": 0.773036,
  },
  "GBP": {
    "en": "United Kingdom Pound",
    "fr": "Livre du Royaume-Uni",
    "value": 0.773036,
  },
  "GEL": {
    "en": "Georgia Lari",
    "fr": "Géorgie Lari",
    "value": 2.955,
  },
  "GGP": {
    "en": "Guernsey Pound",
    "fr": "Guernesey Livre",
    "value": 0.773036,
  },
  "GHS": {
    "en": "Ghana Cedi",
    "fr": "Ghana Cédi",
    "value": 5.492364,
  },
  "GIP": {
    "en": "Gibraltar Pound",
    "fr": "Gibraltar Livre",
    "value": 0.773036,
  },
  "GMD": {
    "en": "Gambia Dalasi",
    "fr": "Gambie Dalasi",
    "value": 51.2,
  },
  "GNF": {
    "en": "Guinea Franc",
    "fr": "Guinée Franc",
    "value": 9187.999431,
  },
  "GTQ": {
    "en": "Guatemala Quetzal",
    "fr": "Guatemala Quetzal",
    "value": 7.711463,
  },
  "GYD": {
    "en": "Guyana Dollar",
    "fr": "Guyana Dollar",
    "value": 208.729203,
  },
  "HKD": {
    "en": "Hong Kong Dollar",
    "fr": "Hong Kong Dollar",
    "value": 7.83625,
  },
  "HNL": {
    "en": "Honduras Lempira",
    "fr": "Honduras Lempira",
    "value": 24.657571,
  },
  "HRK": {
    "en": "Croatia Kuna",
    "fr": "Croatie Kuna",
    "value": 6.674932,
  },
  "HTG": {
    "en": "Haiti Gourde",
    "fr": "Haïti Gourde",
    "value": 97.315244,
  },
  "HUF": {
    "en": "Hungary Forint",
    "fr": "Hongrie Forint",
    "value": 293.72,
  },
  "IDR": {
    "en": "Indonesia Rupiah",
    "fr": "Indonésie Roupie",
    "value": 13989.3,
  },
  "ILS": {
    "en": "Israel Shekel",
    "fr": "Israël Shekel",
    "value": 3.5251,
  },
  "IMP": {
    "en": "Isle of Man Pound",
    "fr": "Île de Man Livre",
    "value": 0.773036,
  },
  "INR": {
    "en": "India Rupee",
    "fr": "Roupie d’Inde",
    "value": 70.522108,
  },
  "IQD": {
    "en": "Iraq Dinar",
    "fr": "Irak Dinar",
    "value": 1189.982382,
  },
  "IRR": {
    "en": "Iran Rial",
    "fr": "Iran Rial",
    "value": 42152.890176,
  },
  "ISK": {
    "en": "Iceland Krona",
    "fr": "Islande Couronne",
    "value": 123.430007,
  },
  "JEP": {
    "en": "Jersey Pound",
    "fr": "Jersey Livre",
    "value": 0.773036,
  },
  "JMD": {
    "en": "Jamaica Dollar",
    "fr": "Jamaïque Dollar",
    "value": 138.563607,
  },
  "JOD": {
    "en": "Jordan Dinar",
    "fr": "Jordanie Dinar",
    "value": 0.7085,
  },
  "JPY": {
    "en": "Japan Yen",
    "fr": "Yen du Japon",
    "value": 108.18500741,
  },
  "KES": {
    "en": "Kenya Shilling",
    "fr": "Kenya Shilling",
    "value": 103.25,
  },
  "KGS": {
    "en": "Kyrgyzstan Som",
    "fr": "Kyrgyzstan Som",
    "value": 69.651252,
  },
  "KHR": {
    "en": "Cambodia Riel",
    "fr": "Cambodge Riel",
    "value": 4070.414306,
  },
  "KMF": {
    "en": "Comorian Franc",
    "fr": "Comores Franc",
    "value": 441.949682,
  },
  "KPW": {
    "en": "Korea (North) Won",
    "fr": "Corée (du Nord) Won",
    "value": 900,
  },
  "KRW": {
    "en": "Korea (South) Won",
    "fr": "Corée (du Sud) Won",
    "value": 1164.69997,
  },
  "KWD": {
    "en": "Kuwait Dinar",
    "fr": "Koweït Dinar",
    "value": 0.303332,
  },
  "KYD": {
    "en": "Cayman Islands Dollar",
    "fr": "Îles Caïmans Dollar",
    "value": 0.833393,
  },
  "KZT": {
    "en": "Kazakhstan Tenge",
    "fr": "Kazakhstan Tenge",
    "value": 389.714902,
  },
  "LAK": {
    "en": "Laos Kip",
    "fr": "Laos Kip",
    "value": 8839.510647,
  },
  "LBP": {
    "en": "Lebanon Pound",
    "fr": "Liban Livre",
    "value": 1511.973924,
  },
  "LKR": {
    "en": "Sri Lanka Rupee",
    "fr": "Sri Lanka Roupie",
    "value": 181.167512,
  },
  "LRD": {
    "en": "Liberia Dollar",
    "fr": "Liberia Dollar",
    "value": 211.599966,
  },
  "LSL": {
    "en": "Lesotho Loti",
    "fr": "Lesotho Loti",
    "value": 15.115906,
  },
  "LYD": {
    "en": "Libya Dinar",
    "fr": "Libye Dinar",
    "value": 1.40118,
  },
  "MAD": {
    "en": "Morocco Dirham",
    "fr": "Maroc Dirham",
    "value": 9.613342,
  },
  "MDL": {
    "en": "Moldova Leu",
    "fr": "Moldavie Leu",
    "value": 17.397445,
  },
  "MGA": {
    "en": "Madagascar Ariary",
    "fr": "Madagascar Ariary",
    "value": 3680.265781,
  },
  "MKD": {
    "en": "Macedonia Denar",
    "fr": "Macédoine Dinar",
    "value": 55.10573,
  },
  "MMK": {
    "en": "Myanmar (Burma) Kyat",
    "fr": "Myanmar (Birmanie) Kyat",
    "value": 1521.988029,
  },
  "MNT": {
    "en": "Mongolia Tughrik",
    "fr": "Mongolie Tugrik",
    "value": 2681.360024,
  },
  "MOP": {
    "en": "Macau Pataca",
    "fr": "Macao Pataca",
    "value": 8.072269,
  },
  "MRU": {
    "en": "Mauritania Ouguiya",
    "fr": "Mauritanie Ouguiya",
    "value": 37.196628,
  },
  "MUR": {
    "en": "Mauritius Rupee",
    "fr": "Maurice Roupie",
    "value": 36.229999,
  },
  "MVR": {
    "en": "Maldives (Maldive Islands) Rufiyaa",
    "fr": "Maldives Rufiyaa",
    "value": 15.45,
  },
  "MWK": {
    "en": "Malawi Kwacha",
    "fr": "Malawi Kwacha",
    "value": 733.789296,
  },
  "MXN": {
    "en": "Mexico Peso",
    "fr": "Mexique Peso",
    "value": 19.1105,
  },
  "MYR": {
    "en": "Malaysia Ringgit",
    "fr": "Ringgit de Malaisie",
    "value": 4.1655,
  },
  "MZN": {
    "en": "Mozambique Metical",
    "fr": "Mozambique Metical",
    "value": 62.875,
  },
  "NAD": {
    "en": "Namibia Dollar",
    "fr": "Namibie Dollar",
    "value": 15.115906,
  },
  "NGN": {
    "en": "Nigeria Naira",
    "fr": "Nigéria Naira",
    "value": 362,
  },
  "NIO": {
    "en": "Nicaragua Cordoba",
    "fr": "Nicaragua Cordoba",
    "value": 34.044783,
  },
  "NOK": {
    "en": "Norway Krone",
    "fr": "Norvège Couronne",
    "value": 9.0924,
  },
  "NPR": {
    "en": "Nepal Rupee",
    "fr": "Népal Roupie",
    "value": 113.230544,
  },
  "NZD": {
    "en": "New Zealand Dollar",
    "fr": "Dollar de Nouvelle-Zélande",
    "value": 1.555694,
  },
  "OMR": {
    "en": "Oman Rial",
    "fr": "Oman Rial",
    "value": 0.384776,
  },
  "PAB": {
    "en": "Panama Balboa",
    "fr": "Panama Balboa",
    "value": 1.0,
  },
  "PEN": {
    "en": "Peru Sol",
    "fr": "Pérou Sol",
    "value": 3.344957,
  },
  "PGK": {
    "en": "Papua New Guinea Kina",
    "fr": "Papouasie-Nouvelle-Guinée Kina",
    "value": 3.40421,
  },
  "PHP": {
    "en": "Philippines Peso",
    "fr": "Peso des Philippines",
    "value": 50.487585,
  },
  "PKR": {
    "en": "Pakistan Rupee",
    "fr": "Pakistan Roupie",
    "value": 154.962204,
  },
  "PLN": {
    "en": "Poland Zloty",
    "fr": "Pologne Zloty",
    "value": 3.80865,
  },
  "PYG": {
    "en": "Paraguay Guarani",
    "fr": "Paraguay Guarani",
    "value": 6440.912075,
  },
  "QAR": {
    "en": "Qatar Riyal",
    "fr": "Qatar Riyal",
    "value": 3.640952,
  },
  "RON": {
    "en": "Romania Leu",
    "fr": "Roumanie Leu",
    "value": 4.2576,
  },
  "RSD": {
    "en": "Serbia Dinar",
    "fr": "Serbie Dinar",
    "value": 105.138941,
  },
  "RUB": {
    "en": "Russia Ruble",
    "fr": "Russie Rouble",
    "value": 63.5391,
  },
  "RWF": {
    "en": "Rwanda Franc",
    "fr": "Rwanda Franc",
    "value": 917.719639,
  },
  "SAR": {
    "en": "Saudi Arabia Riyal",
    "fr": "Rial d’Arabie saoudite",
    "value": 3.750101,
  },
  "SBD": {
    "en": "Solomon Islands Dollar",
    "fr": "Salomon Dollar",
    "value": 8.254337,
  },
  "SCR": {
    "en": "Seychelles Rupee",
    "fr": "Seychelles Roupie",
    "value": 13.736072,
  },
  "SDG": {
    "en": "Sudan Pound",
    "fr": "Soudan Livre",
    "value": 45.109781,
  },
  "SEK": {
    "en": "Sweden Krona",
    "fr": "Suède Couronne",
    "value": 9.6804,
  },
  "SGD": {
    "en": "Singapore Dollar",
    "fr": "Singapour Dollar",
    "value": 1.3578,
  },
  "SHP": {
    "en": "Saint Helena Pound",
    "fr": "Sainte-Hélène Pound",
    "value": 0.773036,
  },
  "SLL": {
    "en": "Sierra Leone Leone",
    "fr": "Sierra Leone Leone",
    "value": 7438.043346,
  },
  "SOS": {
    "en": "Somalia Shilling",
    "fr": "Somalie Shilling",
    "value": 578.4538,
  },
  "SRD": {
    "en": "Suriname Dollar",
    "fr": "Suriname Dollar",
    "value": 7.458,
  },
  "STN": {
    "en": "São Tomé and Príncipe Dobra",
    "fr": "Sao Tomé-et-Principe Dobra",
    "value": 22.05,
  },
  "SVC": {
    "en": "El Salvador Colon",
    "fr": "El Salvador Colon",
    "value": 8.750762,
  },
  "SYP": {
    "en": "Syria Pound",
    "fr": "Syrie Livre",
    "value": 514.940169,
  },
  "SZL": {
    "en": "eSwatini Lilangeni",
    "fr": "Swaziland Lilangeni",
    "value": 15.139698,
  },
  "THB": {
    "en": "Thailand Baht",
    "fr": "Baht de Thaïlande",
    "value": 30.168793,
  },
  "TJS": {
    "en": "Tajikistan Somoni",
    "fr": "Tadjikistan Somoni",
    "value": 9.689714,
  },
  "TMT": {
    "en": "Turkmenistan Manat",
    "fr": "Turkménistan Manat",
    "value": 3.5,
  },
  "TND": {
    "en": "Tunisia Dinar",
    "fr": "Tunisie Dinar",
    "value": 2.8175,
  },
  "TOP": {
    "en": "Tonga Pa'anga",
    "fr": "Tonga Pa’anga",
    "value": 2.313288,
  },
  "TRY": {
    "en": "Turkey Lira",
    "fr": "Turquie Livre",
    "value": 5.7124,
  },
  "TTD": {
    "en": "Trinidad and Tobago Dollar",
    "fr": "Trinité-et-Tobago Dollar",
    "value": 6.746477,
  },
  "TVD": {
    "en": "Tuvalu Dollar",
    "fr": "Tuvalu Dollar",
    "value": 6.746477,
  },
  "TWD": {
    "en": "Taiwan New Dollar",
    "fr": "Taïwan Nouveau dollar",
    "value": 30.451,
  },
  "TZS": {
    "en": "Tanzania Shilling",
    "fr": "Tanzanie Shilling",
    "value": 2303.2,
  },
  "UAH": {
    "en": "Ukraine Hryvnia",
    "fr": "Ukraine Hryvnia",
    "value": 24.81048,
  },
  "UGX": {
    "en": "Uganda Shilling",
    "fr": "Ouganda Shilling",
    "value": 3709.978911,
  },
  "USD": {
    "en": "United States Dollar",
    "fr": "Dollar des États-Unis",
    "value": 1.0,
  },
  "UYU": {
    "en": "Uruguay Peso",
    "fr": "Uruguay Peso",
    "value": 37.445964,
  },
  "UZS": {
    "en": "Uzbekistan Som",
    "fr": "Ouzbékistan Som",
    "value": 9446.96807,
  },
  "VEF": {
    "en": "Venezuela Bolívar",
    "fr": "Venezuela Bolivar",
    "value": 248487.642241,
  },
  "VND": {
    "en": "Viet Nam Dong",
    "fr": "Viêt Nam Dong",
    "value": 23177.096571,
  },
  "VUV": {
    "en": "Vanuatu Vatu",
    "fr": "Vanuatu Vatu",
    "value": 115.0155,
  },
  "WST": {
    "en": "Samoa Tala",
    "fr": "Samoa Tala",
    "value": 2.662945,
  },
  "XAF": {
    "en": "Communauté Financière Africaine (BEAC) CFA FrancBEAC",
    "fr": "Communauté économique et monétaire de l’Afrique centrale (BEAC) Franc CFA,BEAC",
    "value": 587.380369,
  },
  "XCD": {
    "en": "East Caribbean Dollar",
    "fr": "Caraïbes orientales Dollar",
    "value": 587.380372,
  },
  "XDR": {
    "en": "International Monetary Fund (IMF) Special Drawing Rights",
    "fr": "Fonds monétaire international (FMI) Droits de tirage spéciaux",
    "value": 587.380373,
  },
  "XOF": {
    "en": "Communauté Financière Africaine (BCEAO) Franc",
    "fr": "Union économique et monétaire ouest-africaine (BCEAO) Franc",
    "value": 587.380374,
  },
  "XPF": {
    "en": "Comptoirs Français du Pacifique (CFP) Franc",
    "fr": "Collectivités françaises du Pacifique (CFP) Franc",
    "value": 587.380376,
  },
  "YER": {
    "en": "Yemen Rial",
    "fr": "Yémen Rial",
    "value": 587.380378,
  },
  "ZAR": {
    "en": "South Africa Rand",
    "fr": "Rand d’Afrique du Sud",
    "value": 587.380379,
  },
  "ZMW": {
    "en": "Zambia Kwacha",
    "fr": "Zambie Kwacha",
    "value": 587.38038,
  },
  "ZWD": {
    "en": "Zimbabwe Dollar",
    "fr": "Zimbabwe Dollar",
    "value": 587.38038,
  }
};

double _getCurrencyRate(MoneyChangeCriteria c) {
  return 1 / _currencies.entries.elementAt(c.currentValue.toInt()).value["value"];
}

String _getCurrencyCode(MoneyChangeCriteria c) {
  return _currencies.keys.elementAt(c.currentValue.toInt());
}

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

  double co2EqTonsPerYear() {
    return criterias.map((crit) => crit.co2EqTonsPerYear()).reduce((a, b) => a + b);
  }
}

class MoneyChangeCriteria extends Criteria {
  BuildContext _context;

  MoneyChangeCriteria(this._context) {
    key = "money_change";
    minValue = 0;
    maxValue = _currencies.length.toDouble() - 1;
    step = 1;
    currentValue = 145; // USD
  }

  @override
  String get title => S.of(_context).moneyChangeCriteriaTitle;

  @override
  List<String> get labels => Localizations.localeOf(_context).languageCode == "fr"
      ? _currencies.entries.map((entry) => entry.key + " - " + entry.value["fr"].toString()).toList()
      : _currencies.entries.map((entry) => entry.key + " - " + entry.value["en"].toString()).toList();

  @override
  double co2EqTonsPerYear() {
    return 0;
  }

  @override
  String advice() {
    return null;
  }
}

class UnitCriteria extends Criteria {
  BuildContext _context;

  UnitCriteria(this._context) {
    key = "unit";
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
  double co2EqTonsPerYear() {
    return 0;
  }

  @override
  String advice() {
    return null;
  }
}

class GeneralCategory extends CriteriaCategory {
  BuildContext _context;

  GeneralCategory(this._context) {
    key = "general";
    criterias = [UnitCriteria(_context), MoneyChangeCriteria(_context)];
  }

  @override
  String get title => S.of(_context).generalCategoryTitle;
}

class PeopleCriteria extends Criteria {
  BuildContext _context;

  PeopleCriteria(this._context) {
    key = "people";
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
  double co2EqTonsPerYear() {
    return 0;
  }

  @override
  String advice() {
    return null;
  }
}

class HeatingFuelCriteria extends Criteria {
  BuildContext _context;
  PeopleCriteria _peopleCriteria;
  MoneyChangeCriteria _moneyChangeCriteria;

  HeatingFuelCriteria(this._context, this._peopleCriteria, this._moneyChangeCriteria) {
    key = "heating_fuel";
    minValue = 0;
    step = 100;
    currentValue = 0;
    leftIcon = WarmdIcons.piggy_bank;
    rightIcon = WarmdIcons.radiator;
  }

  @override
  String get title => S.of(_context).heatingFuelCriteriaTitle;

  @override
  String get explanation => S.of(_context).heatingFuelCriteriaExplanation(_getCurrencyCode(_moneyChangeCriteria));

  @override
  double get maxValue => (((5000 / _getCurrencyRate(_moneyChangeCriteria)) / step).truncate() * step).toDouble();

  @override
  double get currentValue => min(maxValue, super.currentValue);

  @override
  String get unit => _getCurrencyCode(_moneyChangeCriteria);

  @override
  double co2EqTonsPerYear() {
    var peopleNumber = _peopleCriteria.currentValue;
    var peopleFactor = peopleNumber > 1 ? peopleNumber / 1.3 : 1;

    var moneyChange = _getCurrencyRate(_moneyChangeCriteria);

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
  BuildContext _context;
  PeopleCriteria _peopleCriteria;
  MoneyChangeCriteria _moneyChangeCriteria;
  CleanElectricityCriteria _cleanElectricityCriteria;

  ElectricityBillCriteria(this._context, this._peopleCriteria, this._moneyChangeCriteria, this._cleanElectricityCriteria) {
    key = "electricity_bill";
    minValue = 0;
    step = 100;
    currentValue = 1000;
    leftIcon = WarmdIcons.coin_outline;
    rightIcon = WarmdIcons.cash_multiple;
  }

  @override
  String get title => S.of(_context).electricityBillCriteriaTitle;

  @override
  String get explanation => S.of(_context).electricityBillCriteriaExplanation(_getCurrencyCode(_moneyChangeCriteria));

  @override
  double get maxValue => (((5000 / _getCurrencyRate(_moneyChangeCriteria)) / step).truncate() * step).toDouble();

  @override
  double get currentValue => min(maxValue, super.currentValue);

  @override
  String get unit => _getCurrencyCode(_moneyChangeCriteria);

  @override
  double co2EqTonsPerYear() {
    var peopleNumber = _peopleCriteria.currentValue;
    var peopleFactor = peopleNumber > 1 ? peopleNumber / 1.3 : 1;

    var moneyChange = _getCurrencyRate(_moneyChangeCriteria);

    var electricityBill = currentValue * moneyChange;
    var co2ElectricityPercent = min(100, 100 - _cleanElectricityCriteria.currentValue + 15); // +15% because nothing is 100% clean
    var kWhPrice = 0.15; // in dollars
    var co2TonsPerKWh = 0.00065;

    return ((electricityBill / 100 * co2ElectricityPercent) / kWhPrice * co2TonsPerKWh) / peopleFactor;
  }

  @override
  String advice() {
    return null;
  }
}

class CleanElectricityCriteria extends Criteria {
  BuildContext _context;

  CleanElectricityCriteria(this._context) {
    key = "clean_electricity";
    minValue = 0;
    maxValue = 100;
    step = 5;
    currentValue = 10;
    unit = "%";
    leftIcon = WarmdIcons.fuel;
    rightIcon = WarmdIcons.wind_turbine;
  }

  @override
  String get title => S.of(_context).cleanElectricityCriteriaTitle;

  @override
  String get explanation => S.of(_context).cleanElectricityCriteriaExplanation;

  @override
  double co2EqTonsPerYear() {
    return 0;
  }

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
  BuildContext _context;

  WaterCriteria(this._context) {
    key = "water";
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
  BuildContext _context;

  HomeCategory(this._context, MoneyChangeCriteria moneyChangeCriteria) {
    key = "home";

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
  BuildContext _context;
  UnitCriteria _unitCriteria;

  FlightsCriteria(this._context, this._unitCriteria) {
    key = "flights";
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
  String get unit => _unitCriteria.currentValue == 0 ? "km" : "miles";

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
  BuildContext _context;
  PeopleCriteria _peopleCriteria;
  CarConsumptionCriteria _carConsumptionCriteria;
  UnitCriteria _unitCriteria;

  CarCriteria(this._context, this._peopleCriteria, this._carConsumptionCriteria, this._unitCriteria) {
    key = "car";
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
  String get unit => _unitCriteria.currentValue == 0 ? "km" : "miles";

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
  BuildContext _context;
  UnitCriteria _unitCriteria;

  CarConsumptionCriteria(this._context, this._unitCriteria) {
    key = "car_consumption";
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
  String get unit => _unitCriteria.currentValue == 0 ? "L/100km" : "mpg";

  @override
  double co2EqTonsPerYear() {
    return 0;
  }

  @override
  String advice() {
    return null;
  }
}

class PublicTransportCriteria extends Criteria {
  BuildContext _context;
  UnitCriteria _unitCriteria;

  PublicTransportCriteria(this._context, this._unitCriteria) {
    key = "public_transport";
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
  String get unit => _unitCriteria.currentValue == 0 ? "km" : "miles";

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
  BuildContext _context;

  TravelCategory(this._context, PeopleCriteria peopleCriteria, UnitCriteria unitCriteria) {
    key = "travel";

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
  BuildContext _context;

  MeatCriteria(this._context) {
    key = "meat";
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
  BuildContext _context;

  DairyCriteria(this._context) {
    key = "dairy";
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
  String advice() {
    return null; // I can't advice to eat less
  }
}

class SnackCriteria extends Criteria {
  BuildContext _context;

  SnackCriteria(this._context) {
    key = "snack";
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
  BuildContext _context;

  OverweightCriteria(this._context) {
    key = "overweight";
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
  double co2EqTonsPerYear() {
    return 0;
  }

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
  BuildContext _context;

  FoodCategory(this._context) {
    key = "food";
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
  BuildContext _context;
  MoneyChangeCriteria _moneyChangeCriteria;

  MaterialGoodsCriteria(this._context, this._moneyChangeCriteria) {
    key = "material_goods";
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
  double get maxValue => (((3000 / _getCurrencyRate(_moneyChangeCriteria)) / step).truncate() * step).toDouble();

  @override
  double get currentValue => min(maxValue, super.currentValue);

  @override
  String get unit => _getCurrencyCode(_moneyChangeCriteria);

  @override
  double co2EqTonsPerYear() {
    var moneyChange = _getCurrencyRate(_moneyChangeCriteria);
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
  BuildContext _context;

  InternetCriteria(this._context) {
    key = "internet";
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
  double co2EqTonsPerYear() {
    return 0.1 + currentValue * 0.25; // Based on Carbonalyser extension's results
  }

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
  BuildContext _context;

  GoodsCategory(this._context, MoneyChangeCriteria moneyChangeCriteria) {
    key = "goods";
    criterias = [
      MaterialGoodsCriteria(_context, moneyChangeCriteria),
      InternetCriteria(_context),
    ];
  }

  @override
  String get title => S.of(_context).goodsAndServicesCategoryTitle;
}

class VoteCriteria extends Criteria {
  BuildContext _context;

  VoteCriteria(this._context) {
    key = "vote";
    minValue = 0;
    maxValue = 2;
    step = 1;
    currentValue = 1;
  }

  @override
  String get title => S.of(_context).voteCriteriaTitle;

  @override
  String get explanation => S.of(_context).voteCriteriaExplanation;

  @override
  List<String> get labels => [
        S.of(_context).voteCriteriaLabel3,
        S.of(_context).voteCriteriaLabel2,
        S.of(_context).voteCriteriaLabel1,
      ];

  @override
  double co2EqTonsPerYear() {
    return currentValue == 2 ? 20 : currentValue == 1 ? 10 : 0;
  }

  @override
  String advice() {
    return null;
  }
}

class PublicOpinionCriteria extends Criteria {
  BuildContext _context;

  PublicOpinionCriteria(this._context) {
    key = "public_opinion";
    minValue = 0;
    maxValue = 2;
    step = 1;
    currentValue = 0;
  }

  @override
  String get title => S.of(_context).publicOpinionCriteriaTitle;

  @override
  String get explanation => S.of(_context).publicOpinionCriteriaExplanation;

  @override
  List<String> get labels => [
        S.of(_context).publicOpinionCriteriaLabel3,
        S.of(_context).publicOpinionCriteriaLabel2,
        S.of(_context).publicOpinionCriteriaLabel1,
      ];

  @override
  double co2EqTonsPerYear() {
    return currentValue == 2 ? 15 : currentValue == 1 ? 7 : 0;
  }

  @override
  String advice() {
    return null;
  }
}

class PoliticalCategory extends CriteriaCategory {
  BuildContext _context;

  PoliticalCategory(this._context) {
    key = "political";
    criterias = [VoteCriteria(_context), PublicOpinionCriteria(_context)];
  }

  @override
  String get title => S.of(_context).politicalCategoryTitle;
}

class ChildrenCriteria extends Criteria {
  BuildContext _context;

  ChildrenCriteria(this._context) {
    key = "children";
    minValue = 0;
    maxValue = 5;
    step = 1;
    currentValue = 2;
    leftIcon = WarmdIcons.human_male;
    rightIcon = WarmdIcons.human_male_girl;
  }

  @override
  String get title => S.of(_context).childrenCriteriaTitle;

  @override
  String get explanation => S.of(_context).childrenCriteriaExplanation;

  @override
  double co2EqTonsPerYear() {
    return 15 / maxValue * currentValue;
  }

  @override
  String advice() {
    return null;
  }
}

class ChildrenCategory extends CriteriaCategory {
  BuildContext _context;

  ChildrenCategory(this._context) {
    key = "children";
    criterias = [ChildrenCriteria(_context)];
  }

  @override
  String get title => S.of(_context).childrenCategoryTitle;
}

abstract class CriteriaCategorySet {
  List<CriteriaCategory> categories;

  double co2EqTonsPerYear() {
    return categories.map((cat) => cat.co2EqTonsPerYear()).reduce((a, b) => a + b);
  }
}

class IndividualCategorySet extends CriteriaCategorySet {
  IndividualCategorySet(BuildContext context) {
    var generalCategory = GeneralCategory(context);
    var homeCategory = HomeCategory(context, generalCategory.criterias[1]);

    categories = [
      generalCategory,
      homeCategory,
      TravelCategory(context, homeCategory.criterias[0], generalCategory.criterias[0]),
      FoodCategory(context),
      GoodsCategory(context, generalCategory.criterias[1])
    ];
  }
}

class GlobalCategorySet extends CriteriaCategorySet {
  GlobalCategorySet(BuildContext context) {
    categories = [PoliticalCategory(context), ChildrenCategory(context)];
  }
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
    categorySet = IndividualCategorySet(context);
  }

  void persist(Criteria c) {
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble(c.key, c.currentValue);
    });
  }

  Future _loadFromPersistence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

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
