import 'package:bloom/models/local_storage_models/product_model/product_model.dart';
import 'package:bloom/providers/product_Provider/product_details_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../../components/cart_button.dart';
import '../../../components/custom_modal_bottom_sheet.dart';
import '../../../components/product/product_card.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../../../models/local_storage_models/product_model/product_model.dart' as productModel;
import '../../../models/product_details_model.dart';
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

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, this.isProductAvailable = false, this.productId});
  final bool isProductAvailable;
  final String? productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ScrollController controller = ScrollController();
  bool done = false;

  productModel.ProductModel convertProductDetailsToProductModel(ProductDetailsModel detailsModel) {
    // Convert ProductType
    final productType = productModel.ProductType(
      id: detailsModel.type.id, //
      value: detailsModel.type.value, //
    );

    // Convert Collection
    productModel.ProductCollection? productCollection;
    if (detailsModel.collection != null) {
      productCollection = productModel.ProductCollection(
        id: detailsModel.collection!.id ?? "", //
        title: detailsModel.collection!.title ?? "", //
        handle: null, // ProductDetailsModel.Collection does not have a handle
        // ProductModel.ProductCollection's factory handles null by defaulting to ""
        // Here, we explicitly set it to null or "" if your constructor/logic prefers.
        // Using "" to align with ProductCollection.fromJson if source is {}
      );
    }

    // Convert Tags
    final tags = detailsModel.tags.map((tag) => tag.value).toList(); //

    // Convert Images
    // Assumes ProductDetailsModel.ProductImage and ProductModel.ProductImage are compatible
    // (i.e., ProductDetailsModel.ProductImage also has id, url, rank implicitly or via shared definition)
    // Based on the import and fromJson usage in ProductDetailsModel, ProductImage from product_model.dart is used.
    final images = detailsModel.images.map((img) {
      return productModel.ProductImage(
        id: img.id, // (assuming ProductDetailsModel.ProductImage maps to this structure)
        url: img.url, //
        rank: img.rank, //
      );
    }).toList();

    // Convert Variants
    final variants = detailsModel.variants.map((variant) {
      // Convert Variant.options (List<ProductDetailsModel.VariantOption>)
      // to List<ProductModel.OptionValue>
      List<productModel.OptionValue> variantOptions = [];
      if (variant.options != null) {
        variantOptions = variant.options!.map((opt) {
          return productModel.OptionValue(
            id: opt.id, //
            value: opt.value, //
          );
        }).toList();
      }

      // Convert CalculatedPrice
      productModel.CalculatedPrice? calculatedPrice;
      if (variant.calculatedPrice != null) {
        calculatedPrice = productModel.CalculatedPrice(
          calculatedAmount: variant.calculatedPrice!.calculatedAmount, //
          originalAmount: variant.calculatedPrice!.originalAmount, //
          currencyCode: variant.calculatedPrice!.currencyCode, //
        );
      }

      int rank = 0; // Default rank
      if (variant.variantRank != null) {
        rank = int.tryParse(variant.variantRank!) ?? 0; //
      }

      return productModel.ProductVariant(
        id: variant.id, //
        title: variant.title, //
        allowBackorder: variant.allowBackorder, //
        manageInventory: variant.manageInventory, //
        variantRank: rank, //
        options: variantOptions,
        calculatedPrice: calculatedPrice,
      );
    }).toList();

    // Construct ProductModel.options (List<ProductOption>)
    final productModelOptions = detailsModel.options.map((detailOption) { //
      final Set<productModel.OptionValue> valuesSet = {};
      for (final variant in detailsModel.variants) { //
        if (variant.options != null) {
          for (final variantOptVal in variant.options!) { //
            if (variantOptVal.optionId == detailOption.id) { //
              valuesSet.add(productModel.OptionValue(id: variantOptVal.id, value: variantOptVal.value)); //
            }
          }
        }
      }
      return productModel.ProductOption(
        id: detailOption.id, //
        title: detailOption.title, //
        values: valuesSet.toList(), //
      );
    }).toList();


    return ProductModel(
      id: detailsModel.id, //
      title: detailsModel.title, //
      subtitle: detailsModel.subtitle, //
      description: detailsModel.description, //
      handle: detailsModel.handle, //
      isGiftCard: detailsModel.isGiftcard, // (note 'isGiftcard' vs 'isGiftCard')
      discountable: detailsModel.discountable, //
      thumbnail: detailsModel.thumbnail, //
      type: productType,
      collection: productCollection,
      options: productModelOptions,
      tags: tags,
      images: images,
      variants: variants,
    );
  }

  @override
  void initState() {
    controller.addListener(listener);
    super.initState();
  }

  void listener() {
    if (controller.offset <= -100 && !done) {
      done = true;
      rootNavigatorKey.currentState?.pop();
      Future.delayed(const Duration(seconds: 1),()=> done = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {

     List<String> getImages (List<ProductImage> images){
       List<String> imageUrls = [];
       for(var image in images){
         imageUrls.add(image.url);
       }
       return imageUrls;

    }
    return PopScope(
      onPopInvokedWithResult: (didPop, _){
        context.read<ProductDetailsScreenProvider>().setQuantity(1);
        context.read<ProductDetailsScreenProvider>().setSelectedVariant("");
      },
      child: Material(
        color: Colors.white,
        child: Stack(
          children: [
            FutureBuilder<ProductDetailsModel>(
                future: ApiManager.getProductDetails(widget.productId!, "reg_01JK96E8Y9KM1Y14S916J0KJKC",),
                builder: (_, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting || snapshot.data == null){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.data != null){
                    WidgetsBinding.instance.addPostFrameCallback((_){
                      context.read<ProductDetailsScreenProvider>().setSelectedVariant(snapshot.data!.variants[0].id);
                    });

                  }
                  print(snapshot.data);
                return Scaffold(
                  bottomNavigationBar: widget.isProductAvailable
                      ? Selector<ProductDetailsScreenProvider, Tuple2<String, int>>(
                    selector: (_, prov) => Tuple2(prov.selectedVariant, prov.quantity),
                        builder: (_, data, child) {
                      double getPrice(){
                        if(data.item1.isEmpty){
                          return 0.0 ;
                        }else{
                          return snapshot.data!.variants.firstWhere((element) => element.id == data.item1).calculatedPrice!.calculatedAmount.toDouble() * data.item2;
                        }
                      }
                          return CartButton(
                              price: getPrice(),
                              press: () {
                                customModalBottomSheet(
                                  context,
                                  height: MediaQuery.of(context).size.height * 0.92,
                                  child:  productBuyNowWidget(context, snapshot.data!, controller)
                                );
                              },
                            );
                        }
                      )
                      :
                      /// If profuct is not available then show [NotifyMeCard]
                      NotifyMeCard(
                          isNotify: false,
                          onChanged: (value) {},
                        ),
                  body: SafeArea(
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          surfaceTintColor: Colors.transparent,
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
                          product: convertProductDetailsToProductModel(snapshot.data!),

                        ),
                        ProductInfo(
                          brand: snapshot.data!.type.value,
                          title: snapshot.data!.title,
                          isAvailable: widget.isProductAvailable,
                          description: snapshot.data!.description,
                          rating: 4.4,
                          numOfReviews: 126,
                        ),
                        // ProductListTile(
                        //   svgSrc: "assets/icons/Product.svg",
                        //   title: "Product Details",
                        //   press: () {
                        //     customModalBottomSheet(
                        //       context,
                        //       height: MediaQuery.of(context).size.height * 0.92,
                        //       child: const ProductInfoScreen(),
                        //     );
                        //   },
                        // ),
                        // ProductListTile(
                        //   svgSrc: "assets/icons/Delivery.svg",
                        //   title: "Shipping Information",
                        //   press: () {
                        //     customModalBottomSheet(
                        //       context,
                        //       height: MediaQuery.of(context).size.height * 0.92,
                        //       child: const ShippingMethodsScreen(),
                        //     );
                        //   },
                        // ),
                        // ProductListTile(
                        //   svgSrc: "assets/icons/Return.svg",
                        //   title: "Returns",
                        //   isShowBottomBorder: true,
                        //   press: () {
                        //     customModalBottomSheet(
                        //       context,
                        //       height: MediaQuery.of(context).size.height * 0.92,
                        //       child: const ProductReturnsScreen(),
                        //     );
                        //   },
                        // ),
                        // const SliverToBoxAdapter(
                        //   child: Padding(
                        //     padding: EdgeInsets.all(defaultPadding),
                        //     child: ReviewCard(
                        //       rating: 4.3,
                        //       numOfReviews: 128,
                        //       numOfFiveStar: 80,
                        //       numOfFourStar: 30,
                        //       numOfThreeStar: 5,
                        //       numOfTwoStar: 4,
                        //       numOfOneStar: 1,
                        //     ),
                        //   ),
                        // ),
                        // ProductListTile(
                        //   svgSrc: "assets/icons/Chat.svg",
                        //   title: "Reviews",
                        //   isShowBottomBorder: true,
                        //   press: () {
                        //     Navigator.pushNamed(context, productReviewsScreenRoute);
                        //   },
                        // ),
                        // SliverPadding(
                        //   padding: const EdgeInsets.all(defaultPadding),
                        //   sliver: SliverToBoxAdapter(
                        //     child: Text(
                        //       "You may also like",
                        //       style: Theme.of(context).textTheme.titleSmall!,
                        //     ),
                        //   ),
                        // ),
                        // SliverToBoxAdapter(
                        //   child: SizedBox(
                        //     height: 220,
                        //     child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: 5,
                        //       itemBuilder: (context, index) => Padding(
                        //         padding: EdgeInsets.only(
                        //             left: defaultPadding,
                        //             right: index == 4 ? defaultPadding : 0),
                        //         child: ProductCard(
                        //           image: productDemoImg2,
                        //           title: "Sleeveless Tiered Dobby Swing Dress",
                        //           brandName: "LIPSY LONDON",
                        //           price: 24.65,
                        //           priceAfetDiscount: index.isEven ? 20.99 : null,
                        //           dicountpercent: index.isEven ? 25 : null,
                        //           press: () {},
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: defaultPadding),
                        )
                      ],
                    )
                  ),
                );
              }
            ),
            Selector<ProductDetailsScreenProvider, bool>(
                selector: (_, prov) => prov.loading,
                builder: (_ , loading , child) {
                  print(loading);
                  return Visibility(
                    visible: loading,
                    child: SizedBox.expand(
                      child: Container(
                        color: primaryColor.withAlpha(20),
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
