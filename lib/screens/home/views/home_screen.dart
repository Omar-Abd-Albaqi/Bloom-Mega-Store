import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/Banner/L/banner_l_style_1.dart';
import '../../../components/Banner/S/banner_s_style_1.dart';
import '../../../components/Banner/S/banner_s_style_4.dart';
import '../../../components/Banner/S/banner_s_style_5.dart';
import '../../../constants.dart';
import '../../../models/home_items_models/boxes_inline_boxes_model.dart';
import '../../../models/home_items_models/global_list_icons_model.dart';
import '../../../models/home_items_models/products_categories.dart';
import '../../../models/home_items_models/products_list_products.dart';
import '../../../models/home_items_models/products_promo_banner.dart';
import '../../../providers/entry_point_providers/nav_bar_provider.dart';
import '../../../providers/home_page_provider/home_items_provider.dart';
import '../../../route/screen_export.dart';

import '../../../components/skleton/skelton.dart';
import '../../../models/home_items_models/slider_items_model.dart';
import 'components/best_sellers.dart';
import 'components/flash_sale.dart';
import 'components/most_popular.dart';
import 'components/offer_carousel_and_categories.dart';
import 'components/popular_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Selector<HomeItemsProvider ,List<dynamic>>(
          selector: (_, prov)=> prov.homeModels,
          builder: (_, data, child) {
            if(data == null || data.isEmpty){
              return const CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: OffersCarouselAndCategories(sliderAndBoxesModel: null),
                    ),
                    SliverToBoxAdapter(
                    child: ProductCategoriesWidget(globalListIconsModel: null),
                    ),

                  ]
              );
            }
              return CustomScrollView(
                slivers: data.map<Widget>((item) {
                  switch (item) {
                    case SliderAndBoxesModel model:
                      return SliverToBoxAdapter(
                        child: OffersCarouselAndCategories(sliderAndBoxesModel: model),
                      );
                    case GlobalListIconsModel model:
                      return SliverToBoxAdapter(
                        child: ProductCategoriesWidget(globalListIconsModel: model),
                      );
                    case ProductsCategoriesModel model:
                      return SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Categories",
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      context.read<NavBarProvider>().setIndex(1);
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
                            AspectRatio(
                              aspectRatio: 2.6,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.separated(
                                  padding: const EdgeInsets.all(defaultPadding / 2),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.categories.length,
                                  itemBuilder: (_ , index) {
                                    return AspectRatio(
                                      aspectRatio: 0.8,
                                      child: GestureDetector(
                                        // splashColor: Colors.white.withOpacity(0.3),
                                        // highlightColor: Colors.white.withOpacity(0.1),
                                        // behavior: HitTestBehavior.opaque,
                                        onTap: (){
                                          // print(model.categories[index]);
                                          // context.read<ProductListProvider>().getCategoryProductsList(model.categories[index].id.toString());
                                          Navigator.pushNamed(context, productListScreenRoute, arguments: model.categories[index].id.toString());
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: model.categories[index].icon.url,
                                                fit: BoxFit.cover,
                                                imageBuilder: (context, imageProvider) => Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.softLight),
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) => const Skeleton(),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                              ),
                                              Align(
                                                alignment: const Alignment(0, 0.9),
                                                child: Text(
                                                  model.categories[index].name,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );


                                  },
                                  separatorBuilder: (_ , index){
                                    return const SizedBox(width: defaultPadding / 2);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    case ProductsListProductsModel model:
                      return SliverToBoxAdapter(child: ProductBanner(title: model.title,));
                    case ProductsPromoBannerModel model:
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                          child: BannerSStyle4(
                            image: model.cover.formats!['thumbnail']['url'],
                            subtitle: model.ctaText,
                            title: model.title,
                            bottomText: model.legend,
                            press: () {
                              Navigator.pushNamed(context, onSaleScreenRoute);
                            },
                          ),
                        ),
                      );
                    case BoxesInlineBoxesModel model:
                      return SliverToBoxAdapter(
                        child: InlineBoxesWidget(inlineBoxes: model.items),
                      );
                    default:
                      return const SliverToBoxAdapter(child: SizedBox());
                  }
                }).toList(),
              );
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: OffersCarouselAndCategories(sliderAndBoxesModel: null,)),
                  const SliverToBoxAdapter(child: ProductBanner()),
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
                    sliver: SliverToBoxAdapter(child: FlashSale()),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        // While loading use 👇
                        // const BannerMSkelton(),‚
                        BannerSStyle1(
                          title: "New \narrival",
                          subtitle: "SPECIAL OFFER",
                          discountParcent: 50,
                          press: () {
                            Navigator.pushNamed(context, onSaleScreenRoute);
                          },
                        ),
                        const SizedBox(height: defaultPadding / 4),
                        // While loading use 👇
                        //  const BannerMSkelton(),
                        BannerSStyle4(
                          image: "https://i.imgur.com/vx3FfTJ.png",
                          title: "SUMMER \nSALE",
                          subtitle: "SPECIAL OFFER",
                          bottomText: "UP TO 80% OFF",
                          press: () {
                            Navigator.pushNamed(context, onSaleScreenRoute);
                          },
                        ),
                        const SizedBox(height: defaultPadding / 4),
                        // While loading use 👇
                        //  const BannerMSkelton(),
                        BannerSStyle4(
                          image: "https://i.imgur.com/dBrsD0M.png",
                          title: "Black \nfriday",
                          subtitle: "50% off",
                          bottomText: "Collection".toUpperCase(),
                          press: () {
                            Navigator.pushNamed(context, onSaleScreenRoute);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(child: BestSellers()),
                  const SliverToBoxAdapter(child: MostPopular()),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: defaultPadding * 1.5),
                        // While loading use 👇
                        // const BannerLSkelton(),
                        BannerLStyle1(
                          title: "Summer \nSale",
                          subtitle: "SPECIAL OFFER",
                          discountPercent: 50,
                          press: () {
                            Navigator.pushNamed(context, onSaleScreenRoute);
                          },
                        ),
                        const SizedBox(height: defaultPadding / 4),
                        // While loading use 👇
                        // const BannerSSkelton(),
                        BannerSStyle5(
                          title: "Black \nfriday",
                          subtitle: "50% Off",
                          bottomText: "Collection".toUpperCase(),
                          press: () {
                            Navigator.pushNamed(context, onSaleScreenRoute);
                          },
                        ),
                        const SizedBox(height: defaultPadding / 4),
                        // While loading use 👇
                        // const BannerSSkelton(),
                        BannerSStyle5(
                          image: "https://i.imgur.com/2443sJb.png",
                          title: "Grab \nyours now",
                          subtitle: "65% Off",
                          press: () {
                            Navigator.pushNamed(context, onSaleScreenRoute);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(child: BestSellers()),
                ],
              );
          },
        ),
      ),
    );
  }
}

