import 'dart:convert';

import 'package:bloom/models/home_items_models/sliders_wide_sliders.dart';
import 'package:bloom/models/cart_models/region_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../models/category_model.dart';
import '../../../models/customer_model.dart';
import '../../../models/customer_models/customer_details_model.dart';
import '../../../models/home_items_models/collection_model.dart';
import '../../../models/product_details_model.dart';
import '../../../utils/hive_manager.dart';

import '../models/cart_models/address_model.dart';
import '../models/cart_models/cart_model.dart';
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
        case "sliders.wide-sliders":
          components.add(SlidersWideSliders.fromJson(item));
        case "global.counter":
          components.add(GlobalCountersModel.fromJson(item));
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
    print(extractedData);
    if(response.statusCode == 200){
      List products = extractedData['products'];
      return ProductDetailsModel.fromJson(products[0]);
    }else{
      throw Exception("Error getting products: ${extractedData['message']}");
    }
  }

 static Future<List<Region>> getRegion() async {
    Map<String, dynamic> params = {
      "offset": "0",
      "limit": "999"
    };
    Uri url = Uri.https(
        authority,
        regionPath,
        params
    );
    Map<String, String> headers = {
      "x-publishable-api-key": publishableKey
    };
    print(url);
    http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
    print(response.body);
    final extractedData = jsonDecode(response.body);
    if(response.statusCode == 200){
      List regionsList = extractedData['regions'];
      return regionsList.map((region) =>  Region.fromJson(region)).toList();
    }else{
      throw Exception("Error getting Regions: ${extractedData['message']}");
    }
  }



 static Future<List<Address>> getAddresses() async {
   String token = HiveStorageManager.getToken(); // Ensure this gets a valid token
   Uri url = Uri.https(
     authority, // Your shop's domain e.g., 'shop.bloommegastore.com'
     getCustomerAddressesPath, // e.g., '/store/customers/me/addresses'
     // No queryParameters for 'fields' here based on documentation
   );
   Map<String, String> headers = {
     'Content-Type': 'application/json',
     'x-publishable-api-key': publishableKey, // Ensure this is correct
     "Authorization": "Bearer $token"
   };

   print('Requesting Addresses from: $url');
   http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 15));
   print('Get Addresses Response Status: ${response.statusCode}');
   print('Get Addresses Response Body: ${response.body}');

   final extractedData = jsonDecode(response.body);
