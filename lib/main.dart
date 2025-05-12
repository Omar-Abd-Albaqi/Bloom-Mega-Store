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

_appInit() async {
  await HiveStorageManager.openHiveBox();
}


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _appInit();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => NavBarProvider()),
        ChangeNotifierProvider(create: (_) => CustomerDetailsProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => HomeItemsProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
