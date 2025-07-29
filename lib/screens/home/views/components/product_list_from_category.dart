import 'package:bloom/models/category_model.dart';
import 'package:bloom/providers/home_page_provider/home_items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../components/product/product_card.dart';
import '../../../../constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../models/local_storage_models/product_model/product_model.dart';
import '../../../../models/product_model.dart';
import '../../../../route/route_constants.dart';

class ProductListFromCategory extends StatelessWidget {
  const ProductListFromCategory({
    super.key,
    required this.category,  this.forRefresh = false
  });
  final CategoryModel category;
  final bool? forRefresh;

  @override
  Widget build(BuildContext context) {

    if(forRefresh ?? false){
      WidgetsBinding.instance.addPostFrameCallback((_){
          context.read<HomeItemsProvider>().getProductListFromCategory( category.medusaId.toString());
      });
    }
    return Selector<HomeItemsProvider,Map<String, List<ProductModel>> >(
      selector: (_, prov) => prov.productsByCategory,
      builder: (_, productsMap, child) {
        List<ProductModel> products = productsMap[category.medusaId] ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding / 2),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Text(
                L10n.getLocalizedCategory(context, category.name),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),

            // for loading call
            // const ProductsSkelton(),

             SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // Find demoPopularProducts on models/ProductModel.dart
                itemCount: products.length,
                itemBuilder: (context, index) {
                  ProductModel product = products[index];
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
                        Navigator.pushNamed(context, productDetailsScreenRoute, arguments: {'productId' : product.id.toString()});
                      },
                    ),
                  );
                }
              ),
            ),
            const SizedBox(height: defaultPadding,)
          ],
        );
      }
    );
  }
}
