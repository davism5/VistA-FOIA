XMUDTOP ;ISC-SF/GMB-Top-Level Domain Names ;04/17/2002  11:48
 ;;8.0;MailMan;;Jun 28, 2002
 Q
ENTRY ; Populate file 4.2996 with the proper, recognized top-level domains.
 D DELALL
 D ADD
 Q
DELALL ; Delete all entries.
 N DIK,DA
 S DIK="^DIC(4.2996,"
 S DA=0
 F  S DA=$O(^DIC(4.2996,DA)) Q:'DA  D ^DIK
 K ^DIC(4.2996,"B")
 Q
ADD ; Add entries
 N I,XMFDA,XMIEN,XMREC
 F I=1:1 S X=$T(T+I) Q:X=" ;;"  D
 . S XMREC=$E(X,4,255)
 . S XMIENS="?+1,"
 . S XMFDA(4.2996,XMIENS,.01)=$P(XMREC,U,1)
 . S XMFDA(4.2996,XMIENS,1)=$P(XMREC,U,2)
 . D UPDATE^DIE("","XMFDA")
 . I $D(DIERR) W !,"ERROR=",XMREC
 Q
T ;
 ;;AERO^AIR TRANSPORT INDUSTRY
 ;;BIZ^BUSINESS
 ;;COM^COMMERCIAL
 ;;COOP^NON-PROFIT COOPERATIVE
 ;;EDU^EDUCATIONAL
 ;;GOV^US GOVERNMENT
 ;;INFO^GENERAL USE
 ;;INT^INTERNATIONAL ORGANIZATION
 ;;MIL^US MILITARY
 ;;MUSEUM^ACCREDITED MUSEUM
 ;;NAME^INDIVIDUALS
 ;;NET^NETWORK PROVIDER
 ;;ORG^NON-PROFIT ORGANIZATION
 ;;PRO^PROFESSIONAL
 ;;AC^ASCENSION ISLAND
 ;;AD^ANDORRA
 ;;AE^UNITED ARAB EMIRATES
 ;;AF^AFGHANISTAN
 ;;AG^ANTIGUA AND BARBUDA
 ;;AI^ANGUILLA
 ;;AL^ALBANIA
 ;;AM^ARMENIA
 ;;AN^NETHERLANDS ANTILLES
 ;;AO^ANGOLA
 ;;AQ^ANTARCTICA
 ;;AR^ARGENTINA
 ;;AS^AMERICAN SAMOA
 ;;AT^AUSTRIA
 ;;AU^AUSTRALIA
 ;;AW^ARUBA
 ;;AZ^AZERBAIJAN
 ;;BA^BOSNIA AND HERZEGOVINA
 ;;BB^BARBADOS
 ;;BD^BANGLADESH
 ;;BE^BELGIUM
 ;;BF^BURKINA FASO
 ;;BG^BULGARIA
 ;;BH^BAHRAIN
 ;;BI^BURUNDI
 ;;BJ^BENIN
 ;;BM^BERMUDA
 ;;BN^BRUNEI DARUSSALAM
 ;;BO^BOLIVIA
 ;;BR^BRAZIL
 ;;BS^BAHAMAS
 ;;BT^BHUTAN
 ;;BV^BOUVET ISLAND
 ;;BW^BOTSWANA
 ;;BY^BELARUS
 ;;BZ^BELIZE
 ;;CA^CANADA
 ;;CC^COCOS (KEELING) ISLANDS
 ;;CD^CONGO, DEMOCRATIC PEOPLE'S REPUBLIC
 ;;CF^CENTRAL AFRICAN REPUBLIC
 ;;CG^CONGO, REPUBLIC OF
 ;;CH^SWITZERLAND
 ;;CI^COTE D'IVOIRE
 ;;CK^COOK ISLANDS
 ;;CL^CHILE
 ;;CM^CAMEROON
 ;;CN^CHINA
 ;;CO^COLOMBIA
 ;;CR^COSTA RICA
 ;;CU^CUBA
 ;;CV^CAPE VERDE
 ;;CX^CHRISTMAS ISLAND
 ;;CY^CYPRUS
 ;;CZ^CZECH REPUBLIC
 ;;DE^GERMANY
 ;;DJ^DJIBOUTI
 ;;DK^DENMARK
 ;;DM^DOMINICA
 ;;DO^DOMINICAN REPUBLIC
 ;;DZ^ALGERIA
 ;;EC^ECUADOR
 ;;EE^ESTONIA
 ;;EG^EGYPT
 ;;EH^WESTERN SAHARA
 ;;ER^ERITREA
 ;;ES^SPAIN
 ;;ET^ETHIOPIA
 ;;FI^FINLAND
 ;;FJ^FIJI
 ;;FK^FALKLAND ISLANDS (MALVINAS)
 ;;FM^MICRONESIA, FEDERATED STATES OF
 ;;FO^FAROE ISLANDS
 ;;FR^FRANCE
 ;;GA^GABON
 ;;GB^UNITED KINGDOM
 ;;GD^GRENADA
 ;;GE^GEORGIA
 ;;GF^FRENCH GUIANA
 ;;GG^GUERNSEY
 ;;GH^GHANA
 ;;GI^GIBRALTAR
 ;;GL^GREENLAND
 ;;GM^GAMBIA
 ;;GN^GUINEA
 ;;GP^GUADELOUPE
 ;;GQ^EQUATORIAL GUINEA
 ;;GR^GREECE
 ;;GS^SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS
 ;;GT^GUATEMALA
 ;;GU^GUAM
 ;;GW^GUINEA-BISSAU
 ;;GY^GUYANA
 ;;HK^HONG KONG
 ;;HM^HEARD ISLAND AND MCDONALD ISLANDS
 ;;HN^HONDURAS
 ;;HR^CROATIA/HRVATSKA
 ;;HT^HAITI
 ;;HU^HUNGARY
 ;;ID^INDONESIA
 ;;IE^IRELAND
 ;;IL^ISRAEL
 ;;IM^ISLE OF MAN
 ;;IN^INDIA
 ;;IO^BRITISH INDIAN OCEAN TERRITORY
 ;;IQ^IRAQ
 ;;IR^IRAN, ISLAMIC REPUBLIC OF
 ;;IS^ICELAND
 ;;IT^ITALY
 ;;JE^JERSEY
 ;;JM^JAMAICA
 ;;JO^JORDAN
 ;;JP^JAPAN
 ;;KE^KENYA
 ;;KG^KYRGYZSTAN
 ;;KH^CAMBODIA
 ;;KI^KIRIBATI
 ;;KM^COMOROS
 ;;KN^SAINT KITTS AND NEVIS
 ;;KP^KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF
 ;;KR^KOREA, REPUBLIC OF
 ;;KW^KUWAIT
 ;;KY^CAYMAN ISLANDS
 ;;KZ^KAZAKSTAN
 ;;LA^LAO PEOPLE'S DEMOCRATIC REPUBLIC
 ;;LB^LEBANON
 ;;LC^SAINT LUCIA
 ;;LI^LIECHTENSTEIN
 ;;LK^SRI LANKA
 ;;LR^LIBERIA
 ;;LS^LESOTHO
 ;;LT^LITHUANIA
 ;;LU^LUXEMBOURG
 ;;LV^LATVIA
 ;;LY^LIBYAN ARAB JAMAHIRIYA
 ;;MA^MOROCCO
 ;;MC^MONACO
 ;;MD^MOLDOVA, REPUBLIC OF
 ;;MG^MADAGASCAR
 ;;MH^MARSHALL ISLANDS
 ;;MK^MACEDONIA, FORMER YUGOSLAV REPUBLIC OF
 ;;ML^MALI
 ;;MM^MYANMAR
 ;;MN^MONGOLIA
 ;;MO^MACAU
 ;;MP^NORTHERN MARIANA ISLANDS
 ;;MQ^MARTINIQUE
 ;;MR^MAURITANIA
 ;;MS^MONTSERRAT
 ;;MT^MALTA
 ;;MU^MAURITIUS
 ;;MV^MALDIVES
 ;;MW^MALAWI
 ;;MX^MEXICO
 ;;MY^MALAYSIA
 ;;MZ^MOZAMBIQUE
 ;;NA^NAMIBIA
 ;;NC^NEW CALEDONIA
 ;;NE^NIGER
 ;;NF^NORFOLK ISLAND
 ;;NG^NIGERIA
 ;;NI^NICARAGUA
 ;;NL^NETHERLANDS
 ;;NO^NORWAY
 ;;NP^NEPAL
 ;;NR^NAURU
 ;;NU^NIUE
 ;;NZ^NEW ZEALAND
 ;;OM^OMAN
 ;;PA^PANAMA
 ;;PE^PERU
 ;;PF^FRENCH POLYNESIA
 ;;PG^PAPUA NEW GUINEA
 ;;PH^PHILIPPINES
 ;;PK^PAKISTAN
 ;;PL^POLAND
 ;;PM^SAINT PIERRE AND MIQUELON
 ;;PN^PITCAIRN ISLAND
 ;;PR^PUERTO RICO
 ;;PS^PALESTINIAN TERRITORIES
 ;;PT^PORTUGAL
 ;;PW^PALAU
 ;;PY^PARAGUAY
 ;;QA^QATAR
 ;;RE^REUNION ISLAND
 ;;RO^ROMANIA
 ;;RU^RUSSIAN FEDERATION
 ;;RW^RWANDA
 ;;SA^SAUDI ARABIA
 ;;SB^SOLOMON ISLANDS
 ;;SC^SEYCHELLES
 ;;SD^SUDAN
 ;;SE^SWEDEN
 ;;SG^SINGAPORE
 ;;SH^SAINT HELENA
 ;;SI^SLOVENIA
 ;;SJ^SVALBARD AND JAN MAYEN
 ;;SK^SLOVAK REPUBLIC
 ;;SL^SIERRA LEONE
 ;;SM^SAN MARINO
 ;;SN^SENEGAL
 ;;SO^SOMALIA
 ;;SR^SURINAME
 ;;ST^SAO TOME AND PRINCIPE
 ;;SV^EL SALVADOR
 ;;SY^SYRIAN ARAB REPUBLIC
 ;;SZ^SWAZILAND
 ;;TC^TURKS AND CAICOS ISLANDS
 ;;TD^CHAD
 ;;TF^FRENCH SOUTHERN TERRITORIES
 ;;TG^TOGO
 ;;TH^THAILAND
 ;;TJ^TAJIKISTAN
 ;;TK^TOKELAU
 ;;TM^TURKMENISTAN
 ;;TN^TUNISIA
 ;;TO^TONGA
 ;;TP^EAST TIMOR
 ;;TR^TURKEY
 ;;TT^TRINIDAD AND TOBAGO
 ;;TV^TUVALU
 ;;TW^TAIWAN
 ;;TZ^TANZANIA
 ;;UA^UKRAINE
 ;;UG^UGANDA
 ;;UK^UNITED KINGDOM
 ;;UM^UNITED STATES MINOR OUTLYING ISLANDS
 ;;US^UNITED STATES
 ;;UY^URUGUAY
 ;;UZ^UZBEKISTAN
 ;;VA^HOLY SEE (VATICAN CITY STATE)
 ;;VC^SAINT VINCENT AND THE GRENADINES
 ;;VE^VENEZUELA
 ;;VG^VIRGIN ISLANDS, BRITISH
 ;;VI^VIRGIN ISLANDS, U.S.
 ;;VN^VIETNAM
 ;;VU^VANUATU
 ;;WF^WALLIS AND FUTUNA ISLANDS
 ;;WS^WESTERN SAMOA
 ;;YE^YEMEN
 ;;YT^MAYOTTE
 ;;YU^YUGOSLAVIA
 ;;ZA^SOUTH AFRICA
 ;;ZM^ZAMBIA
 ;;ZR^ZAIRE
 ;;ZW^ZIMBABWE
 ;;