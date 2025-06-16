import 'package:bloom/api/auth_api_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/customer_model.dart';
import '../../utils/api_manager.dart';
import '../../utils/hive_manager.dart';
import '../../utils/pop_ups.dart';


import '../../route/route_constants.dart';
import '../home_page_provider/home_items_provider.dart';



class SignUpProvider with ChangeNotifier{

  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";
  String dateOfBirth = "";
  String phone = "";
  // XFile? image;
  String gender = "Male";

  // setImage(XFile? file){
  //   image = file;
  //   notifyListeners();
  // }

  setGender(String value){
    gender = value;
    notifyListeners();
  }


  setDateOfBirth(String value){
    dateOfBirth = value;
    notifyListeners();
  }

  bool signUpLoading = false;
  bool agree = false;
  setAgree(bool value){
    agree = value;
    notifyListeners();
  }


  setSignUpLoading(bool value){
    signUpLoading = value;
    notifyListeners();
  }


  Future<void> signUp(BuildContext context) async {
    setSignUpLoading(true);
    Map<String, dynamic> tokenBody = {
      "email" : email,
      "password" : password,
    };
    print("tokenBody: $tokenBody");
    try{
      final String token = await AuthApiManager.obtainRegistrationToken(tokenBody);

      // String? profileUrl;
      // if(image != null){
        // profileUrl = await ApiManager.uploadFile(image!);
      // }
      Map<String, dynamic> fullBody = {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "company_name" : "",
        'metadata': {
          'date_of_birth': dateOfBirth,
          // 'image_url': profileUrl ?? "",
          'gender': gender
        }
      };
      try{
         CustomerModel customer = await AuthApiManager.createCustomerAccount(fullBody, token);
         String authToken = await AuthApiManager.authenticateCustomer(tokenBody);
         HiveStorageManager.setToken(authToken);
         HiveStorageManager.setSignedIn(true);
         setSignUpLoading(false);
         if(context.mounted){
           context.read<HomeItemsProvider>().getHomePageItems(context);
           Navigator.pushNamedAndRemoveUntil(
               context,
               entryPointScreenRoute,
               ModalRoute.withName(profileSetupScreenRoute));
         }
         print(customer);
      }catch (e){
        setSignUpLoading(false);
        if(e.toString() == "existingUser"){
          if(context.mounted){
            PopUps.apiError(context, "User already exist\nTry login please");
          }
          return;
        }
        if(context.mounted){
          PopUps.apiError(context, e.toString());
        }
      }
    }catch (e){
      setSignUpLoading(false);
      if(context.mounted){
        PopUps.apiError(context, e.toString());
      }
    }
    setSignUpLoading(false);
  }



}