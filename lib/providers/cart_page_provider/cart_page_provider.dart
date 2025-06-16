import 'package:bloom/api/cart_api_manager.dart';
import 'package:bloom/models/cart_models/line_item_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../models/cart_models/cart_model.dart';
import '../../utils/hive_manager.dart';


class CartPageProvider with ChangeNotifier{
  Cart? cart;
  Cart? originalCart;
  bool loading = false;
  bool stateChanged = false;

  List<LineItem> cartItemsChanged = [];


  checkStateChanges(){
    stateChanged =  cart != originalCart;
    print(stateChanged);
    notifyListeners();
  }


  setCart(Cart newCart){
    cart = newCart;
    originalCart = newCart;
    notifyListeners();
  }

  setLoading(bool value){
    loading = value;
    notifyListeners();
  }


  getCart() async {
    setLoading(true);
    String cartId = HiveStorageManager.getCartId();
    if(cartId.isNotEmpty){
      setLoading(true);
      cart = await CartApiManager.getCart(cartId: cartId);
      originalCart = cart;
      print(cart.toString());
      setLoading(false);
    }
  }


}