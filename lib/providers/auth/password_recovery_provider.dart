import 'package:flutter/material.dart';
import '../../utils/api_manager.dart';
import '../../utils/pop_ups.dart';

import '../../route/route_constants.dart';
class PasswordRecoveryProvider with ChangeNotifier{
  String email = "";
  bool passwordRecoveryLoading = false;
  setPasswordRecoveryLoading(bool value){
    passwordRecoveryLoading = value;
    notifyListeners();
  }

  sendResetPasswordRequest(BuildContext context) async {
    setPasswordRecoveryLoading(true);
    try{
      if(await ApiManager.resetPasswordRequest(email)){
        setPasswordRecoveryLoading(true);
        if(context.mounted){
          Navigator.pushNamed(context, verificationMethodScreenRoute);
        }
      }

    }catch (e){
      setPasswordRecoveryLoading(false);
      if(context.mounted){
        PopUps.apiError(context, e.toString());
      }
    }
  }
}