

import 'dart:convert';
import 'package:http/http.dart' as http;

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
  static Future<String> authenticateCustomer(Map<String, dynamic> body) async {
    Uri url = Uri.https(
      authority,
      authenticateCustomerPath,
    );
    Map<String, String> headers = {'Content-Type': 'application/json'};
    try{
      http.Response response = await http.post(url , body: jsonEncode(body), headers: headers).timeout(const Duration(seconds: 10));
      final extractedData = jsonDecode(response.body);
      if(response.statusCode == 200){
        return extractedData['token'];
      }else{
        throw extractedData['message'];
      }
    } catch (e) {
      throw "Error signing in customer $e";
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
    try{
      http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
      final extractedData = jsonDecode(response.body);
      if(response.statusCode == 200){
        return CustomerDetailsModel.fromJson(extractedData['customer']);
      }else{
        throw extractedData['message'];
      }
    } catch (e){
      throw "Error getting customer details $e";
    }
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
      return CustomerDetailsModel.fromJson(extractedData['customer']);
    }else{
      throw Exception("Error updating customer info ${extractedData['message']}");
    }
  }
}