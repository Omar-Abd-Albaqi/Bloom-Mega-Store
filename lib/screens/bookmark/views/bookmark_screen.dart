import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/product/product_card.dart';
import '../../../models/product_model.dart';
import '../../../route/route_constants.dart';

import '../../../constants.dart';
import '../../../utils/loading.dart';

class PromotionScreen extends StatelessWidget {
  const PromotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // While loading use 👇
          //  BookMarksSlelton(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: defaultPadding,
                crossAxisSpacing: defaultPadding,
                childAspectRatio: 0.66,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ProductCard(
                    image: demoPopularProducts[index].image,
                    brandName: demoPopularProducts[index].brandName,
                    title: demoPopularProducts[index].title,
                    price: demoPopularProducts[index].price,
                    priceAfetDiscount:
                        demoPopularProducts[index].priceAfetDiscount,
                    dicountpercent: demoPopularProducts[index].dicountpercent,
                    press: () {
                      Navigator.pushNamed(context, productDetailsScreenRoute);
                    },
                  );
                },
                childCount: demoPopularProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class EmptyPromotionScreen extends StatelessWidget {
  const EmptyPromotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnPullRefreshWidget(
        onRefresh: () async {
          // await context.read<CartPageProvider>().getCart();
        },
        imagePath: 'assets/Transparent Logo.png',
        child: CustomScrollView(
          // This is the key change:
          // It combines the bouncing effect with the ability to always be scrollable.
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverFillRemaining( // Using SliverFillRemaining for centering
              hasScrollBody: false, // Set to false as we have a Column
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/promotion.svg",
                      height: 200,
                      color: Colors.black12,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    const SizedBox(height: defaultPadding),
                    const SizedBox(height: defaultPadding),
                    const Text(
                      "Coming\nSoon!",
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



