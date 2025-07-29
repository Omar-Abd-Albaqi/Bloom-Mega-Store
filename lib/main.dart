import 'package:bloom/providers/cart_page_provider/cart_page_provider.dart';
import 'package:bloom/providers/locale_provider.dart';
import 'package:bloom/providers/product_Provider/product_details_screen_provider.dart';
import 'package:bloom/providers/profile_providers/addresses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth/login_provider.dart';
import '../../providers/auth/sign_up_provider.dart';
import '../../providers/entry_point_providers/nav_bar_provider.dart';
import '../../providers/home_page_provider/category_provider.dart';
import '../../providers/home_page_provider/home_items_provider.dart';
import '../../providers/profile_providers/customer_details_provider.dart';
import '../../route/route_constants.dart';
import '../../route/router.dart' as router;
import '../../theme/app_theme.dart';
import '../../utils/hive_manager.dart';
import 'l10n/app_localizations.dart';




final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
_appInit() async {
  await HiveStorageManager.openHiveBox();
}


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _appInit();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => NavBarProvider()),
        ChangeNotifierProvider(create: (_) => CustomerDetailsProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => HomeItemsProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailsScreenProvider()),
        ChangeNotifierProvider(create: (_) => CartPageProvider()),
        ChangeNotifierProvider(create: (_) => AddressesProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: localeProvider.locale,
      navigatorKey: rootNavigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Bloom MegaStore',
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      themeMode: ThemeMode.light,
      onGenerateRoute: router.generateRoute,
      initialRoute: splashScreenRoute,
    );
  }
}