import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../providers/product_Provider/product_list_provider.dart';

import '../../components/product/product_card.dart';
import '../../constants.dart';
import '../../models/local_storage_models/product_model/product_model.dart';
import '../../route/route_constants.dart';
import '../bookmark/component/bookmarks_skelton.dart';
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key, required this.catId});
  final String catId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductListProvider()..getCategoryProductsList(catId),
      child: Scaffold(
        appBar: AppBar(
          // pinned: true,
          // floating: true,
          // snap: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // leading: const SizedBox(),
          // leadingWidth: 0,
          centerTitle: false,
          // title: Image.asset(
          //   "assets/Bloom-04.png",
          //   width: 100,
          // ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, searchScreenRoute);
              },
              icon: SvgPicture.asset(
                "assets/icons/Search.svg",
                height: 24,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).textTheme.bodyLarge!.color!,
                    BlendMode.srcIn),
              ),
            ),
            IconButton(
              onPressed: () async {
                // context.read<CategoryProvider>().getCategories();
                // Navigator.pushNamed(context, brandScreenRoute);
              },
              icon: SvgPicture.asset(
                "assets/icons/Notification.svg",
                height: 24,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).textTheme.bodyLarge!.color!,
                    BlendMode.srcIn),
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: kToolbarHeight)),
            Selector<ProductListProvider, List<ProductModel>?>(
              selector: (_, prov) => prov.products,
              builder: (_, products, child) {
                if (products == null) {
                  return const BookMarksSlelton();
                } else if (products.isEmpty) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text("No result")),
                  );
                } else {
                  return SliverPadding(
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
                            price: product.variants[0].calculatedPrice!.calculatedAmount.toDouble(),
                            priceAfetDiscount: null,
                            dicountpercent: null,
                            press: () {
                              // ProductDetailsModel product = await ApiManager.getProductDetails(products[index].id.toString());
                              Navigator.pushNamed(context, productDetailsScreenRoute,arguments: {'productId': products[index]});
                            },
                          );
                        },
                        childCount: products.length,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),

      ),
    );
  }
}
