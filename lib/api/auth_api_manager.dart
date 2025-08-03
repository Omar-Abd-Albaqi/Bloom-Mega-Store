

import 'dart:convert';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';
import '../models/customer_model.dart';
import '../models/customer_models/customer_details_model.dart';
import '../utils/hive_manager.dart';

class AuthApiManager{
  //obtain registration token
  static Future<String> obtainRegistrationToken(Map<String, dynamic> body) async {
    final tempBody = body;
    Uri url = Uri.https(
      authority,
      registerCustomerPath,
    );
    Map<String, String> headers = {'Content-Type': 'application/json'};
    try{
      http.Response response = await http.post(url , body: jsonEncode(body), headers: headers).timeout(const Duration(seconds: 10));
      if(response.statusCode == 200){
        final extractedData = jsonDecode(response.body);
        String token = extractedData['token'];
        HiveStorageManager.setToken(token);
        return token;
      }else{
        if(response.reasonPhrase == "Unauthorized"){
          return await authenticateCustomer(tempBody);
        }else{
          throw "Error registering customer ${response.reasonPhrase}";
        }
      }
    } catch (e) {
      throw "Error registering customer $e";
    }
  }

  //create customer account
  static Future<CustomerModel> createCustomerAccount(
      Map<String, dynamic> body,
      String token
      ) async
  {
    Uri url = Uri.https(
      authority,
      createCustomerAccountPath,
    );

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
      "Authorization": "Bearer $token"
    };
    try {
      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 10));
      final extractedData = jsonDecode(response.body);
      if(response.statusCode == 200){
        return CustomerModel.fromJson(extractedData['customer']);
      }else{
        if(extractedData['message'] == "Request already authenticated as a customer."){
          throw throw "existingUser";
        }
        else{
          throw extractedData['message'];
        }
      }
    } catch (e) {
      throw e.toString();
    }
  }

  //authenticate or login customer
  static Future<String> authenticateCustomer(Map<String, dynamic> body,) async {
    final Uri url = Uri.https(authority, authenticateCustomerPath);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      final http.Response response = await http
          .post(url, body: jsonEncode(body), headers: headers)
          .timeout(const Duration(seconds: 10));

      final extractedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final String token = extractedData['token'];
        // final String customerId = extractedData['customer']['id'];
        // ✅ Save token & customer ID to Hive (optional but useful)
        // print(customerId);

        HiveStorageManager.setToken(token);

        // ✅ Try to link existing cart to this customer

        final String cartId = HiveStorageManager.getCartId();

        // if (cartId.isNotEmpty) {
        //   try {
        //     final updatedCart = await CartApiManager.linkCartToUser(
        //       cartId: cartId,
        //       // customerId: customerId,
        //     );
        //
        //     // Optionally update the cart in Hive
        //     // cartBox.put('cartData', updatedCart);
        //     debugPrint('Cart linked successfully after login');
        //   } catch (e) {
        //     debugPrint('Failed to link cart: $e');
        //   }
        // }
        // else {
        //   debugPrint('No cart found in local storage to link');
        // }

        return token;
      } else {
        throw extractedData['message'] ?? 'Unknown login error';
      }
    } catch (e) {
      throw 'Error signing in customer: $e';
    }
  }


  //reset password customer
  static Future<bool> resetPasswordRequest(String email) async {
    Uri url = Uri.https(
      authority,
      resetPasswordPath,
    );
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, String> body = {
      'identifier' : email
    };
    try{
      http.Response response = await http.post(url, headers: headers, body: jsonEncode(body)).timeout(const Duration(seconds: 10));
      final extractedData = jsonDecode(response.body);
      if(response.statusCode == 201){
        return true;
      }else{
        throw extractedData['message'];
      }
    }catch (e){
      throw "Error sending reset password request $e";
    }
  }

  //get customer details
  static Future<CustomerDetailsModel> getCustomerDetails() async {
    String token = HiveStorageManager.getToken();
    Uri url = Uri.https(
      authority,
      customerDetailsPath,
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "x-publishable-api-key": publishableKey
    };
    print("headers for getting customer details $headers");
    try{
      http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
      final extractedData = jsonDecode(response.body);
      print(extractedData);
      if(response.statusCode == 200){
        return CustomerDetailsModel.fromJson(extractedData['customer']);
      }else{
        throw extractedData['message'];
      }
    } catch (e){
      throw "Error getting customer details $e";
    }
  }

  static Future<String> refreshCustomerToken() async {
    ///store/customers/auth/token
    String path = "store/customers/auth/token";
    String token = HiveStorageManager.getToken();
    Uri url = Uri.https(
      authority,
      path,
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
    final extractedData = jsonDecode(response.body);
    return extractedData.toString();
  }

  //update customer details
  static Future<CustomerDetailsModel> updateCustomer(Map<String, dynamic> body) async {
    String token = HiveStorageManager.getToken();
    Uri url = Uri.https(
      authority,
      customerDetailsPath,
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
      'x-publishable-api-key' : publishableKey
    };http.Response response = await http.post(url, headers: headers, body: jsonEncode(body)).timeout(const Duration(seconds: 10));
    final extractedData = jsonDecode(response.body);
    if(response.statusCode == 200){
      print("Customer details updated!");
      return CustomerDetailsModel.fromJson(extractedData['customer']);

    }else{
      throw Exception("Error updating customer info ${extractedData['message']}");
    }
  }

  static Future<void> removeCustomerAddress(String addressId) async {
    final String token = HiveStorageManager.getToken(); // Customer JWT
    final url = Uri.https(
      authority,
      "/store/customers/me/addresses/$addressId",
    );

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'x-publishable-api-key': publishableKey, // ✅ Required in your case
      },
    ).timeout(const Duration(seconds: 10));

    print("Status: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      print('✅ Address removed successfully');
    } else {
      print('❌ Failed to remove address: ${response.body}');
    }
  }

  static Future<TrackingStatus> checkTrackingTransparencyIOS() async {
    TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    } else {
      if (status != TrackingStatus.authorized) {
        await openAppSettings();
      }
    }
    return status;
  }

  static Future<String?> facebookAuth() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
          loginTracking: LoginTracking.enabled);
      String? accessToken = loginResult.accessToken?.tokenString ?? "";
      return accessToken;
    } catch (e){
      return null;
    }
  }

  static Future<dynamic> phoneAuth(String phone , String countryCode , bool register) async {
    Uri url = Uri.https(authority, phoneAuthPath);
    Map<String, dynamic> body = {
      "phone": phone,
      "country": countryCode.toUpperCase(),
      "register": register
    };
    try{
      http.Response response = await http.post(url , body: json.encode(body), headers: {'Content-Type': 'application/json'},).timeout(const Duration(seconds: 10));
      final extractedData = jsonDecode(response.body);
      print(extractedData);
      if(response.statusCode == 200){
        return extractedData;
      }else{
        return response.body;
      }
    } catch (e){
      return e.toString();
    }
  }

}




