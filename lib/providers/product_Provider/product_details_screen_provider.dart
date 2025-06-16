import 'package:bloom/api/cart_api_manager.dart';
import 'package:bloom/providers/cart_page_provider/cart_page_provider.dart';
import 'package:bloom/providers/profile_providers/customer_details_provider.dart';
import 'package:bloom/utils/api_manager.dart';
import 'package:bloom/utils/hive_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/cart_models/cart_model.dart';
import '../../models/local_storage_models/cart_model/cart_model.dart';

class ProductDetailsScreenProvider with ChangeNotifier{

  int quantity = 1;
  double price = 0.0;
  String selectedVariant = "";
  bool loading = false;

  setLoading(bool value){
    loading = value;
    notifyListeners();
  }

  setSelectedVariant(String newVariant){
    selectedVariant = newVariant;
    notifyListeners();
  }

  setPrice(double newPrice){
    price = newPrice;
    notifyListeners();
  }

  setQuantity(int newValue){
    if(newValue != 0){
      quantity = newValue;
      notifyListeners();
    }
  }


  Future<void> addToCart(BuildContext context, bool loggedIn, List<Map<String, dynamic>> items, String regionId) async {
    // Use try/finally to guarantee the loading state is always reset
    try {
      setLoading(true);

      String cartId = HiveStorageManager.getCartId();
      Cart? updatedCart;

      // Get customerId if logged in, otherwise it's null
      String? customerId = loggedIn ? context.read<CustomerDetailsProvider>().customerDetailsModel?.id : null;

      if (cartId.isEmpty) {
        // --- Case 1: No Cart Exists, Create a New One ---
        print("Creating a new cart...");
        updatedCart = await CartApiManager.createCart(
          regionId: regionId,
          items: items,
          customerId: customerId, // Pass customerId (it's null if guest)
        );
        rootNavigatorKey.currentState?.pop();
        Navigator.pop(context);
        quantity = 1;
      } else {
        // --- Case 2: Cart Exists, Add Items to It ---
        print("Adding items to existing cart: $cartId");
        // Loop through all items and add them one by one
        for (var item in items) {
          updatedCart = await CartApiManager.addToCart(
            cartId: cartId,
            variantId: item['variant_id'],
            quantity: item['quantity'],
          );
        }
        rootNavigatorKey.currentState?.pop();
        Navigator.pop(context);
        quantity = 1;
      }

      // After any successful operation, update the stored Cart ID and the Provider
      if (updatedCart != null) {
        HiveStorageManager.setCartId(updatedCart.id);
        if (context.mounted) {
          // More efficient: Set the provider state directly with the cart we already have
          context.read<CartPageProvider>().setCart(updatedCart);
        }
      }
    } catch (e) {
      // Handle any errors from the API calls
      print("Error in addToCart: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add item to cart. Please try again.")),
        );
      }
    } finally {
      // This will always be called, even if an error occurs
      setLoading(false);
    }
  }
}



