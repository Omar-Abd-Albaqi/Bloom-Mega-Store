import 'package:bloom/api/cart_api_manager.dart';
import 'package:bloom/models/cart_models/line_item_model.dart';
import 'package:bloom/models/cart_models/order_model.dart';
import 'package:bloom/models/cart_models/payment_collection_model.dart';
import 'package:bloom/models/cart_models/shipping_options_model.dart';
import 'package:bloom/models/customer_models/customer_details_model.dart';
import 'package:bloom/providers/profile_providers/customer_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart_models/address_model.dart';
import '../../models/cart_models/cart_model.dart';
import '../../route/route_constants.dart';
import '../../utils/hive_manager.dart';



class PaymentProviderModel{
  String id;
  bool isEnabled;
  PaymentProviderModel({
   required this.id,
   required this.isEnabled
});
  factory PaymentProviderModel.fromJson(Map<String, dynamic> json){
    return PaymentProviderModel(id: json['id'], isEnabled: json['is_enabled']);
  }

  @override
  String toString() {
    return 'PaymentProviderModel{id: $id, isEnabled: $isEnabled}';
  }
}

class CartPageProvider with ChangeNotifier{
  Cart? cart;
  Cart? originalCart;
  bool loading = false;
  bool needSave = false;
  bool updateLoading = false;
  List<ShippingOption>? shippingOptions;

  List<LineItem> cartItemsChanged = [];
  List<PaymentProviderModel> paymentProviders = [];
  PaymentCollection? paymentCollection;



  void changeItemQuantity(String itemId, int newQuantity) {
    Cart updatedCart = cart!.copyWith(
      items: cart!.items.map((item) {
        if (item.id == itemId) {
          return item.copyWith(quantity: newQuantity);
        }
        return item;
      }).toList(),
    );

    // If cart is unchanged (e.g. same as original), revert to null
    bool isSame = _isCartEqual(updatedCart, originalCart!);
    needSave = !isSame;
    cart = updatedCart;

    notifyListeners();
  }


  resetCart(){
    cart = originalCart;
    needSave = false;
    notifyListeners();
  }


  setCart(Cart newCart){
    originalCart = newCart;
    cart = originalCart;
    notifyListeners();
  }

  setLoading(bool value){
    loading = value;
    notifyListeners();
  }


  getCart(BuildContext context) async {
    setLoading(true);
    bool signedIn = HiveStorageManager.signedInNotifier.value;
    String cartId = "";
    if(signedIn){
      cartId = context.read<CustomerDetailsProvider>().customerDetailsModel!.metadata['cartId'] ?? "";
      if(cart == null || cartId.isEmpty){
        cartId = HiveStorageManager.getCartId();
      }
    }else{
      cartId = HiveStorageManager.getCartId();
    }
    if(cartId.isNotEmpty){
      originalCart = await CartApiManager.getCart(cartId);
      cart = originalCart;
      print(cart.toString());
    }
    setLoading(false);
  }


  Future<void> updateCartItems({
    required String cartId,
  }) async
  {
    updateLoading = true;
    notifyListeners();
    List<LineItem> updatedLineItems = getChangedLineItems();
    Cart? finalCartState;
    if (updatedLineItems.isEmpty) {
      throw ArgumentError("No line items provided for update.");
    }
    for (final lineItem in updatedLineItems) {
      try {
        finalCartState = await CartApiManager.updateLineItemQuantity(
          cartId: cartId,
          lineItemId: lineItem.id,
          quantity: lineItem.quantity,
        );
        print('Successfully updated item ${lineItem.id} to quantity ${lineItem.quantity}');
      } catch (e) {
        print("Failed to update line item ${lineItem.id}: $e");
        rethrow;
      }
    }
    if (finalCartState == null) {
      throw Exception("An unexpected error occurred: finalCartState is null.");
    }
    cart = finalCartState;
    originalCart = finalCartState;
    needSave = false;
   updateLoading = false;
    notifyListeners();
  }

  Future<void> addAddressToCart(BuildContext context,{required Address address}) async {
    setLoading(true);
    try{
      await CartApiManager.updateCartShippingAddress(address: address);
      if(context.mounted){
        getShippingOptions();
        Navigator.pushNamed(context, selectShippingOptionPath);
      }
    } catch (e){
      print(e);
    }

    setLoading(false);
  }

