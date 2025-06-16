import 'package:flutter/material.dart';

import '../../../components/product/product_card.dart';
import '../../../constants.dart';
import '../../../route/route_constants.dart';
import '../../../utils/hive_manager.dart';
import '../../../models/local_storage_models/product_model/product_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
          valueListenable: HiveStorageManager.favoriteListenable(),
          builder: (_, productsBox, child) {
            List<ProductModel> products = productsBox.values.toList();
            if(productsBox.isEmpty){
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                  ),
                  SizedBox(
                      width: 250,
                      child: Image.asset("assets/icons/heart_bold.png" , color: Colors.grey.withAlpha(20),fit: BoxFit.contain,)),
                  Align(
                    alignment: const Alignment(0, -0.1),
                    child: Text("Your favorites are empty", textAlign: TextAlign.center,style: TextStyle(fontSize: 20, color: Colors.black.withAlpha(200), fontWeight: FontWeight.w600),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                    child: Align(
                      alignment: const Alignment(0, 0.1),
                      child:  Text("Tab the heart icon on any product to make it your favorite!", textAlign: TextAlign.center,style: TextStyle(fontSize: 14, color: Colors.black.withAlpha(200), fontWeight: FontWeight.w500),),
                    ),
                  ),
                ],
              );
            }
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(defaultPadding),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: defaultPadding,
                      crossAxisSpacing: defaultPadding,
                      childAspectRatio: 0.66,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = products[index];
                        return ProductCard(
                          image: product.thumbnail,
                          brandName: product.type.value,
                          title: product.title,
                          price: product
                              .variants[0].calculatedPrice!.calculatedAmount
                              .toDouble(),
                          priceAfetDiscount: null,
                          dicountpercent: null,
                          press: () {
                            // ProductDetailsModel product = await ApiManager.getProductDetails(products[index].id.toString());
                            Navigator.pushNamed(
                                context, productDetailsScreenRoute,
                                arguments: {'productId': products[index].id});
                          },
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
