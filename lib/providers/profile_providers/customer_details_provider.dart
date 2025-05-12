import 'package:flutter/material.dart';
import '../../models/customer_models/customer_details_model.dart';
import '../../utils/api_manager.dart';


class CustomerDetailsProvider with ChangeNotifier{
  CustomerDetailsModel? customerDetailsModel;

  setCustomerDetailsModel(CustomerDetailsModel newCustomer){
    customerDetailsModel = newCustomer;
    notifyListeners();
  }

  String firstName = "";
  String lastName = "";
  String email = "";
  String dateOfBirth = "";
  String phone = "";
  String gender = "Male";
  bool updateCustomerLoading = false;

  setGender(String value){
    gender = value;
    notifyListeners();
  }


  setUpdateCustomerLoading(bool value){
    updateCustomerLoading = value;
    notifyListeners();
  }

  setDateOfBirth(String value){
    dateOfBirth = value;
    notifyListeners();
  }



  //get customer details
Future<void> getCustomerDetails() async {
  customerDetailsModel = await ApiManager.getCustomerDetails();
  notifyListeners();
}

Future<void> updateCustomerInfo(BuildContext context) async {
    setUpdateCustomerLoading(true);
    Map<String, dynamic> body = {
      if(firstName.isNotEmpty) 'first_name': firstName,
      if(lastName.isNotEmpty) 'last_name': lastName,
      'metadata': {
        if(dateOfBirth.isNotEmpty) 'date_of_birth' : dateOfBirth,
        'gender' : gender
      },
      if(phone.isNotEmpty) 'phone': phone,
    };
    print("body = $body");
    CustomerDetailsModel customer = await ApiManager.updateCustomer(body);
    setCustomerDetailsModel(customer);
    print(customer);
    setUpdateCustomerLoading(false);
    if(context.mounted){
      Navigator.pop(context);
    }
}
}