/*
[
                const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
                const SliverToBoxAdapter(child: PopularProducts()),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
                  sliver: SliverToBoxAdapter(child: FlashSale()),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // While loading use 👇
                      // const BannerMSkelton(),‚
                      BannerSStyle1(
                        title: "New \narrival",
                        subtitle: "SPECIAL OFFER",
                        discountParcent: 50,
                        press: () {
                          Navigator.pushNamed(context, onSaleScreenRoute);
                        },
                      ),
                      const SizedBox(height: defaultPadding / 4),
                      // While loading use 👇
                      //  const BannerMSkelton(),
                      BannerSStyle4(
                        title: "SUMMER \nSALE",
                        subtitle: "SPECIAL OFFER",
                        bottomText: "UP TO 80% OFF",
                        press: () {
                          Navigator.pushNamed(context, onSaleScreenRoute);
                        },
                      ),
                      const SizedBox(height: defaultPadding / 4),
                      // While loading use 👇
                      //  const BannerMSkelton(),
                      BannerSStyle4(
                        image: "https://i.imgur.com/dBrsD0M.png",
                        title: "Black \nfriday",
                        subtitle: "50% off",
                        bottomText: "Collection".toUpperCase(),
                        press: () {
                          Navigator.pushNamed(context, onSaleScreenRoute);
                        },
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: BestSellers()),
                const SliverToBoxAdapter(child: MostPopular()),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: defaultPadding * 1.5),
                      // While loading use 👇
                      // const BannerLSkelton(),
                      BannerLStyle1(
                        title: "Summer \nSale",
                        subtitle: "SPECIAL OFFER",
                        discountPercent: 50,
                        press: () {
                          Navigator.pushNamed(context, onSaleScreenRoute);
                        },
                      ),
                      const SizedBox(height: defaultPadding / 4),
                      // While loading use 👇
                      // const BannerSSkelton(),
                      BannerSStyle5(
                        title: "Black \nfriday",
                        subtitle: "50% Off",
                        bottomText: "Collection".toUpperCase(),
                        press: () {
                          Navigator.pushNamed(context, onSaleScreenRoute);
                        },
                      ),
                      const SizedBox(height: defaultPadding / 4),
                      // While loading use 👇
                      // const BannerSSkelton(),
                      BannerSStyle5(
                        image: "https://i.imgur.com/2443sJb.png",
                        title: "Grab \nyours now",
                        subtitle: "65% Off",
                        press: () {
                          Navigator.pushNamed(context, onSaleScreenRoute);
                        },
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: BestSellers()),
              ],
 */
