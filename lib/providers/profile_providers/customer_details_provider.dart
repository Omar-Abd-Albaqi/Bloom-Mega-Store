import 'package:bloom/api/auth_api_manager.dart';
import 'package:bloom/api/cart_api_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/customer_models/customer_details_model.dart';
import '../../utils/hive_manager.dart';
import 'addresses_provider.dart';


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
Future<void> getCustomerDetails(BuildContext context) async {
  customerDetailsModel = await AuthApiManager.getCustomerDetails();
  if(customerDetailsModel != null && customerDetailsModel.runtimeType == CustomerDetailsModel){
    context.read<AddressesProvider>().addressList = customerDetailsModel!.addresses;
    if(customerDetailsModel!.metadata['cartId'] == null || customerDetailsModel!.metadata['cartId'].toString().isEmpty){
      if(HiveStorageManager.getCartId().isNotEmpty){
        String cartId = HiveStorageManager.getCartId();
        String customerEmail = customerDetailsModel!.email;
        String customerToken = HiveStorageManager.getToken();
        CartApiManager.linkCartToUser(cartId: cartId, customerEmail: customerEmail, customerToken: customerToken);
      }
    }

  }
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
    CustomerDetailsModel customer = await AuthApiManager.updateCustomer(body);
    setCustomerDetailsModel(customer);
    print("customer $customer");
    setUpdateCustomerLoading(false);
    if(context.mounted){
      Navigator.pop(context);
    }
}
}