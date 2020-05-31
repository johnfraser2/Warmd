const currencies = {
  'AED': {
    'en': 'United Arab Emirates Dirham',
    'fr': 'Dirham des Émirats arabes unis',
    'value': 3.672857,
  },
  'AFN': {
    'en': 'Afghanistan Afghani',
    'fr': 'Afghanistan Afghani',
    'value': 78.11786,
  },
  'ALL': {
    'en': 'Albania Lek',
    'fr': 'Albanie Lek',
    'value': 110.471189,
  },
  'AMD': {
    'en': 'Armenia Dram',
    'fr': 'Arménie Dram',
    'value': 476.485579,
  },
  'ANG': {
    'en': 'Netherlands Antilles Guilder',
    'fr': 'Antilles néerlandaises Florin',
    'value': 1.735003,
  },
  'AOA': {
    'en': 'Angola Kwanza',
    'fr': 'Angola Kwanza',
    'value': 496.7435,
  },
  'ARS': {
    'en': 'Argentina Peso',
    'fr': 'Argentine Peso',
    'value': 59.642893,
  },
  'AUD': {
    'en': 'Australia Dollar',
    'fr': 'Dollar d’Australie',
    'value': 1.4474,
  },
  'AWG': {
    'en': 'Aruba Guilder',
    'fr': 'Aruba Florin',
    'value': 1.801,
  },
  'AZN': {
    'en': 'Azerbaijan Manat',
    'fr': 'Azerbaïdjan Manat',
    'value': 1.7025,
  },
  'BAM': {
    'en': 'Bosnia and Herzegovina Convertible Mark',
    'fr': 'Bosnie-Herzégovine Mark convertible',
    'value': 1.753188,
  },
  'BBD': {
    'en': 'Barbados Dollar',
    'fr': 'Barbade Dollar',
    'value': 2.0,
  },
  'BDT': {
    'en': 'Bangladesh Taka',
    'fr': 'Bangladesh Taka',
    'value': 84.774813,
  },
  'BGN': {
    'en': 'Bulgaria Lev',
    'fr': 'Bulgarie Lev',
    'value': 1.75109,
  },
  'BHD': {
    'en': 'Bahrain Dinar',
    'fr': 'Bahreïn Dinar',
    'value': 0.376784,
  },
  'BIF': {
    'en': 'Burundi Franc',
    'fr': 'Burundi Franc',
    'value': 1866.620736,
  },
  'BMD': {
    'en': 'Bermuda Dollar',
    'fr': 'Bermudes Dollar',
    'value': 1.0,
  },
  'BND': {
    'en': 'Brunei Darussalam Dollar',
    'fr': 'Brunei Dollar',
    'value': 1.357793,
  },
  'BOB': {
    'en': 'Bolivia Bolíviano',
    'fr': 'Bolivie Bolíviano',
    'value': 6.914913,
  },
  'BRL': {
    'en': 'Brazil Real',
    'fr': 'Brésil Réal',
    'value': 3.9896,
  },
  'BSD': {
    'en': 'Bahamas Dollar',
    'fr': 'Bahamas Dollar',
    'value': 1.0,
  },
  'BTN': {
    'en': 'Bhutan Ngultrum',
    'fr': 'Bhoutan Ngultrum',
    'value': 70.769344,
  },
  'BWP': {
    'en': 'Botswana Pula',
    'fr': 'Pula Pula',
    'value': 10.977088,
  },
  'BYN': {
    'en': 'Belarus Ruble',
    'fr': 'Biélorussie Rouble',
    'value': 2.051928,
  },
  'BZD': {
    'en': 'Belize Dollar',
    'fr': 'Belize Dollar',
    'value': 2.015669,
  },
  'CAD': {
    'en': 'Canada Dollar',
    'fr': 'Dollar du Canada',
    'value': 1.315963,
  },
  'CDF': {
    'en': 'Congo/Kinshasa Franc',
    'fr': 'République démocratique du Congo/Kinshasa Franc',
    'value': 1654.768439,
  },
  'CHF': {
    'en': 'Switzerland Franc',
    'fr': 'Franc de Suisse',
    'value': 0.985544,
  },
  'CLP': {
    'en': 'Chile Peso',
    'fr': 'Chili Peso',
    'value': 742.4,
  },
  'CNY': {
    'en': 'China Yuan Renminbi',
    'fr': 'Yuan ou renminbi de Chine',
    'value': 7.0373,
  },
  'COP': {
    'en': 'Colombia Peso',
    'fr': 'Colombie Peso',
    'value': 3376.405081,
  },
  'CRC': {
    'en': 'Costa Rica Colon',
    'fr': 'Costa Rica Colon',
    'value': 582.12925,
  },
  'CUC': {
    'en': 'Cuba Convertible Peso',
    'fr': 'Cuba Peso convertible',
    'value': 1.0,
  },
  'CUP': {
    'en': 'Cuba Peso',
    'fr': 'Cuba Peso',
    'value': 25.75,
  },
  'CVE': {
    'en': 'Cape Verde Escudo',
    'fr': 'Cap-Vert Escudo',
    'value': 99.425,
  },
  'CZK': {
    'en': 'Czech Republic Koruna',
    'fr': 'République tchèque Couronne',
    'value': 22.845,
  },
  'DJF': {
    'en': 'Djibouti Franc',
    'fr': 'Djibouti Franc',
    'value': 178,
  },
  'DKK': {
    'en': 'Denmark Krone',
    'fr': 'Danemark Couronne',
    'value': 6.6915,
  },
  'DOP': {
    'en': 'Dominican Republic Peso',
    'fr': 'République dominicaine Peso',
    'value': 52.799492,
  },
  'DZD': {
    'en': 'Algeria Dinar',
    'fr': 'Algérie Dinar',
    'value': 119.448611,
  },
  'EGP': {
    'en': 'Egypt Pound',
    'fr': 'Égypte Livre',
    'value': 16.139691,
  },
  'ERN': {
    'en': 'Eritrea Nakfa',
    'fr': 'Érythrée Nakfa',
    'value': 14.999786,
  },
  'ETB': {
    'en': 'Ethiopia Birr',
    'fr': 'Éthiopie Birr',
    'value': 29.584601,
  },
  'EUR': {
    'en': 'Euro Member Countries',
    'fr': 'États membres de la zone euro',
    'value': 0.895456,
  },
  'FJD': {
    'en': 'Fiji Dollar',
    'fr': 'Fidji Dollar',
    'value': 2.17775,
  },
  'FKP': {
    'en': 'Falkland Islands (Malvinas) Pound',
    'fr': 'Îles Falkland (Malouines) Livre',
    'value': 0.773036,
  },
  'GBP': {
    'en': 'United Kingdom Pound',
    'fr': 'Livre du Royaume-Uni',
    'value': 0.773036,
  },
  'GEL': {
    'en': 'Georgia Lari',
    'fr': 'Géorgie Lari',
    'value': 2.955,
  },
  'GGP': {
    'en': 'Guernsey Pound',
    'fr': 'Guernesey Livre',
    'value': 0.773036,
  },
  'GHS': {
    'en': 'Ghana Cedi',
    'fr': 'Ghana Cédi',
    'value': 5.492364,
  },
  'GIP': {
    'en': 'Gibraltar Pound',
    'fr': 'Gibraltar Livre',
    'value': 0.773036,
  },
  'GMD': {
    'en': 'Gambia Dalasi',
    'fr': 'Gambie Dalasi',
    'value': 51.2,
  },
  'GNF': {
    'en': 'Guinea Franc',
    'fr': 'Guinée Franc',
    'value': 9187.999431,
  },
  'GTQ': {
    'en': 'Guatemala Quetzal',
    'fr': 'Guatemala Quetzal',
    'value': 7.711463,
  },
  'GYD': {
    'en': 'Guyana Dollar',
    'fr': 'Guyana Dollar',
    'value': 208.729203,
  },
  'HKD': {
    'en': 'Hong Kong Dollar',
    'fr': 'Hong Kong Dollar',
    'value': 7.83625,
  },
  'HNL': {
    'en': 'Honduras Lempira',
    'fr': 'Honduras Lempira',
    'value': 24.657571,
  },
  'HRK': {
    'en': 'Croatia Kuna',
    'fr': 'Croatie Kuna',
    'value': 6.674932,
  },
  'HTG': {
    'en': 'Haiti Gourde',
    'fr': 'Haïti Gourde',
    'value': 97.315244,
  },
  'HUF': {
    'en': 'Hungary Forint',
    'fr': 'Hongrie Forint',
    'value': 293.72,
  },
  'IDR': {
    'en': 'Indonesia Rupiah',
    'fr': 'Indonésie Roupie',
    'value': 13989.3,
  },
  'ILS': {
    'en': 'Israel Shekel',
    'fr': 'Israël Shekel',
    'value': 3.5251,
  },
  'IMP': {
    'en': 'Isle of Man Pound',
    'fr': 'Île de Man Livre',
    'value': 0.773036,
  },
  'INR': {
    'en': 'India Rupee',
    'fr': 'Roupie d’Inde',
    'value': 70.522108,
  },
  'IQD': {
    'en': 'Iraq Dinar',
    'fr': 'Irak Dinar',
    'value': 1189.982382,
  },
  'IRR': {
    'en': 'Iran Rial',
    'fr': 'Iran Rial',
    'value': 42152.890176,
  },
  'ISK': {
    'en': 'Iceland Krona',
    'fr': 'Islande Couronne',
    'value': 123.430007,
  },
  'JEP': {
    'en': 'Jersey Pound',
    'fr': 'Jersey Livre',
    'value': 0.773036,
  },
  'JMD': {
    'en': 'Jamaica Dollar',
    'fr': 'Jamaïque Dollar',
    'value': 138.563607,
  },
  'JOD': {
    'en': 'Jordan Dinar',
    'fr': 'Jordanie Dinar',
    'value': 0.7085,
  },
  'JPY': {
    'en': 'Japan Yen',
    'fr': 'Yen du Japon',
    'value': 108.18500741,
  },
  'KES': {
    'en': 'Kenya Shilling',
    'fr': 'Kenya Shilling',
    'value': 103.25,
  },
  'KGS': {
    'en': 'Kyrgyzstan Som',
    'fr': 'Kyrgyzstan Som',
    'value': 69.651252,
  },
  'KHR': {
    'en': 'Cambodia Riel',
    'fr': 'Cambodge Riel',
    'value': 4070.414306,
  },
  'KMF': {
    'en': 'Comorian Franc',
    'fr': 'Comores Franc',
    'value': 441.949682,
  },
  'KPW': {
    'en': 'Korea (North) Won',
    'fr': 'Corée (du Nord) Won',
    'value': 900,
  },
  'KRW': {
    'en': 'Korea (South) Won',
    'fr': 'Corée (du Sud) Won',
    'value': 1164.69997,
  },
  'KWD': {
    'en': 'Kuwait Dinar',
    'fr': 'Koweït Dinar',
    'value': 0.303332,
  },
  'KYD': {
    'en': 'Cayman Islands Dollar',
    'fr': 'Îles Caïmans Dollar',
    'value': 0.833393,
  },
  'KZT': {
    'en': 'Kazakhstan Tenge',
    'fr': 'Kazakhstan Tenge',
    'value': 389.714902,
  },
  'LAK': {
    'en': 'Laos Kip',
    'fr': 'Laos Kip',
    'value': 8839.510647,
  },
  'LBP': {
    'en': 'Lebanon Pound',
    'fr': 'Liban Livre',
    'value': 1511.973924,
  },
  'LKR': {
    'en': 'Sri Lanka Rupee',
    'fr': 'Sri Lanka Roupie',
    'value': 181.167512,
  },
  'LRD': {
    'en': 'Liberia Dollar',
    'fr': 'Liberia Dollar',
    'value': 211.599966,
  },
  'LSL': {
    'en': 'Lesotho Loti',
    'fr': 'Lesotho Loti',
    'value': 15.115906,
  },
  'LYD': {
    'en': 'Libya Dinar',
    'fr': 'Libye Dinar',
    'value': 1.40118,
  },
  'MAD': {
    'en': 'Morocco Dirham',
    'fr': 'Maroc Dirham',
    'value': 9.613342,
  },
  'MDL': {
    'en': 'Moldova Leu',
    'fr': 'Moldavie Leu',
    'value': 17.397445,
  },
  'MGA': {
    'en': 'Madagascar Ariary',
    'fr': 'Madagascar Ariary',
    'value': 3680.265781,
  },
  'MKD': {
    'en': 'Macedonia Denar',
    'fr': 'Macédoine Dinar',
    'value': 55.10573,
  },
  'MMK': {
    'en': 'Myanmar (Burma) Kyat',
    'fr': 'Myanmar (Birmanie) Kyat',
    'value': 1521.988029,
  },
  'MNT': {
    'en': 'Mongolia Tughrik',
    'fr': 'Mongolie Tugrik',
    'value': 2681.360024,
  },
  'MOP': {
    'en': 'Macau Pataca',
    'fr': 'Macao Pataca',
    'value': 8.072269,
  },
  'MRU': {
    'en': 'Mauritania Ouguiya',
    'fr': 'Mauritanie Ouguiya',
    'value': 37.196628,
  },
  'MUR': {
    'en': 'Mauritius Rupee',
    'fr': 'Maurice Roupie',
    'value': 36.229999,
  },
  'MVR': {
    'en': 'Maldives (Maldive Islands) Rufiyaa',
    'fr': 'Maldives Rufiyaa',
    'value': 15.45,
  },
  'MWK': {
    'en': 'Malawi Kwacha',
    'fr': 'Malawi Kwacha',
    'value': 733.789296,
  },
  'MXN': {
    'en': 'Mexico Peso',
    'fr': 'Mexique Peso',
    'value': 19.1105,
  },
  'MYR': {
    'en': 'Malaysia Ringgit',
    'fr': 'Ringgit de Malaisie',
    'value': 4.1655,
  },
  'MZN': {
    'en': 'Mozambique Metical',
    'fr': 'Mozambique Metical',
    'value': 62.875,
  },
  'NAD': {
    'en': 'Namibia Dollar',
    'fr': 'Namibie Dollar',
    'value': 15.115906,
  },
  'NGN': {
    'en': 'Nigeria Naira',
    'fr': 'Nigéria Naira',
    'value': 362,
  },
  'NIO': {
    'en': 'Nicaragua Cordoba',
    'fr': 'Nicaragua Cordoba',
    'value': 34.044783,
  },
  'NOK': {
    'en': 'Norway Krone',
    'fr': 'Norvège Couronne',
    'value': 9.0924,
  },
  'NPR': {
    'en': 'Nepal Rupee',
    'fr': 'Népal Roupie',
    'value': 113.230544,
  },
  'NZD': {
    'en': 'New Zealand Dollar',
    'fr': 'Dollar de Nouvelle-Zélande',
    'value': 1.555694,
  },
  'OMR': {
    'en': 'Oman Rial',
    'fr': 'Oman Rial',
    'value': 0.384776,
  },
  'PAB': {
    'en': 'Panama Balboa',
    'fr': 'Panama Balboa',
    'value': 1.0,
  },
  'PEN': {
    'en': 'Peru Sol',
    'fr': 'Pérou Sol',
    'value': 3.344957,
  },
  'PGK': {
    'en': 'Papua New Guinea Kina',
    'fr': 'Papouasie-Nouvelle-Guinée Kina',
    'value': 3.40421,
  },
  'PHP': {
    'en': 'Philippines Peso',
    'fr': 'Peso des Philippines',
    'value': 50.487585,
  },
  'PKR': {
    'en': 'Pakistan Rupee',
    'fr': 'Pakistan Roupie',
    'value': 154.962204,
  },
  'PLN': {
    'en': 'Poland Zloty',
    'fr': 'Pologne Zloty',
    'value': 3.80865,
  },
  'PYG': {
    'en': 'Paraguay Guarani',
    'fr': 'Paraguay Guarani',
    'value': 6440.912075,
  },
  'QAR': {
    'en': 'Qatar Riyal',
    'fr': 'Qatar Riyal',
    'value': 3.640952,
  },
  'RON': {
    'en': 'Romania Leu',
    'fr': 'Roumanie Leu',
    'value': 4.2576,
  },
  'RSD': {
    'en': 'Serbia Dinar',
    'fr': 'Serbie Dinar',
    'value': 105.138941,
  },
  'RUB': {
    'en': 'Russia Ruble',
    'fr': 'Russie Rouble',
    'value': 63.5391,
  },
  'RWF': {
    'en': 'Rwanda Franc',
    'fr': 'Rwanda Franc',
    'value': 917.719639,
  },
  'SAR': {
    'en': 'Saudi Arabia Riyal',
    'fr': 'Rial d’Arabie saoudite',
    'value': 3.750101,
  },
  'SBD': {
    'en': 'Solomon Islands Dollar',
    'fr': 'Salomon Dollar',
    'value': 8.254337,
  },
  'SCR': {
    'en': 'Seychelles Rupee',
    'fr': 'Seychelles Roupie',
    'value': 13.736072,
  },
  'SDG': {
    'en': 'Sudan Pound',
    'fr': 'Soudan Livre',
    'value': 45.109781,
  },
  'SEK': {
    'en': 'Sweden Krona',
    'fr': 'Suède Couronne',
    'value': 9.6804,
  },
  'SGD': {
    'en': 'Singapore Dollar',
    'fr': 'Singapour Dollar',
    'value': 1.3578,
  },
  'SHP': {
    'en': 'Saint Helena Pound',
    'fr': 'Sainte-Hélène Pound',
    'value': 0.773036,
  },
  'SLL': {
    'en': 'Sierra Leone Leone',
    'fr': 'Sierra Leone Leone',
    'value': 7438.043346,
  },
  'SOS': {
    'en': 'Somalia Shilling',
    'fr': 'Somalie Shilling',
    'value': 578.4538,
  },
  'SRD': {
    'en': 'Suriname Dollar',
    'fr': 'Suriname Dollar',
    'value': 7.458,
  },
  'STN': {
    'en': 'São Tomé and Príncipe Dobra',
    'fr': 'Sao Tomé-et-Principe Dobra',
    'value': 22.05,
  },
  'SVC': {
    'en': 'El Salvador Colon',
    'fr': 'El Salvador Colon',
    'value': 8.750762,
  },
  'SYP': {
    'en': 'Syria Pound',
    'fr': 'Syrie Livre',
    'value': 514.940169,
  },
  'SZL': {
    'en': 'eSwatini Lilangeni',
    'fr': 'Swaziland Lilangeni',
    'value': 15.139698,
  },
  'THB': {
    'en': 'Thailand Baht',
    'fr': 'Baht de Thaïlande',
    'value': 30.168793,
  },
  'TJS': {
    'en': 'Tajikistan Somoni',
    'fr': 'Tadjikistan Somoni',
    'value': 9.689714,
  },
  'TMT': {
    'en': 'Turkmenistan Manat',
    'fr': 'Turkménistan Manat',
    'value': 3.5,
  },
  'TND': {
    'en': 'Tunisia Dinar',
    'fr': 'Tunisie Dinar',
    'value': 2.8175,
  },
  'TOP': {
    'en': "Tonga Pa'anga",
    'fr': 'Tonga Pa’anga',
    'value': 2.313288,
  },
  'TRY': {
    'en': 'Turkey Lira',
    'fr': 'Turquie Livre',
    'value': 5.7124,
  },
  'TTD': {
    'en': 'Trinidad and Tobago Dollar',
    'fr': 'Trinité-et-Tobago Dollar',
    'value': 6.746477,
  },
  'TVD': {
    'en': 'Tuvalu Dollar',
    'fr': 'Tuvalu Dollar',
    'value': 6.746477,
  },
  'TWD': {
    'en': 'Taiwan New Dollar',
    'fr': 'Taïwan Nouveau dollar',
    'value': 30.451,
  },
  'TZS': {
    'en': 'Tanzania Shilling',
    'fr': 'Tanzanie Shilling',
    'value': 2303.2,
  },
  'UAH': {
    'en': 'Ukraine Hryvnia',
    'fr': 'Ukraine Hryvnia',
    'value': 24.81048,
  },
  'UGX': {
    'en': 'Uganda Shilling',
    'fr': 'Ouganda Shilling',
    'value': 3709.978911,
  },
  'USD': {
    'en': 'United States Dollar',
    'fr': 'Dollar des États-Unis',
    'value': 1.0,
  },
  'UYU': {
    'en': 'Uruguay Peso',
    'fr': 'Uruguay Peso',
    'value': 37.445964,
  },
  'UZS': {
    'en': 'Uzbekistan Som',
    'fr': 'Ouzbékistan Som',
    'value': 9446.96807,
  },
  'VEF': {
    'en': 'Venezuela Bolívar',
    'fr': 'Venezuela Bolivar',
    'value': 248487.642241,
  },
  'VND': {
    'en': 'Viet Nam Dong',
    'fr': 'Viêt Nam Dong',
    'value': 23177.096571,
  },
  'VUV': {
    'en': 'Vanuatu Vatu',
    'fr': 'Vanuatu Vatu',
    'value': 115.0155,
  },
  'WST': {
    'en': 'Samoa Tala',
    'fr': 'Samoa Tala',
    'value': 2.662945,
  },
  'XAF': {
    'en': 'Communauté Financière Africaine (BEAC) CFA FrancBEAC',
    'fr': 'Communauté économique et monétaire de l’Afrique centrale (BEAC) Franc CFA,BEAC',
    'value': 587.380369,
  },
  'XCD': {
    'en': 'East Caribbean Dollar',
    'fr': 'Caraïbes orientales Dollar',
    'value': 587.380372,
  },
  'XDR': {
    'en': 'International Monetary Fund (IMF) Special Drawing Rights',
    'fr': 'Fonds monétaire international (FMI) Droits de tirage spéciaux',
    'value': 587.380373,
  },
  'XOF': {
    'en': 'Communauté Financière Africaine (BCEAO) Franc',
    'fr': 'Union économique et monétaire ouest-africaine (BCEAO) Franc',
    'value': 587.380374,
  },
  'XPF': {
    'en': 'Comptoirs Français du Pacifique (CFP) Franc',
    'fr': 'Collectivités françaises du Pacifique (CFP) Franc',
    'value': 587.380376,
  },
  'YER': {
    'en': 'Yemen Rial',
    'fr': 'Yémen Rial',
    'value': 587.380378,
  },
  'ZAR': {
    'en': 'South Africa Rand',
    'fr': 'Rand d’Afrique du Sud',
    'value': 587.380379,
  },
  'ZMW': {
    'en': 'Zambia Kwacha',
    'fr': 'Zambie Kwacha',
    'value': 587.38038,
  },
  'ZWD': {
    'en': 'Zimbabwe Dollar',
    'fr': 'Zimbabwe Dollar',
    'value': 587.38038,
  }
};