  Future<void> getShippingOptions() async {
    String cartId = HiveStorageManager.getCartId();
    final response = await CartApiManager.getShippingOptions(cartId);
    List data = response['shipping_options'];
    shippingOptions = data.map((e) => ShippingOption.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> setShippingOptions(BuildContext context, String optionId) async {
    setLoading(true);
    String cartId = HiveStorageManager.getCartId();
    try{
      await CartApiManager.addShippingMethodToCart(cartId: cartId, optionId: optionId);
      if(context.mounted){
        final paymentProviderResponse = await getPaymentMethod();
        if(paymentProviderResponse != null){
          paymentProviders = paymentProviderResponse;
          print(paymentProviders);
        }
        if(context.mounted){
          Navigator.pushNamed(context, paymentMethodScreenRoute, arguments: paymentProviders);
        }
      }
    } catch (e){
      print(e);
    }
    setLoading(false);
  }

  Future<List<PaymentProviderModel>?> getPaymentMethod() async {
    String regionId = cart?.regionId ?? "";
    try{
      final list = await CartApiManager.getPaymentProviders(regionId);
      return list.map((e) => PaymentProviderModel.fromJson(e)).toList();
    } catch (e){
      print(e);
      return null;
    }
  }

  Future<void> createAndInitializePayment(BuildContext context,String providerId) async {
    setLoading(true);
    String cartId = HiveStorageManager.getCartId();
    String collectionId = await CartApiManager.createPaymentCollection(cartId)??"";
    if(collectionId.isNotEmpty){
      paymentCollection = await CartApiManager.initializePaymentSession(collectionId, providerId);
      if(context.mounted){
        Navigator.pushNamed(context, paymentScreenRoutePath, arguments: paymentCollection);
      }
    }
    setLoading(false);
  }

  Future<void> completeOrder(BuildContext context) async {
    String cartId = HiveStorageManager.getCartId();
    setLoading(true);
    OrderModel? order = await CartApiManager.completeCart(cartId);

    setLoading(false);
    if(order != null){
      if(context.mounted){
        Navigator.pushNamed(context, thanksForOrderScreenRoute, arguments: order);
      }
    }


  }



  Future<void> linkCartToCustomer(BuildContext context) async {
    setLoading(true);
    CustomerDetailsModel customerDetailsModel = context.read<CustomerDetailsProvider>().customerDetailsModel!;
    if(customerDetailsModel.metadata['cartId'] == null || customerDetailsModel.metadata['cartId'].toString().isEmpty){
      if(HiveStorageManager.getCartId().isNotEmpty){
        String cartId = HiveStorageManager.getCartId();
        String customerEmail = customerDetailsModel.email;
        String customerToken = HiveStorageManager.getToken();
        CartApiManager.linkCartToUser(cartId: cartId, customerEmail: customerEmail, customerToken: customerToken);
      }
    }
    Navigator.pushNamed(context, choseAddressScreenPath);
    setLoading(false);
  }


  //Helpers
  //////////////////////////////////////////////////////////////////////////////
  List<LineItem> getChangedLineItems() {
    final List<LineItem> changedItems = [];
    final Map<String, LineItem> originalItemsMap = {
      for (var item in originalCart!.items) item.id: item,
    };
    for (final currentItem in cart!.items) {
      final originalItem = originalItemsMap[currentItem.id];
      if (originalItem == null) {
        changedItems.add(currentItem);
      } else if (currentItem.quantity != originalItem.quantity) {
        changedItems.add(currentItem);
      }
    }
    return changedItems;
  }

  bool _isCartEqual(Cart a, Cart b) {
    // A quick check for the most obvious difference.
    if (a.items.length != b.items.length) {
      return false;
    }

    // Create a Map of items from the original cart for easy lookup.
    // The key is the item ID, and the value is the quantity.
    final Map<String, int> originalItemsMap = {
      for (var item in b.items) item.id: item.quantity
    };

    // Loop through the items in the updated cart.
    for (final updatedItem in a.items) {
      // 1. Check if the original cart even has this item.
      if (!originalItemsMap.containsKey(updatedItem.id)) {
        return false; // An item was found that wasn't in the original.
      }

      // 2. Check if the quantity for this item is different.
      if (originalItemsMap[updatedItem.id] != updatedItem.quantity) {
        return false; // The quantity was changed.
      }
    }

    // If we get through the whole loop without returning, it means
    // every item and its quantity matched. The carts are equal.
    return true;
  }


  String _getCartId(BuildContext context){
    String localId = HiveStorageManager.getCartId();
    String cloudId = context.read<CustomerDetailsProvider>().customerDetailsModel?.metadata['cartId'] ?? "";
    if(cloudId.isNotEmpty){
      return cloudId;
    }else{
      return localId;
    }
  }
}