import 'package:flutter/material.dart';
import '../../../components/Banner/L/banner_l_style_1.dart';
import '../../../components/Banner/S/banner_s_style_1.dart';
import '../../../components/Banner/S/banner_s_style_4.dart';
import '../../../components/shopping_bag.dart';
import '../../../constants.dart';
import '../../../screens/home/views/components/best_sellers.dart';
import '../../../screens/home/views/components/flash_sale.dart';
import '../../../screens/home/views/components/most_popular.dart';

class OnSaleScreen extends StatelessWidget {
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              title: Text("On Sale"),
              actions: [
                ShoppingBag(
                  numOfItem: 3,
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: BannerLStyle1(
                image: "https://i.imgur.com/5hofImS.png",
                title: "SUMMER \nSALE",
                subtitle: "SPECIAL OFFER",
                discountPercent: 50,
                press: () {},
              ),
            ),
            const SliverToBoxAdapter(
              child: BestSellers(),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(top: defaultPadding),
              sliver: SliverToBoxAdapter(
                child: FlashSale(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    BannerSStyle1(
                      image: "https://i.imgur.com/JLTfORi.png",
                      title: "New \narrival",
                      subtitle: "SPECIAL OFFER",
                      discountParcent: 50,
                      press: () {},
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    BannerSStyle4(
                      image: "https://i.imgur.com/vx3FfTJ.png",
                      title: "SUMMER \nSALE",
                      subtitle: "SPECIAL OFFER",
                      bottomText: "UP TO 80% OFF",
                      press: () {},
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    BannerSStyle4(
                      image: "https://i.imgur.com/g2cQFBs.png",
                      title: "Black \nfriday",
                      subtitle: "50% off",
                      bottomText: "Collection".toUpperCase(),
                      press: () {},
                    ),
                  ],
                ),
              ),
            ),
            // const SliverToBoxAdapter(
            //   child: ProductBanner(),
            // ),
            const SliverToBoxAdapter(
              child: MostPopular(),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: defaultPadding),
              sliver: SliverToBoxAdapter(
                child: BannerLStyle1(
                  image: "https://i.imgur.com/u01Opt8.png",
                  title: "SUMMER \nSALE",
                  subtitle: "SPECIAL OFFER",
                  discountPercent: 50,
                  press: () {},
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: BestSellers(),
            ),
          ],
        ),
      ),
    );
  }
}
