import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../models/local_storage_models/product_model/product_model.dart';
import '../../../../utils/hive_manager.dart';

import '../../../../components/product/product_card.dart';
import '../../../../constants.dart';
import '../../../../models/product_model.dart';
import '../../../../route/route_constants.dart';

class FavoriteBanner extends StatelessWidget {
  const FavoriteBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Favorites ",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, favoriteScreenRoute);
                },
                child: const Row(
                  children:  [
                    Text("Show All",style: TextStyle(color: Colors.black45 , fontSize: 14,),),
                    SizedBox(width: defaultPadding /4,),
                    Icon(Icons.keyboard_double_arrow_right_rounded, color: Colors.black45, size: 20)
                  ],
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<Box<ProductModel>>(
            valueListenable: HiveStorageManager.favoriteListenable(),
            builder: (_, box, child) {
              final favorites = box.values.toList();
              return SizedBox(
                height: 220,
                child: favorites.isNotEmpty ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // Find demoPopularProducts on models/ProductModel.dart
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      ProductModel product = favorites[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: defaultPadding,
                          right: index == demoPopularProducts.length - 1
                              ? defaultPadding
                              : 0,
                        ),
                        child: ProductCard(
                          image: product.thumbnail,
                          brandName: product.type.value,
                          title: product.title,
                          price: product
                              .variants[0].calculatedPrice!.calculatedAmount
                              .toDouble(),
                          priceAfetDiscount: null,
                          dicountpercent: null,
                          press: () {
                            Navigator.pushNamed(
                                context, productDetailsScreenRoute,
                                arguments: {'productId': product.id});
                          },
                        ),
                      );
                    }) : Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 162,
                      width: double.infinity,
                    ),
                    SizedBox(
                        width: 250,
                        child: Image.asset("assets/icons/heart_bold.png" , color: Colors.grey.withAlpha(20),fit: BoxFit.contain,)),
                    Align(
                      alignment: const Alignment(0, -0.3),
                      child: Text("Your favorites are empty", textAlign: TextAlign.center,style: TextStyle(fontSize: 20, color: Colors.black.withAlpha(200), fontWeight: FontWeight.w600),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                      child: Align(
                        alignment: const Alignment(0, 0.2),
                        child:  Text("Tab the heart icon on any product to make it your favorite!", textAlign: TextAlign.center,style: TextStyle(fontSize: 14, color: Colors.black.withAlpha(200), fontWeight: FontWeight.w500),),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
