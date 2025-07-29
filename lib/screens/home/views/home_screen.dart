
import 'package:bloom/extensions/locale_extension.dart';
import 'package:bloom/models/home_items_models/main_models/product_product_category.dart';
import 'package:bloom/models/home_items_models/main_models/sliders_wide_sliders.dart';
import 'package:bloom/screens/home/views/components/category_grid.dart';
import 'package:bloom/screens/home/views/components/product_list_from_collection.dart';
import 'package:bloom/screens/home/views/components/sliders_wide_sliders_widget.dart';
import 'package:bloom/utils/hive_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/home_items_models/main_models/boxes_inline_boxes_model.dart';
import '../../../models/home_items_models/main_models/global_brands_box.dart';
import '../../../models/home_items_models/main_models/products_categories.dart';
import '../../../models/home_items_models/main_models/products_list_products.dart';
import '../../../providers/entry_point_providers/nav_bar_provider.dart';
import '../../../providers/home_page_provider/home_items_provider.dart';
import '../../../route/screen_export.dart';

import '../../../components/skleton/skelton.dart';
import 'components/global_brands_box.dart';
import 'components/offer_carousel_and_categories.dart';
import 'components/product_list_from_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;



  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("🏠 HomeScreen built");
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: Consumer<HomeItemsProvider>(
          // selector: (_, prov)=> prov.homeModels,
          builder: (_, prov, child) {
            final data = prov.homeModels;
            if(data == null || data.isEmpty){
              return CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),


                  ]
              );
            }

              return CustomScrollView(
                key: const PageStorageKey('tab1-scroll'),
                slivers: data.map<Widget>((item) {
                  switch (item) {

                    case SlidersWideSliders model:
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: defaultPadding /2),
                        sliver: SliverToBoxAdapter(
                            child: SlidersWideSlidersWidget(sliders: model)),
                      );

                    case ProductsProductsCategory model:
                      return SliverToBoxAdapter(child: ProductListFromCategory(category: model.category!));

                    case ProductsCategoriesModel model:
                      final bool isRTL = HiveStorageManager.getLocale() == "ar";
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
                                    context.loc.categories,
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      context.read<NavBarProvider>().setIndex(1);
                                    },
                                    child: Row(
                                      children:  [
                                        Text(context.loc.showall,style: const TextStyle(color: Colors.black45 , fontSize: 14,),),
                                        const SizedBox(width: defaultPadding /4,),
                                        Icon(isRTL ? Icons.keyboard_double_arrow_left_rounded :Icons.keyboard_double_arrow_right_rounded, color: Colors.black45, size: 20)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CategoryGrid(model: model),
                          ],
                        ),
                      );

                    case BoxesInlineBoxesModel model:
                      return SliverToBoxAdapter(
                        child: InlineBoxesWidget(model: model),
                      );

                    case ProductsListProductsModel model:
                      return SliverToBoxAdapter(child: ProductListFromCollection(collection: model.collection!));

                    case GlobalBrandsBoxModel model:
                      return SliverToBoxAdapter(
                        child: GlobalBrandsBox(globalBrandsBox: model,)
                      );



                   /* case SliderAndBoxesModel model:
                      return SliverToBoxAdapter(
                        child: OffersCarouselAndCategories(sliderAndBoxesModel: model),
                      );

                    case GlobalListIconsModel model:
                      return SliverToBoxAdapter(
                        child: ProductCategoriesWidget(globalListIconsModel: model),
                      );





                    case ProductsPromoBannerModel model:
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding /2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(defaultBorderRadious),
                            child: BannerSStyle4(
                              image: model.cover.formats!['large']['url'],
                              subtitle: null,
                              title: null,
                              bottomText: null,
                              aspectRatio: model.cover.formats!['large']['width'] / model.cover.formats!['large']['height'],
                              press: () {
                                Navigator.pushNamed(context, onSaleScreenRoute);
                              },
                            ),
                          ),
                        ),
                      );



                    case GlobalCountersModel model:
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding /2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(defaultBorderRadious),
                            child: AspectRatio(
                              aspectRatio: 1.7,
                              child: BannerS(
                                image: model.cover.url,
                                press: (){},
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(defaultPadding , defaultPadding, defaultPadding, 0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: defaultPadding / 2,),
                                                  color: Colors.white10,
                                                  child: Text(
                                                    model.legend,
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              const SizedBox(height: defaultPadding ),

                                                TextWithBackground(text: model.title),
                                              const SizedBox(height: defaultPadding /2),
                                              CountdownTimerWidget(endAt: model.endAt.toString()),
                                              const SizedBox(height: defaultPadding /2,),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ),
                        ),
                      );*/

                    default:
                      return const SliverToBoxAdapter(child: SizedBox());
                  }
                }).toList(),
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
