import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../route/route_constants.dart';
import '../../../utils/hive_manager.dart';

import '../../providers/home_page_provider/category_provider.dart';
import '../../providers/home_page_provider/home_items_provider.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  getRoute(){
    if(HiveStorageManager.isFirstTimeLaunch()){
      Navigator.pushNamed(context, onbordingScreenRoute);
    }else{
      if(HiveStorageManager.signedInNotifier.value){
        context.read<HomeItemsProvider>().getHomePageItems(context);
        Navigator.pushNamedAndRemoveUntil(
            context,
            entryPointScreenRoute,
            ModalRoute.withName(splashScreenRoute));
      }else{
        Navigator.pushReplacementNamed(context, logInScreenRoute);
      }
    }
  }
  getData()async {
    context.read<CategoryProvider>().getCollectionList();
    context.read<CategoryProvider>().getCategories();
  }

  @override
  void initState() {
    getData();
    Future.delayed(const Duration(seconds: 1), getRoute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/transparent B.png"),
      ),
    );
  }
}
