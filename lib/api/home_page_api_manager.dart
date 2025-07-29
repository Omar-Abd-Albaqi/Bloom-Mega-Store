import 'dart:convert';

import 'package:bloom/providers/home_page_provider/home_items_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/home_items_models/main_models/boxes_inline_boxes_model.dart';
import '../models/home_items_models/main_models/global_brands_box.dart';
import '../models/home_items_models/main_models/product_product_category.dart';
import '../models/home_items_models/main_models/products_categories.dart';
import '../models/home_items_models/main_models/products_list_products.dart';
import '../models/home_items_models/main_models/sliders_wide_sliders.dart';

class HomePageApiManager {
  static Future<List<dynamic>> getHomeItems(BuildContext context) async {
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


          /*
          case "sliders.slider-and-boxes":
            components.add(SliderAndBoxesModel.fromJson(item));
            break;

          case "global.list-icons":
            components.add(GlobalListIconsModel.fromJson(item));
            break;

          case "products.categories":
            components.add(ProductsCategoriesModel.fromJson(item));
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

        case "products.promo-banner":
          components.add(ProductsPromoBannerModel.fromJson(item));
          break;
          */


          case "products.list-products":
            components.add(ProductsListProductsModel.fromJson(item));
            break;

          case "boxes.inline-boxes":
            components.add(BoxesInlineBoxesModel.fromJson(item));
            break;

          case "sliders.wide-sliders":
            components.add(SlidersWideSliders.fromJson(item));
            break;

          case "global.brands-box":
            components.add(GlobalBrandsBoxModel.fromJson(item));
            break;

          case "products.products-category":
            components.add(ProductsProductsCategory.fromJson(item));
            break;

          case "products.categories":
            components.add(ProductsCategoriesModel.fromJson(item));
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
}