import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../components/product/product_card.dart';
import '../../../../models/product_model.dart';
import '../../../../providers/home_page_provider/category_provider.dart';
import '../../../../route/screen_export.dart';
import '../../../../utils/api_manager.dart';

import '../../../../components/skleton/product/products_skelton.dart';
import '../../../../constants.dart';
import '../../../../models/local_storage_models/product_model/product_model.dart';

class ProductBanner extends StatelessWidget {
  const ProductBanner({
    super.key,
    this.title = ""
  });
  final String? title;

  @override
  Widget build(BuildContext context) {
    String collectionID = context.read<CategoryProvider>().collections.firstWhere((element) => element.title == title).id;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            title!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        FutureBuilder<List<ProductModel>>(
            future: ApiManager.getProductsList({"limit" : "8","region_id":"reg_01JK96E8Y9KM1Y14S916J0KJKC", "collection_id" : collectionID}),
          builder: (_, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const ProductsSkelton();
            }
            return SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // Find demoPopularProducts on models/ProductModel.dart
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ProductModel product = snapshot.data![index];
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
                      price: product.variants[0].calculatedPrice!.calculatedAmount.toDouble(),
                      priceAfetDiscount: null,
                      dicountpercent: null,
                      press: () {
                        Navigator.pushNamed(context, productDetailsScreenRoute, arguments: {'productId' : product});
                      },
                    ),
                  );
                }
              ),
            );
          }
        )
      ],
    );
  }
}
