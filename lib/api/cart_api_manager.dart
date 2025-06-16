import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/cart_models/cart_model.dart';

class CartApiManager{

  static Future<Cart> createCart({
    required String regionId,
    List<Map<String, dynamic>>? items,
    String? customerId,
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
      if (customerId != null) 'customer_id': customerId,
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

  static Future<Cart> getCart({
    required String cartId,
  }) async
  {
    String getCartPath = 'store/carts/$cartId';
    Uri url = Uri.https(
      authority,
      getCartPath,
    );

    Map<String, String> headers = {
      "x-publishable-api-key": publishableKey,
    };

    try {
      final response = await http
          .get(
        url,
        headers: headers,
      )
          .timeout(const Duration(seconds: 10));

      final extractedData = jsonDecode(response.body);

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
    } catch (error) {
      // Rethrow the error or handle it more specifically
      // For example, you might want to differentiate between network errors and parsing errors
      throw Exception("Failed to get cart (ID: $cartId): $error");
    }
  }

  static Future<Cart> linkCartToUser({
    required String cartId,
    required String customerId,
  }) async
  {
    // Construct the specific endpoint for the cart to be updated
    final String specificCartPath = '$getCartPath/$cartId';
    final Uri url = Uri.https(authority, specificCartPath);

    // Prepare the headers and body for the POST request
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF--8',
    };

    final Map<String, String> body = {
      'customer_id': customerId,
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body), // http requires the body to be encoded
      );

      if (response.statusCode == 200) {
        // Decode the JSON response from the server
        final responseBody = jsonDecode(response.body);

        // The API returns an object with a 'cart' key, which contains the cart data
        final updatedCart = Cart.fromJson(responseBody['cart']);

        debugPrint('Successfully linked cart $cartId to customer $customerId');
        return updatedCart;
      } else {
        // Handle non-200 responses
        debugPrint('Failed to link cart. Status: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to link cart.');
      }
    } catch (e) {
      // Handle network errors or any other exceptions during the request
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
  }) async {
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

  static Future<Cart> deleteLineItem({
    required String cartId,
    required String lineItemId,
  }) async {
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
}