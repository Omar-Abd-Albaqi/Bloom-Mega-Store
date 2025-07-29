import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ru')
  ];

  ///
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showall;

  ///
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Best Sellers'**
  String get bestsellers;

  ///
  ///
  /// In en, this message translates to:
  /// **'New Arrivals'**
  String get newarrivals;

  ///
  ///
  /// In en, this message translates to:
  /// **'Women’s Fashion'**
  String get womensfashion;

  ///
  ///
  /// In en, this message translates to:
  /// **'Kids & Baby'**
  String get kidsandbaby;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mobile Accessories'**
  String get mobileaccessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Home Appliances'**
  String get homeappliances;

  ///
  ///
  /// In en, this message translates to:
  /// **'Consumer Electronics'**
  String get consumerelectronics;

  ///
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  ///
  ///
  /// In en, this message translates to:
  /// **'Outdoors'**
  String get outdoors;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bathroom Accessories'**
  String get bathroomaccessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Kitchenware'**
  String get kitchenware;

  ///
  ///
  /// In en, this message translates to:
  /// **'Fashion'**
  String get fashion;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sport & Fitness'**
  String get sportandfitness;

  ///
  ///
  /// In en, this message translates to:
  /// **'Home Decor'**
  String get homedecor;

  ///
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get travel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Find something...'**
  String get findsomething;

  ///
  ///
  /// In en, this message translates to:
  /// **'Men'**
  String get men;

  ///
  ///
  /// In en, this message translates to:
  /// **'Clothing'**
  String get clothing;

  ///
  ///
  /// In en, this message translates to:
  /// **'T-Shirts & Polos'**
  String get tshirtsandpolos;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shirts'**
  String get shirts;

  ///
  ///
  /// In en, this message translates to:
  /// **'Jeans'**
  String get jeans;

  ///
  ///
  /// In en, this message translates to:
  /// **'Trousers & Chinos'**
  String get trousersandchinos;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shorts'**
  String get shorts;

  ///
  ///
  /// In en, this message translates to:
  /// **'Hoodies & Sweatshirts'**
  String get hoodiesandsweatshirts;

  ///
  ///
  /// In en, this message translates to:
  /// **'Activewear'**
  String get activewear;

  ///
  ///
  /// In en, this message translates to:
  /// **'Innerwear & Socks'**
  String get innerwearandsocks;

  ///
  ///
  /// In en, this message translates to:
  /// **'Footwear'**
  String get footwear;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sneakers'**
  String get sneakers;

  ///
  ///
  /// In en, this message translates to:
  /// **'Casual Shoes'**
  String get casualshoes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Formal Shoes'**
  String get formalshoes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sandals & Slippers'**
  String get sandalsandslippers;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sports Shoes'**
  String get sportsshoes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Accessories'**
  String get accessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Watches'**
  String get watches;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sunglasses'**
  String get sunglasses;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wallets'**
  String get wallets;

  ///
  ///
  /// In en, this message translates to:
  /// **'Belts'**
  String get belts;

  ///
  ///
  /// In en, this message translates to:
  /// **'Caps & Hats'**
  String get capsandhats;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bags & Backpacks'**
  String get bagsandbackpacks;

  ///
  ///
  /// In en, this message translates to:
  /// **'Jewelry'**
  String get jewelry;

  ///
  ///
  /// In en, this message translates to:
  /// **'Grooming'**
  String get grooming;

  ///
  ///
  /// In en, this message translates to:
  /// **'Skincare'**
  String get skincare;

  ///
  ///
  /// In en, this message translates to:
  /// **'Haircare'**
  String get haircare;

  ///
  ///
  /// In en, this message translates to:
  /// **'Beard Care'**
  String get beardcare;

  ///
  ///
  /// In en, this message translates to:
  /// **'Perfumes & Deodorants'**
  String get perfumesanddeodorants;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shaving & Grooming Kits'**
  String get shavingandgroomingkits;

  ///
  ///
  /// In en, this message translates to:
  /// **'Women'**
  String get women;

  ///
  ///
  /// In en, this message translates to:
  /// **'Dresses'**
  String get dresses;

  ///
  ///
  /// In en, this message translates to:
  /// **'Tops & Blouses'**
  String get topsandblouses;

  ///
  ///
  /// In en, this message translates to:
  /// **'T-Shirts'**
  String get tshirts;

  ///
  ///
  /// In en, this message translates to:
  /// **'Jeans & Jeggings'**
  String get jeansandjeggings;

  ///
  ///
  /// In en, this message translates to:
  /// **'Trousers & Leggings'**
  String get trousersandleggings;

  ///
  ///
  /// In en, this message translates to:
  /// **'Skirts'**
  String get skirts;

  ///
  ///
  /// In en, this message translates to:
  /// **'Ethnic Wear'**
  String get ethnicwear;

  ///
  ///
  /// In en, this message translates to:
  /// **'Innerwear & Lingerie'**
  String get innerwearandlingerie;

  ///
  ///
  /// In en, this message translates to:
  /// **'Heels'**
  String get heels;

  ///
  ///
  /// In en, this message translates to:
  /// **'Flats'**
  String get flats;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sandals'**
  String get sandals;

  ///
  ///
  /// In en, this message translates to:
  /// **'Boots'**
  String get boots;

  ///
  ///
  /// In en, this message translates to:
  /// **'Slippers'**
  String get slippers;

  ///
  ///
  /// In en, this message translates to:
  /// **'Handbags & Clutches'**
  String get handbagsandclutches;

  ///
  ///
  /// In en, this message translates to:
  /// **'Hair Accessories'**
  String get hairaccessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Scarves & Shawls'**
  String get scarvesandshawls;

  ///
  ///
  /// In en, this message translates to:
  /// **'Beauty & Personal Care'**
  String get beautyandpersonalcare;

  ///
  ///
  /// In en, this message translates to:
  /// **'Perfumes & Fragrances'**
  String get perfumesandfragrances;

  ///
  ///
  /// In en, this message translates to:
  /// **'Makeup (Lips, Eyes, Face, Nails)'**
  String get makeuplipseyesfacenails;

  ///
  ///
  /// In en, this message translates to:
  /// **'Beauty Tools'**
  String get beautytools;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wellness & Supplements'**
  String get wellnessandsupplements;

  ///
  ///
  /// In en, this message translates to:
  /// **'Kids'**
  String get kids;

  ///
  ///
  /// In en, this message translates to:
  /// **'Boys Clothing'**
  String get boysclothing;

  ///
  ///
  /// In en, this message translates to:
  /// **'T-Shirts & Shirts'**
  String get tshirtsandshirts;

  ///
  ///
  /// In en, this message translates to:
  /// **'Jeans & Trousers'**
  String get jeansandtrousers;

  ///
  ///
  /// In en, this message translates to:
  /// **'Jackets & Hoodies'**
  String get jacketsandhoodies;

  ///
  ///
  /// In en, this message translates to:
  /// **'Innerwear'**
  String get innerwear;

  ///
  ///
  /// In en, this message translates to:
  /// **'Girls Clothing'**
  String get girlsclothing;

  ///
  ///
  /// In en, this message translates to:
  /// **'Tops & T-Shirts'**
  String get topsandtshirts;

  ///
  ///
  /// In en, this message translates to:
  /// **'Jeans & Leggings'**
  String get jeansandleggings;

  ///
  ///
  /// In en, this message translates to:
  /// **'Skirts & Shorts'**
  String get skirtsandshorts;

  ///
  ///
  /// In en, this message translates to:
  /// **'School Shoes'**
  String get schoolshoes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Accessories & Toys'**
  String get accessoriesandtoys;

  ///
  ///
  /// In en, this message translates to:
  /// **'Toys & Games'**
  String get toysandgames;

  ///
  ///
  /// In en, this message translates to:
  /// **'Educational Toys'**
  String get educationaltoys;

  ///
  ///
  /// In en, this message translates to:
  /// **'Baby Essentials'**
  String get babyessentials;

  ///
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get electronics;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mobile & Accessories'**
  String get mobileandaccessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Smartphones'**
  String get smartphones;

  ///
  ///
  /// In en, this message translates to:
  /// **'Smartwatches'**
  String get smartwatches;

  ///
  ///
  /// In en, this message translates to:
  /// **'Headphones & Earphones'**
  String get headphonesandearphones;

  ///
  ///
  /// In en, this message translates to:
  /// **'Power banks'**
  String get powerbanks;

  ///
  ///
  /// In en, this message translates to:
  /// **'Phone Cases & Covers'**
  String get phonecasesandcovers;

  ///
  ///
  /// In en, this message translates to:
  /// **'Chargers & Cables'**
  String get chargersandcables;

  ///
  ///
  /// In en, this message translates to:
  /// **'Computers & Accessories'**
  String get computersandaccessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Laptops'**
  String get laptops;

  ///
  ///
  /// In en, this message translates to:
  /// **'Monitors'**
  String get monitors;

  ///
  ///
  /// In en, this message translates to:
  /// **'Keyboards & Mice'**
  String get keyboardsandmice;

  ///
  ///
  /// In en, this message translates to:
  /// **'External Hard Drives'**
  String get externalharddrives;

  ///
  ///
  /// In en, this message translates to:
  /// **'Laptop Bags & Stands'**
  String get laptopbagsandstands;

  ///
  ///
  /// In en, this message translates to:
  /// **'Printers & Scanners'**
  String get printersandscanners;

  ///
  ///
  /// In en, this message translates to:
  /// **'TV & Entertainment'**
  String get tvandentertainment;

  ///
  ///
  /// In en, this message translates to:
  /// **'Smart TVs'**
  String get smarttvs;

  ///
  ///
  /// In en, this message translates to:
  /// **'Streaming Devices'**
  String get streamingdevices;

  ///
  ///
  /// In en, this message translates to:
  /// **'Home Theaters & Soundbars'**
  String get hometheatersandsoundbars;

  ///
  ///
  /// In en, this message translates to:
  /// **'Gaming Consoles'**
  String get gamingconsoles;

  ///
  ///
  /// In en, this message translates to:
  /// **'Gaming Accessories'**
  String get gamingaccessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Refrigerators'**
  String get refrigerators;

  ///
  ///
  /// In en, this message translates to:
  /// **'Washing Machines'**
  String get washingmachines;

  ///
  ///
  /// In en, this message translates to:
  /// **'Air Conditioners'**
  String get airconditioners;

  ///
  ///
  /// In en, this message translates to:
  /// **'Vacuum Cleaners'**
  String get vacuumcleaners;

  ///
  ///
  /// In en, this message translates to:
  /// **'Microwave Ovens'**
  String get microwaveovens;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wearable Tech'**
  String get wearabletech;

  ///
  ///
  /// In en, this message translates to:
  /// **'Fitness Trackers'**
  String get fitnesstrackers;

  ///
  ///
  /// In en, this message translates to:
  /// **'VR headsets'**
  String get vrheadsets;

  ///
  ///
  /// In en, this message translates to:
  /// **'Camera & Accessories'**
  String get cameraandaccessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'DSLRs & Mirrorless Cameras'**
  String get dslrsandmirrorlesscameras;

  ///
  ///
  /// In en, this message translates to:
  /// **'Action Cameras'**
  String get actioncameras;

  ///
  ///
  /// In en, this message translates to:
  /// **'Tripods & Gimbals'**
  String get tripodsandgimbals;

  ///
  ///
  /// In en, this message translates to:
  /// **'Camera Lenses'**
  String get cameralenses;

  ///
  ///
  /// In en, this message translates to:
  /// **'Household Items'**
  String get householditems;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wall Art & Frames'**
  String get wallartandframes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Clocks'**
  String get clocks;

  ///
  ///
  /// In en, this message translates to:
  /// **'Decorative Lighting'**
  String get decorativelighting;

  ///
  ///
  /// In en, this message translates to:
  /// **'Candles & Fragrances'**
  String get candlesandfragrances;

  ///
  ///
  /// In en, this message translates to:
  /// **'Furniture'**
  String get furniture;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sofas & Chairs'**
  String get sofasandchairs;

  ///
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get tables;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wardrobes & Storage'**
  String get wardrobesandstorage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Beds & Mattresses'**
  String get bedsandmattresses;

  ///
  ///
  /// In en, this message translates to:
  /// **'Kitchen & Dining'**
  String get kitchenanddining;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cookware & Bakeware'**
  String get cookwareandbakeware;

  ///
  ///
  /// In en, this message translates to:
  /// **'Dinnerware & Cutlery'**
  String get dinnerwareandcutlery;

  ///
  ///
  /// In en, this message translates to:
  /// **'Kitchen Storage'**
  String get kitchenstorage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Small Appliances (Blenders, Coffee Makers, etc.)'**
  String get smallappliancesblenderscoffeemakersetc;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bedding & Bath'**
  String get beddingandbath;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bedsheets & Blankets'**
  String get bedsheetsandblankets;

  ///
  ///
  /// In en, this message translates to:
  /// **'Pillow & Cushions'**
  String get pillowandcushions;

  ///
  ///
  /// In en, this message translates to:
  /// **'Towels & Bathrobes'**
  String get towelsandbathrobes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bath Mats'**
  String get bathmats;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cleaning & Storage'**
  String get cleaningandstorage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cleaning Supplies'**
  String get cleaningsupplies;

  ///
  ///
  /// In en, this message translates to:
  /// **'Storage Bins & Organizers'**
  String get storagebinsandorganizers;

  ///
  ///
  /// In en, this message translates to:
  /// **'Landry Accessories'**
  String get landryaccessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Makeup & Beauty'**
  String get makeupandbeauty;

  ///
  ///
  /// In en, this message translates to:
  /// **'Face'**
  String get face;

  ///
  ///
  /// In en, this message translates to:
  /// **'Foundation & BB Creams'**
  String get foundationandbbcreams;

  ///
  ///
  /// In en, this message translates to:
  /// **'Concealers & Correctors'**
  String get concealersandcorrectors;

  ///
  ///
  /// In en, this message translates to:
  /// **'Blush & Highlighters'**
  String get blushandhighlighters;

  ///
  ///
  /// In en, this message translates to:
  /// **'Powders'**
  String get powders;

  ///
  ///
  /// In en, this message translates to:
  /// **'Eyes'**
  String get eyes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Eyeshadow'**
  String get eyeshadow;

  ///
  ///
  /// In en, this message translates to:
  /// **'Eyeliners & Kohls'**
  String get eyelinersandkohls;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mascara'**
  String get mascara;

  ///
  ///
  /// In en, this message translates to:
  /// **'False Lashes'**
  String get falselashes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Lips'**
  String get lips;

  ///
  ///
  /// In en, this message translates to:
  /// **'Lipsticks'**
  String get lipsticks;

  ///
  ///
  /// In en, this message translates to:
  /// **'Lip Gloss'**
  String get lipgloss;

  ///
  ///
  /// In en, this message translates to:
  /// **'Lip Liners'**
  String get lipliners;

  ///
  ///
  /// In en, this message translates to:
  /// **'Nails'**
  String get nails;

  ///
  ///
  /// In en, this message translates to:
  /// **'Nail Polish'**
  String get nailpolish;

  ///
  ///
  /// In en, this message translates to:
  /// **'Nail Care & Tools'**
  String get nailcareandtools;

  ///
  ///
  /// In en, this message translates to:
  /// **'Moisturizers & Toners'**
  String get moisturizersandtoners;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cleaners & Toners'**
  String get cleanersandtoners;

  ///
  ///
  /// In en, this message translates to:
  /// **'Face Masks & Treatments'**
  String get facemasksandtreatments;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sunscreens'**
  String get sunscreens;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shampoos & Conditioners'**
  String get shampoosandconditioners;

  ///
  ///
  /// In en, this message translates to:
  /// **'Hair Oils & Serums'**
  String get hairoilsandserums;

  ///
  ///
  /// In en, this message translates to:
  /// **'Hair Styling Tools'**
  String get hairstylingtools;

  ///
  ///
  /// In en, this message translates to:
  /// **'Fragrances'**
  String get fragrances;

  ///
  ///
  /// In en, this message translates to:
  /// **'Perfumes'**
  String get perfumes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Body Mists'**
  String get bodymists;

  ///
  ///
  /// In en, this message translates to:
  /// **'Makeup Brushes & Sponges'**
  String get makeupbrushesandsponges;

  ///
  ///
  /// In en, this message translates to:
  /// **'Skincare Tools (Jade Rollers, Facial Massagers)'**
  String get skincaretoolsjaderollersfacialmassagers;

  ///
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  ///
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlist;

  ///
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get addresses;

  ///
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  ///
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  ///
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  ///
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  ///
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  ///
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpandsupport;

  ///
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  ///
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  ///
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  ///
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account'**
  String get donthaveanaccount;

  ///
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotpassword;

  ///
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeback;

  ///
  ///
  /// In en, this message translates to:
  /// **'Log in with your data that you entered during your registration.'**
  String get logintitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started'**
  String get letsgetstarted;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please enter your valid data in order to create an account.'**
  String get signuptitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailaddress;

  ///
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  ///
  ///
  /// In en, this message translates to:
  /// **'I agree with the'**
  String get agreement;

  ///
  ///
  /// In en, this message translates to:
  /// **'&'**
  String get and;

  ///
  ///
  /// In en, this message translates to:
  /// **'Do you have an account'**
  String get doyouhaveanaccount;

  ///
  ///
  /// In en, this message translates to:
  /// **'Last updated'**
  String get lastupdated;

  ///
  ///
  /// In en, this message translates to:
  /// **'Terms of services'**
  String get termsofservices;

  ///
  ///
  /// In en, this message translates to:
  /// **'Password recovery'**
  String get passwordrecovery;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter your E-mail address to recover your password'**
  String get passwordrecoverytitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueword;

  ///
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  ///
  ///
  /// In en, this message translates to:
  /// **'Skip login'**
  String get skiplogin;

  ///
  ///
  /// In en, this message translates to:
  /// **'You are not logged in!'**
  String get youarenotloggedin;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please login to see your profile.'**
  String get pleaselogintoseeyourprofile;

  ///
  ///
  /// In en, this message translates to:
  /// **'Review your order'**
  String get reviewyourorder;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your Coupon code'**
  String get couponcode;

  ///
  ///
  /// In en, this message translates to:
  /// **'Type coupon code'**
  String get typecouponcode;

  ///
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get ordersummary;

  ///
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipping Fee'**
  String get shippingfee;

  ///
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total (Included of VAT)'**
  String get totalincludevat;

  ///
  ///
  /// In en, this message translates to:
  /// **'Estimated VAT'**
  String get estimatedvat;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  ///
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get promotions;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  ///
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  ///
  ///
  /// In en, this message translates to:
  /// **'Jackets & Coats'**
  String get jacketsandcoats;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cameras & Accessories'**
  String get camerasandaccessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Laundry Accessories'**
  String get laundryaccessories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Moisturizers & Creams'**
  String get moisturizersandcreams;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cleansers & Toners'**
  String get cleansersandtoners;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get selectyourpreferredlanguage;

  ///
  ///
  /// In en, this message translates to:
  /// **'You will use the same language throughout the app.'**
  String get youwillusethesamelanguagethroughouttheapp;

  ///
  ///
  /// In en, this message translates to:
  /// **'Search your language'**
  String get searchyourlanguage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get brands;

  ///
  ///
  /// In en, this message translates to:
  /// **'Search categories...'**
  String get searchcategories;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your favorites are empty'**
  String get yourfavoritesareempty;

  ///
  ///
  /// In en, this message translates to:
  /// **'Tab the heart icon on any product to make it your favorite!'**
  String get tabthehearticononanyproducttomakeityourfavorite;

  ///
  ///
  /// In en, this message translates to:
  /// **'Personalization'**
  String get personalization;

  ///
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  ///
  ///
  /// In en, this message translates to:
  /// **'Get Help'**
  String get gethelp;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en', 'es', 'fr', 'it', 'ja', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'it': return AppLocalizationsIt();
    case 'ja': return AppLocalizationsJa();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
