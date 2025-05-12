import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../models/category_model.dart';
import '../../../models/customer_model.dart';
import '../../../models/customer_models/customer_details_model.dart';
import '../../../models/home_items_models/collection_model.dart';
import '../../../models/product_details_model.dart';
import '../../../utils/hive_manager.dart';

import '../models/home_items_models/boxes_inline_boxes_model.dart';
import '../models/home_items_models/global_broadcast_model.dart';
import '../models/home_items_models/global_counter_model.dart';
import '../models/home_items_models/global_list_icons_model.dart';
import '../models/home_items_models/global_testimonials_model.dart';
import '../models/home_items_models/products_categories.dart';
import '../models/home_items_models/products_list_products.dart';
import '../models/home_items_models/products_promo_banner.dart';
import '../models/home_items_models/slider_items_model.dart';
import '../models/local_storage_models/product_model/product_model.dart';



class ApiManager{

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
      print(response.statusCode);
      print(jsonDecode(response.body));
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
  print(extractedData);
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
    print("Token = $token");
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

  static Future<List<CategoryModel>> getCategories()async {
    Map<String, dynamic> params = {
      "fields": "id,name,parent_category_id",
      "limit": "999"
    };
  Uri url = Uri.https(
    authority,
    categoriesPath,
    params
  );
  print(url);
  Map<String, String> headers = {
    "x-publishable-api-key": publishableKey
  };
  http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
  final extractedData = jsonDecode(response.body);
  if(response.statusCode == 200){
    List categoryList = extractedData['product_categories'];
    return categoryList.map((cat) =>  CategoryModel.fromJson(cat)).toList();
  }else{
    throw Exception("Error getting categories: ${extractedData['message']}");
  }
}

  static Future<List<dynamic>> getHomeItems() async {
  Uri url = Uri.https(
      strapiAuthority,
      homeItemsPath,
      homeItemsParams
  );
  print(url);
  Map<String, String> headers = {
    "Authorization" : "Bearer 48d74d9b0f24c71f379184431f2ae803241a1dc13fa3a29193a956984bcaa6bacf327845ffecf00601f1229868f9752d47ab4391acbb4fbd0ad1a1f08d353b412224cc76fc3dead88a274662b1fd06b52c373aae4d0661b6e2b2b7b85ffb5242bc579815ea71782e5eb10833399f2ca423081cdefcfa77159bb4676e2ef0b800"
  };
  http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
  final extractedData = jsonDecode(response.body);
  if(response.statusCode == 200){
    List homeItemsList = extractedData['data'];
    List<Map<String, dynamic>> homeItems = List<Map<String, dynamic>>.from(homeItemsList[0]['zones']);
    List<dynamic> components = [];
    for (var item in homeItems) {
      switch (item['__component']) {
        case "sliders.slider-and-boxes":
          components.add(SliderAndBoxesModel.fromJson(item));
          break;
        case "global.list-icons":
          components.add(GlobalListIconsModel.fromJson(item));
          break;
        case "products.categories":
          components.add(ProductsCategoriesModel.fromJson(item));
          break;
        case "products.list-products":
          components.add(ProductsListProductsModel.fromJson(item));
          break;
        case "products.promo-banner":
          components.add(ProductsPromoBannerModel.fromJson(item));
          break;
        case "boxes.inline-boxes":
          components.add(BoxesInlineBoxesModel.fromJson(item));
          break;
        case "global.counter":
          components.add(GlobalCountersModel.fromJson(item));
          break;
        case "global.testimonials":
          components.add(GlobalTestimonialsModel.fromJson(item));
          break;
        case "global.broadcast":
          components.add(GlobalBroadcastModel.fromJson(item));
          break;
        default:
          debugPrint("Unknown component: ${item['__component']}");
      }
    }
    return components;
  }else{
    throw Exception("Error getting home items: ${extractedData['message']}");
  }
}

  static Future<List<ProductModel>> getProductsList(Map<String , String>? params)async {
  Uri url = Uri.https(
      authority,
      productsListPath,
      params
  );
  Map<String, String> headers = {
    "x-publishable-api-key": publishableKey
  };
  http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
  final extractedData = jsonDecode(response.body);
  if(response.statusCode == 200){
    List productList = extractedData['products'];
    print(productList.length);
    return productList.map((cat) =>  ProductModel.fromJson(cat)).toList();
  }else{
    throw Exception("Error getting products: ${extractedData['message']}");
  }
}

  static Future<List<CollectionModel>> getCollectionList() async {
  Uri url = Uri.https(
      authority,
      collectionPath,
  );
  Map<String, String> headers = {
    "x-publishable-api-key": publishableKey
  };
  http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
  final extractedData = jsonDecode(response.body);
  if(response.statusCode == 200){
    List items = extractedData['collections'];
    return items.map((e) => CollectionModel.fromJson(e)).toList();
  }else{
    throw Exception("Error getting collections: ${extractedData['message']}");
  }
}

  static Future<ProductDetailsModel> getProductDetails(String productId , String regionId)async {
    Uri url = Uri.https(
        authority,
        productsListPath,
        {'id' : productId,'region_id':regionId});
    Map<String, String> headers = {
      "x-publishable-api-key": publishableKey
    };
    http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
    final extractedData = jsonDecode(response.body);
    if(response.statusCode == 200){
      List products = extractedData['products'];
      print(products.length);
      return ProductDetailsModel.fromJson(products[0]);
    }else{
      throw Exception("Error getting products: ${extractedData['message']}");
    }
  }

}