print(extractedData);
   if (response.statusCode == 200) {
     // Your existing logic for parsing based on response structure
     if (extractedData.containsKey('customer') && extractedData['customer'].containsKey('shipping_addresses')) {
       List addressesList = extractedData['customer']['shipping_addresses'];
       return addressesList.map((addressJson) => Address.fromJson(addressJson)).toList();
     } else if (extractedData.containsKey('addresses')) { // This is a common structure
       List addressesList = extractedData['addresses'];
       return addressesList.map((addressJson) => Address.fromJson(addressJson)).toList();
     } else {
       print('Addresses key not found in response, but status is 200. Response: $extractedData');
       // Consider what to do if the structure is unexpected but status is 200
       // For example, if extractedData itself is the list:
       // if (extractedData is List) {
       //   return extractedData.map((addressJson) => Address.fromJson(addressJson)).toList();
       // }
       return []; // Or throw an error indicating unexpected format
     }
   } else {
     // The error message from extractedData might give more clues
     String errorMessage = "Error getting Addresses: ${response.reasonPhrase}";
     if (extractedData != null && extractedData is Map && extractedData.containsKey('message')) {
       errorMessage = "Error getting Addresses: ${extractedData['message']}";
     } else if (extractedData != null && extractedData is Map && extractedData.containsKey('type') && extractedData.containsKey('message')) {
       errorMessage = "Error getting Addresses (${extractedData['type']}): ${extractedData['message']}";
     }
     throw Exception(errorMessage);
   }
 }

 static Future<Address> updateAddress(String addressId, Address addressData) async {
   String token = HiveStorageManager.getToken();
   final String path = '$getCustomerAddressesPath/$addressId';
   Uri url = Uri.https(
     authority,
     path,
   );
   Map<String, String> headers = {
     'Content-Type': 'application/json',
     'x-publishable-api-key': publishableKey,
     "Authorization": "Bearer $token"
   };

   String body = jsonEncode(addressData.toJson());

   print('Updating Address at: $url with body: $body');
   http.Response response = await http.post(url, headers: headers, body: body).timeout(const Duration(seconds: 15));
   print('Update Address Response Status: ${response.statusCode}');
   print('Update Address Response Body: ${response.body}');

   final extractedData = jsonDecode(response.body);

   if (response.statusCode == 200) {
     if (extractedData.containsKey('address')) {
       return Address.fromJson(extractedData['address']);
     } else {
       throw Exception("Updated address key not found in response. Response: $extractedData");
     }
   } else {
     throw Exception("Error updating Address $addressId: ${extractedData['message'] ?? response.reasonPhrase}");
   }
 }

 static Future<Address> createNewAddress(Address newAddressData) async {
   String token = HiveStorageManager.getToken();
   Uri url = Uri.https(
     authority,
     getCustomerAddressesPath,
   );
   Map<String, String> headers = {
     'Content-Type': 'application/json',
     'x-publishable-api-key': publishableKey,
     "Authorization": "Bearer $token"
   };

   String body = jsonEncode(newAddressData.toJson());

   print('Creating New Address at: $url with body: $body');
   http.Response response = await http.post(url, headers: headers, body: body).timeout(const Duration(seconds: 15));
   print('Create New Address Response Status: ${response.statusCode}');
   print('Create New Address Response Body: ${response.body}');

   final extractedData = jsonDecode(response.body);

   if (response.statusCode == 200) {
     if (extractedData.containsKey('address')) {
       return Address.fromJson(extractedData['address']);
     } else {
       throw Exception("Created address key not found in response. Response: $extractedData");
     }
   } else {
     throw Exception("Error creating new Address: ${extractedData['message'] ?? response.reasonPhrase}");
   }
 }

 static Future<void> deleteAddress(String addressId) async {
   String token = HiveStorageManager.getToken();
   final String path = '$getCustomerAddressesPath/$addressId';
   Uri url = Uri.https(
     authority,
     path,
   );
   Map<String, String> headers = {
     'Authorization': 'Bearer $token',
   };

   print('Deleting Address at: $url with auth token');
   http.Response response = await http.delete(url, headers: headers).timeout(const Duration(seconds: 15));
   print('Delete Address Response Status: ${response.statusCode}');
   print('Delete Address Response Body: ${response.body}');

   if (response.statusCode == 200) {
     // Successfully deleted. Medusa might return a body like:
     // { "id": "addr_...", "object": "address", "deleted": true, "parent": "customer" }
     // You can parse it if needed, but for a delete operation, a 200 status is often sufficient confirmation.
     final extractedData = jsonDecode(response.body);
     if (extractedData != null && extractedData['id'] == addressId && extractedData['deleted'] == true) {
       print('Address $addressId successfully deleted.');
       return; // Success
     } else {
       // Still a 200, but response format might be unexpected.
       // Depending on strictness, you could treat this as success or log a warning.
       print('Address $addressId deletion returned 200, but response format was unexpected: $extractedData');
       return; // Assuming 200 means success.
     }
   } else if (response.statusCode == 401) {
     throw Exception("Unauthorized: Invalid or expired token. Please log in again. (${response.statusCode})");
   } else {
     final extractedData = jsonDecode(response.body);
     throw Exception("Error deleting Address $addressId: ${extractedData['message'] ?? response.reasonPhrase} (${response.statusCode})");
   }
 }


 Future<List<ProductModel>> searchProducts({
   required String query,
   int offset = 0,
   int limit = 999,
   Map<String, dynamic>? filter,
 }) async
 {
   Uri url = Uri.https(
     authority,
     productSearchPath,
   );

   Map<String, String> headers = {
     "Content-Type": "application/json",
     // "x-publishable-api-key": publishableKey,
   };

   Map<String, dynamic> requestBody = {
     "q": query,
     "offset": offset,
     "limit": limit,
   };

   if (filter != null) {
     requestBody["filter"] = filter;
   }

   print("Requesting URL (POST): $url");
   print("Request Body: ${jsonEncode(requestBody)}");

   try {
     http.Response response = await http.post(
       url,
       headers: headers,
       body: jsonEncode(requestBody), // Encode body as JSON
     ).timeout(const Duration(seconds: 15));

     print("Response Status Code: ${response.statusCode}"); // For debugging
     print("Response Body: ${response.body}"); // For debugging

     final extractedData = jsonDecode(response.body);

     if (response.statusCode == 200) {
       // The search results are typically under the 'hits' key for POST /store/products/search
       // The items within 'hits' are the product objects themselves.
       if (extractedData.containsKey('hits') && extractedData['hits'] is List) {
         List searchHits = extractedData['hits'];
         return searchHits
             .map((productJson) => ProductModel.fromJson(productJson as Map<String, dynamic>))
             .toList();
       } else {
         // Fallback or handle cases where 'hits' might be missing or not a list,
         // or if your search adapter returns products directly under a 'products' key (less common for search).
         print("'hits' key not found or not a list in search response. Response: $extractedData");
         return []; // Or throw an exception
       }
     } else {
       String errorMessage = "Unknown error";
       if (extractedData != null && extractedData is Map) {
         errorMessage = extractedData['message'] ?? extractedData['type'] ?? extractedData.toString();
       }
       throw Exception("Error searching Products (Status ${response.statusCode}): $errorMessage");
     }
   } catch (e) {
     print("Error in searchProducts: $e");
     if (e is FormatException) {
       throw Exception("Failed to parse search response: $e");
     }
     throw Exception("Failed to search products: $e");
   }
 }



}

