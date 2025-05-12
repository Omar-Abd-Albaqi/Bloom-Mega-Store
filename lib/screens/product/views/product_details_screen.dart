import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/cart_button.dart';
import '../../../components/custom_modal_bottom_sheet.dart';
import '../../../components/product/product_card.dart';
import '../../../constants.dart';
import '../../../models/local_storage_models/product_model/product_model.dart';
import '../../../models/product_details_model.dart';
import '../../../screens/product/views/components/favorite_button.dart';
import '../../../screens/product/views/product_info_screen.dart';
import '../../../screens/product/views/product_returns_screen.dart';
import '../../../screens/product/views/shipping_methods_screen.dart';
import '../../../route/screen_export.dart';
import '../../../utils/api_manager.dart';

import 'components/notify_me_card.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';
import 'components/product_list_tile.dart';
import '../../../components/review_card.dart';
import 'product_buy_now_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, this.isProductAvailable = false, this.product});
  final bool isProductAvailable;
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    print("Adnadsk");
     List<String> getImages (List<ProductImage> images){
       List<String> imageUrls = [];
       for(var image in images){
         imageUrls.add(image.url);
       }
       return imageUrls;

    }
    return Scaffold(
      bottomNavigationBar: isProductAvailable
          ? CartButton(
              price: product!.variants[0].calculatedPrice!.calculatedAmount.toDouble(),
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: const ProductBuyNowScreen(),
                );
              },
            )
          :

          /// If profuct is not available then show [NotifyMeCard]
          NotifyMeCard(
              isNotify: false,
              onChanged: (value) {},
            ),
      body: SafeArea(
        child: FutureBuilder<ProductDetailsModel>(
            future: ApiManager.getProductDetails(product!.id, "reg_01JK96E8Y9KM1Y14S916J0KJKC",),
            builder: (_, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              print(snapshot);
              print(snapshot.data);
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  floating: true,
                  actions: [
                    
                    const SizedBox(width: defaultPadding,),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset("assets/icons/Bookmark.svg",
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),

                  ],
                ),
                 ProductImages(
                  images: getImages(snapshot.data!.images),
                   product: product!,
                                 ),
                ProductInfo(
                  brand: snapshot.data!.type.value,
                  title: snapshot.data!.title,
                  isAvailable: isProductAvailable,
                  description:
                      snapshot.data!.description,
                  rating: 4.4,
                  numOfReviews: 126,
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Product.svg",
                  title: "Product Details",
                  press: () {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: const ProductInfoScreen(),
                    );
                  },
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Delivery.svg",
                  title: "Shipping Information",
                  press: () {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: const ShippingMethodsScreen(),
                    );
                  },
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Return.svg",
                  title: "Returns",
                  isShowBottomBorder: true,
                  press: () {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: const ProductReturnsScreen(),
                    );
                  },
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: ReviewCard(
                      rating: 4.3,
                      numOfReviews: 128,
                      numOfFiveStar: 80,
                      numOfFourStar: 30,
                      numOfThreeStar: 5,
                      numOfTwoStar: 4,
                      numOfOneStar: 1,
                    ),
                  ),
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Chat.svg",
                  title: "Reviews",
                  isShowBottomBorder: true,
                  press: () {
                    Navigator.pushNamed(context, productReviewsScreenRoute);
                  },
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "You may also like",
                      style: Theme.of(context).textTheme.titleSmall!,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                            left: defaultPadding,
                            right: index == 4 ? defaultPadding : 0),
                        child: ProductCard(
                          image: productDemoImg2,
                          title: "Sleeveless Tiered Dobby Swing Dress",
                          brandName: "LIPSY LONDON",
                          price: 24.65,
                          priceAfetDiscount: index.isEven ? 20.99 : null,
                          dicountpercent: index.isEven ? 25 : null,
                          press: () {},
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: defaultPadding),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
