import 'dart:convert';

import 'package:bloom/api/auth_api_manager.dart';
import 'package:bloom/utils/hive_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/cart_models/address_model.dart';
import '../models/cart_models/cart_model.dart';
import '../models/cart_models/order_model.dart';
import '../models/cart_models/payment_collection_model.dart';

class CartApiManager{

  static Future<Cart> createCart({
    required String regionId,
    List<Map<String, dynamic>>? items,
  }) async
  {
    final url = Uri.https(authority, 'store/carts');

    final headers = {
      'Content-Type': 'application/json',
      // Publishable keys are okay for this public endpoint
      'x-publishable-api-key': publishableKey,
    };

    // Dynamically build the body. This is cleaner than having multiple if-statements.
    final Map<String, dynamic> body = {
      'region_id': regionId,
      // Add keys only if they are not null
      if (items != null) 'items': items,
    };

    try {
      final response = await http
          .post(
        url,
        headers: headers,
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 15));

      final extractedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // SUCCESS: Decode the response and return a structured Cart object.
        // The Medusa API returns the cart inside a "cart" key.
        return Cart.fromJson(extractedData['cart']);
      } else {
        // ERROR: Throw a more specific exception with the server message.
        final errorMessage = extractedData['message'] ??
            'Unknown error creating cart';
        throw Exception("Error creating cart: $errorMessage");
      }
    } catch (e) {
      // Handle timeouts or network errors
      throw Exception("Failed to connect or create cart: $e");
    }
  }

  static Future<Cart> getCart(String cartId,{String? token}) async
  {
    String getCartPath = 'store/carts/$cartId';
    Uri url = Uri.https(
      authority,
      getCartPath,
    );

    Map<String, String> headers = {
      "x-publishable-api-key": publishableKey,
      if(token != null)'Authorization': 'Bearer $token',
    };

    // try {
      final response = await http
          .get(
        url,
        headers: headers,
      )
          .timeout(const Duration(seconds: 10));

      final extractedData = jsonDecode(response.body);
      print(extractedData);
      if (response.statusCode == 200) {
        // Assuming the cart object is nested under a 'cart' key in the response,
        // as per the sample response you provided earlier.
        if (extractedData != null && extractedData['cart'] != null) {
          return Cart.fromJson(extractedData['cart']);
        } else {
          throw Exception("Failed to parse cart data: 'cart' key not found or data is null.");
        }
      } else {
        // Attempt to get a more specific error message from the API response
        String errorMessage = "Unknown error";
        if (extractedData != null && extractedData['message'] != null) {
          errorMessage = extractedData['message'];
        } else if (response.reasonPhrase != null) {
          errorMessage = response.reasonPhrase!;
        }
        throw Exception("Error getting cart (ID: $cartId): $errorMessage (Status Code: ${response.statusCode})");
      }
    // } catch (error) {
    //   // Rethrow the error or handle it more specifically
    //   // For thalesit, you might want to differentiate between network errors and parsing errors
    //   throw Exception("Failed to get cart (ID: $cartId): $error");
    // }
  }

  static Future<dynamic> testCart(String cartId) async {
    String getCartPath = 'store/carts/$cartId';
    Uri url = Uri.https(
      authority,
      getCartPath,
    );

    Map<String, String> headers = {
      "x-publishable-api-key": publishableKey,

    };

    final response = await http.get(url, headers: headers,)
        .timeout(const Duration(seconds: 10));
    return jsonDecode(response.body);

  }


  static Future<Cart> linkCartToUser({
    required String cartId,
    required String customerEmail,
    required String customerToken, // this is the JWT you got after login
  }) async
  {
    final String path = '/store/carts/$cartId/customer';
    final Uri url = Uri.https(authority, path);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $customerToken',
      'x-publishable-api-key': publishableKey,
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
      );
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final updatedCart = Cart.fromJson(responseBody['cart']);
        debugPrint('Successfully linked cart $cartId to customer $customerEmail');
        AuthApiManager.updateCustomer({
          'metadata': {
            'cartId' : cartId
          },
        });
        return updatedCart;
      } else {
        debugPrint('Failed to link cart. Status: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to link cart.');
      }
    } catch (e) {
      debugPrint('An error occurred while linking the cart: $e');
      throw Exception('An error occurred while linking the cart.');
    }
  }

  static Future<Cart> addToCart({
    required String cartId,
    required String variantId,
    required int quantity,
    Map<String, dynamic>? metadata,
  }) async
  {
    final url = Uri.https(authority, '/store/carts/$cartId/line-items');
    final headers = {
      'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
    };
    final body = {
      'variant_id': variantId,
      'quantity': quantity,
      if (metadata != null) 'metadata': metadata,
    };

    try {
      final response = await http.post(url, headers: headers, body: jsonEncode(body));
      final extractedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Cart.fromJson(extractedData['cart']);
      } else {
        throw Exception("Error adding item: ${extractedData['message']}");
      }
    } catch (e) {
      throw Exception("Failed to add item to cart: $e");
    }
  }

  static Future<Cart> updateLineItemQuantity({
    required String cartId,
    required String lineItemId,
    required int quantity,
  }) async
  {
    if (quantity < 0) throw ArgumentError("Quantity cannot be negative.");

    final url = Uri.https(authority, '/store/carts/$cartId/line-items/$lineItemId');
    final headers = {
      'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
    };
    final body = {'quantity': quantity};


      final response = await http.post(url, headers: headers, body: jsonEncode(body));
      final extractedData = jsonDecode(response.body);
      print(extractedData);
      if (response.statusCode == 200) {
        return Cart.fromJson(extractedData);
      } else {
        throw Exception("Error updating quantity: ${extractedData['message']}");
      }
  }

  static Future<Cart> deleteLineItem({
    required String cartId,
    required String lineItemId,
  }) async
  {
    // Construct the specific URL for the line item to be deleted
    final url = Uri.https(authority, '/store/carts/$cartId/line-items/$lineItemId');

    final headers = {
      'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
    };


    final response = await http.delete(url, headers: headers)
        .timeout(const Duration(seconds: 15));

    final extractedData = jsonDecode(response.body);

    print(extractedData);
    if (response.statusCode == 200) {
      // A successful deletion returns the updated cart
      return Cart.fromJson(extractedData);
    } else {
      final errorMessage = extractedData['message'] ?? 'Unknown error deleting item';
      throw Exception("Error deleting item: $errorMessage");
    }
  }

  static Future<Cart> updateCartDetails({
    required String cartId,
    String? regionId,
    String? email,
    String? discountCode,
  }) async
  {
    final url = Uri.https(authority, '/store/carts/$cartId');
    final headers = {
      'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
    };
    final body = {
      if (regionId != null) 'region_id': regionId,
      if (email != null) 'email': email,
      if (discountCode != null) 'discounts': [{'code': discountCode}],
    };

    if (body.isEmpty) {
      throw ArgumentError("At least one detail must be provided to update.");
    }

    try {
      final response = await http.post(url, headers: headers, body: jsonEncode(body));
      final extractedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Cart.fromJson(extractedData['cart']);
      } else {
        throw Exception("Error updating cart details: ${extractedData['message']}");
      }
    } catch (e) {
      throw Exception("Failed to update cart details: $e");
    }
  }

  static Future<Cart> updateCartShippingAddress({
    required Address address,
  }) async
  {
    final String cartId = HiveStorageManager.getCartId();
    final url = Uri.https(authority, '/store/carts/$cartId');
    final headers = {
      'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
    };
    final body = {
      'shipping_address': address.toJson(),
    };

    try {
      final response = await http.post(url, headers: headers, body: jsonEncode(body));
      final extractedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Cart.fromJson(extractedData['cart']);
      } else {
        throw Exception("Error updating shipping address: ${extractedData['message']}");
      }
    } catch (e) {
      throw Exception("Failed to update shipping address: $e");
    }
  }

  static Future<dynamic> getShippingOptions(String cartId) async {

    final Uri url = Uri.https(
        authority,
        gettingShippingOptionsPath,
        {"cart_id" : cartId}
    );

    final headers = {
      // 'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
    };
    final response = await http.get(url, headers: headers);
    final extractedData = json.decode(response.body);
    print(extractedData);
    if (response.statusCode == 200) {
      return extractedData;
    } else {
      // Handle error
      print('Failed to get shipping options: ${response.body}');
      return [];
    }
  }

  static Future<Cart?> addShippingMethodToCart({
    required String cartId,
    required String optionId,
  }) async
  {
    final Uri url = Uri.https(
      authority,
      '/store/carts/$cartId/shipping-methods',
    );

    final headers = {
      'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
    };

    final body = json.encode({
      "option_id": optionId,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      print("✅ Shipping method added");
      return Cart.fromJson(extractedData['cart']);
    } else {
      throw "❌ Failed to add shipping method: ${response.body}";
      // print("❌ Failed to add shipping method: ${response.body}");
      return null;
    }
  }

  static Future<List<dynamic>> getPaymentProviders(String regionId) async {
    final Uri url = Uri.https(
      authority,
      '/store/payment-providers',
      {'region_id': regionId},
    );

    final headers = {
      'x-publishable-api-key': publishableKey,
    };

    try {
      final response = await http.get(url, headers: headers);
      final extractedData = json.decode(response.body);

      if (response.statusCode == 200) {
        return extractedData['payment_providers'] ?? [];
      } else {
        print('Failed to get payment providers: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception while fetching payment providers: $e');
      return [];
    }
  }

  //this will returns String which is payment collection id to use it in the next API
  static Future<String?> createPaymentCollection(String cartId) async {
    final Uri url = Uri.https(authority, '/store/payment-collections');

    final headers = {
      'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
    };

    final body = jsonEncode({
      'cart_id': cartId,
      // 'region_id': regionId,
      // 'currency_code': currencyCode,
      // 'amount': amount
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final extractedData = json.decode(response.body);
      print(extractedData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Return the payment_collection ID
        return extractedData['payment_collection']?['id'];
      } else {
        print('Failed to create payment collection: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error creating payment collection: $e');
      return null;
    }
  }

  //
  static Future<PaymentCollection?> initializePaymentSession(
      String paymentCollectionId,
      String providerId,
      ) async
  {
    final Uri url = Uri.https(
      authority,
      '/store/payment-collections/$paymentCollectionId/payment-sessions',
    );

    final headers = {
      'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
    };

    final body = jsonEncode({
      'provider_id': providerId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print("Payment session response is: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final collection = PaymentCollection.fromJson(json['payment_collection']);
        print('Payment session initialized successfully.');
        return collection;
      } else {
        print('Failed to initialize payment session: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error initializing payment session: $e');
      return null;
    }
  }


  static Future<OrderModel?> completeCart(String cartId) async {
    final Uri url = Uri.https(authority, '/store/carts/$cartId/complete');
    final headers = {
      'x-publishable-api-key': publishableKey,
    };

    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      print(extractedData);
      OrderModel order = OrderModel.fromJson(extractedData['order']);
      HiveStorageManager.setCartId("");
      AuthApiManager.updateCustomer({
        'metadata': {
          'cartId' : ""
        },
      });
      return order;
    } else {
      print('Failed to complete cart: ${response.body}');
      return null;
    }
  }









  //maybe old version not used now
  static Future<Cart> setPaymentSession(String cartId) async {
    // POST /store/payment-collections/{id}/payment-sessions
    final Uri url = Uri.https(
      authority,
      '/store/carts/$cartId/payment-session',
    );

    final headers = {
      'x-publishable-api-key': publishableKey,
      // 'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers);
      print(response.reasonPhrase);
      print("failed to set a payment session with body: ${response.body}");
      final extractedData = json.decode(response.body);

      if (response.statusCode == 200) {
        return Cart.fromJson(extractedData['cart']);
      } else {
        throw Exception("Error setting payment session: ${extractedData['message']}");
      }
    } catch (e) {
      throw Exception("Failed to set payment session: $e");
    }
  }


  static Future<Cart> removeDiscountCode({
    required String cartId,
    required String discountCode,
  }) async {
    // Construct the specific URL for the discount to be deleted
    final url = Uri.https(authority, '/store/carts/$cartId/discounts/$discountCode');

    final headers = {
      'Content-Type': 'application/json',
      'x-publishable-api-key': publishableKey,
    };

    try {
      // Use the http.delete method for this request
      final response = await http.delete(url, headers: headers)
          .timeout(const Duration(seconds: 15));

      final extractedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // A successful deletion returns the updated cart
        return Cart.fromJson(extractedData['cart']);
      } else {
        final errorMessage = extractedData['message'] ?? 'Unknown error removing discount';
        throw Exception("Error removing discount: $errorMessage");
      }
    } catch (e) {
      throw Exception("Failed to connect or remove discount: $e");
    }
  }


  static Future<Map<String, dynamic>> getSalesChannels() async {
    final url = Uri.https(authority, 'admin/sales-channels');

    final headers = {
      'Content-Type': 'application/json',
      // 'x-publishable-api-key': publishableKey,
    };


      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return {};
      }
  }




}