import 'package:bloom/providers/cart_page_provider/cart_page_provider.dart';
import 'package:bloom/providers/product_Provider/product_details_screen_provider.dart';
import 'package:bloom/utils/hive_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../../components/cart_button.dart';
import '../../../components/custom_modal_bottom_sheet.dart';
import '../../../components/network_image_with_loader.dart';
import '../../../models/product_details_model.dart';
import '../../../screens/product/views/components/product_list_tile.dart';
import '../../../screens/product/views/location_permission_store_availability_screen.dart';
import '../../../screens/product/views/size_guide_screen.dart';

import '../../../constants.dart';
import 'components/product_quantity.dart';
import 'components/selected_colors.dart';
import 'components/selected_size.dart';
import 'components/unit_price.dart';

// class ProductBuyNowScreen extends StatefulWidget {
//   const ProductBuyNowScreen({super.key, required this.product});
//   final ProductDetailsModel product;
//
//   @override
//   _ProductBuyNowScreenState createState() => _ProductBuyNowScreenState();
// }

// class _ProductBuyNowScreenState extends State<ProductBuyNowScreen> {
//   ScrollController controller = ScrollController();
//   bool done = false;
//
//   @override
//   void initState() {
//     controller.addListener(listener);
//     super.initState();
//   }
//
//   void listener() {
//     if (controller.offset <= -100 && !done) {
//       done = true;
//       rootNavigatorKey.currentState?.pop();
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           bottomNavigationBar: Selector<ProductDetailsScreenProvider, Tuple2<String, int>>(
//               selector: (_, prov) => Tuple2(prov.selectedVariant, prov.quantity),
//               builder: (_, data, child) {
//                 double getPrice(){
//                   if(data.item1.isEmpty){
//                     return 0.0 ;
//                   }else{
//                     return widget.product.variants.firstWhere((element) => element.id == data.item1).calculatedPrice!.calculatedAmount.toDouble() * data.item2;
//                   }
//                 }
//                 return CartButton(
//                   price: getPrice(),
//                   title: "Add to cart",
//                   subTitle: "Total price",
//                   press: () async {
//                     context.read<ProductDetailsScreenProvider>().setLoading(true);
//                     Future.delayed(const Duration(seconds: 2), (){
//                       context.read<ProductDetailsScreenProvider>().setLoading(false);
//                     });
//                     // customModalBottomSheet(
//                     //   context,
//                     //   isDismissible: false,
//                     //   child: const AddedToCartMessageScreen(),
//                     // );
//                   },
//                 );
//               }
//           ),
//
//           body: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: defaultPadding / 2, vertical: defaultPadding),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const BackButton(),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.5,
//                       child: Text(
//                         widget.product.title,
//                         overflow: TextOverflow.ellipsis,
//                         style: Theme.of(context).textTheme.titleSmall,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: SvgPicture.asset("assets/icons/Bookmark.svg",
//                           color: Theme.of(context).textTheme.bodyLarge!.color),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: CustomScrollView(
//                   controller: controller,
//                   slivers: [
//                     SliverToBoxAdapter(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//                         child: AspectRatio(
//                           aspectRatio: 1.05,
//                           child: NetworkImageWithLoader(widget.product.thumbnail, fullScreen: true,),
//                         ),
//                       ),
//                     ),
//                     SliverPadding(
//                       padding: const EdgeInsets.all(defaultPadding),
//                       sliver: SliverToBoxAdapter(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Selector<ProductDetailsScreenProvider, Tuple2<String, int>>(
//                                   selector: (_, prov) => Tuple2(prov.selectedVariant, prov.quantity),
//                                   builder: (_, data, child) {
//                                     double getPrice(){
//                                       if(data.item1.isEmpty){
//                                         return 0.0 ;
//                                       }else{
//                                         return widget.product.variants.firstWhere((element) => element.id == data.item1).calculatedPrice!.calculatedAmount.toDouble() * data.item2;
//                                       }
//                                     }
//                                     return UnitPrice(
//                                       price: getPrice(),
//                                       // priceAfterDiscount: 134.7,
//                                     );
//                                   }
//                               ),
//                             ),
//                             //quantity
//                             Selector<ProductDetailsScreenProvider, int>(
//                                 selector: (_, prov) => prov.quantity,
//                                 builder: (_, quantity, child) {
//                                   return ProductQuantity(
//                                     numOfItem: quantity,
//                                     onIncrement: () {
//                                       int newValue = quantity +1;
//                                       context.read<ProductDetailsScreenProvider>().setQuantity(newValue);
//                                     },
//                                     onDecrement: () {
//                                       int newValue = quantity -1;
//                                       context.read<ProductDetailsScreenProvider>().setQuantity(newValue);
//                                     },
//                                     onLongPressIncrement: (){
//
//                                     },
//                                   );
//                                 }
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SliverToBoxAdapter(child: Divider()),
//                     SliverToBoxAdapter(
//                       child: SelectedColors(
//                         colors: const [
//                           Color(0xFFEA6262),
//                           Color(0xFFB1CC63),
//                           Color(0xFFFFBF5F),
//                           Color(0xFF9FE1DD),
//                           Color(0xFFC482DB),
//                         ],
//                         selectedColorIndex: 2,
//                         press: (value) {},
//                       ),
//                     ),
//                     SliverToBoxAdapter(
//                       child: SelectedSize(
//                         sizes: const ["S", "M", "L", "XL", "XXL"],
//                         selectedIndex: 1,
//                         press: (value) {},
//                       ),
//                     ),
//                     SliverPadding(
//                       padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//                       sliver: ProductListTile(
//                         title: "Size guide",
//                         svgSrc: "assets/icons/Sizeguid.svg",
//                         isShowBottomBorder: true,
//                         press: () {
//                           customModalBottomSheet(
//                             context,
//                             height: MediaQuery.of(context).size.height * 0.9,
//                             child: const SizeGuideScreen(),
//                           );
//                         },
//                       ),
//                     ),
//                     SliverPadding(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: defaultPadding),
//                       sliver: SliverToBoxAdapter(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: defaultPadding / 2),
//                             Text(
//                               "Store pickup availability",
//                               style: Theme.of(context).textTheme.titleSmall,
//                             ),
//                             const SizedBox(height: defaultPadding / 2),
//                             const Text(
//                                 "Select a size to check store availability and In-Store pickup options.")
//                           ],
//                         ),
//                       ),
//                     ),
//                     SliverPadding(
//                       padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//                       sliver: ProductListTile(
//                         title: "Check stores",
//                         svgSrc: "assets/icons/Stores.svg",
//                         isShowBottomBorder: true,
//                         press: () {
//                           customModalBottomSheet(
//                             context,
//                             height: MediaQuery.of(context).size.height * 0.92,
//                             child: const LocationPermissonStoreAvailabilityScreen(),
//                           );
//                         },
//                       ),
//                     ),
//                     const SliverToBoxAdapter(
//                         child: SizedBox(height: defaultPadding))
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         Selector<ProductDetailsScreenProvider, bool>(
//             selector: (_, prov) => prov.loading,
//             builder: (_ , loading , child) {
//               print(loading);
//               return Visibility(
//                 visible: loading,
//                 child: SizedBox.expand(
//                   child:Container(
//                     color: primaryColor.withAlpha(20),
//                   ),
//                 ),
//               );
//             }
//         ),
//       ],
//     );
//   }
// }

Widget productBuyNowWidget(BuildContext context, ProductDetailsModel product, ScrollController controller){
  print(product.variants.length);
  print(product.variants.first.toString());

   List<Map<String, dynamic>> groupAndSortVariantOptions(List<Variant> variants) {
    if (variants.isEmpty) {
      return [];
    }

    // Use a Map to group option values by their title.
    // The key is the option title (e.g., "Color"),
    // and the value is a Set of option values (e.g., {"Black", "Blue"})
    // Using a Set automatically handles duplicate values.
    final Map<String, Set<String>> groupedOptions = {};

    for (final variant in variants) {
      if (variant.options != null) {
        for (final variantOption in variant.options!) {
          // We need the title of the option type (e.g., "Color", "Size")
          // Assuming VariantOption has a nested 'option' object with a 'title' field.
          final String? optionTitle = variantOption.option?.title;
          final String optionValue = variantOption.value;

          if (optionTitle != null && optionTitle.isNotEmpty) {
            // If the title doesn't exist in our map, add it with a new Set.
            groupedOptions.putIfAbsent(optionTitle, () => <String>{});
            // Add the value to the Set for this option title.
            groupedOptions[optionTitle]!.add(optionValue);
          }
          // You might want to handle cases where optionTitle is null or empty,
          // for example, by skipping or logging.
        }
      }
    }

    // Convert the grouped options map into the desired list structure.
    final List<Map<String, dynamic>> result = [];
    final List<String> sortedTitles = groupedOptions.keys.toList();

    // Sort the option titles alphabetically.
    // You could implement custom sorting here if needed (e.g., "Size" before "Color").
    sortedTitles.sort();

    for (final title in sortedTitles) {
      final List<String> sortedValues = groupedOptions[title]!.toList();
      // Sort the option values alphabetically.
      sortedValues.sort();

      result.add({
        "title": title,
        "options": sortedValues,
      });
    }

    return result;
  }
  print(groupAndSortVariantOptions(product.variants));

  return Stack(
    children: [
      Scaffold(
        bottomNavigationBar: Selector<ProductDetailsScreenProvider, Tuple2<String, int>>(
            selector: (_, prov) => Tuple2(prov.selectedVariant, prov.quantity),
            builder: (_, data, child) {
              double getPrice(){
                if(data.item1.isEmpty){
                  return 0.0 ;
                }else{
                  return product.variants.firstWhere((element) => element.id == data.item1).calculatedPrice!.calculatedAmount.toDouble() * data.item2;
                }
              }
              return CartButton(
                price: getPrice(),
                title: "Add to cart",
                subTitle: "Total price",
                press: () async {
                  final productDetailsProvider = context.read<ProductDetailsScreenProvider>();
                  final cartProvider = context.read<CartPageProvider>();
                  int quantity =  productDetailsProvider.quantity;
                  String cartId = HiveStorageManager.getCartId();
                  List<Map<String, dynamic>> items = [
                    {
                    'variant_id' : product.variants[0].id.toString(),
                    'quantity' : quantity
                    }
                  ];
                  bool isLoggedIn = HiveStorageManager.signedInNotifier.value;
                  print(items);
                  print(cartId);
                  await productDetailsProvider.addToCart(context, isLoggedIn, items, "reg_01JK96E8Y9KM1Y14S916J0KJKC");
                },
              );
            }
        ),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2, vertical: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset("assets/icons/Bookmark.svg",
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                controller: controller,
                slivers: [

                  //product picture
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: AspectRatio(
                        aspectRatio: 1.05,
                        child: NetworkImageWithLoader(product.thumbnail, fullScreen: true,),
                      ),
                    ),
                  ),

                  //price and quantity
                  SliverPadding(
                    padding: const EdgeInsets.all(defaultPadding),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Selector<ProductDetailsScreenProvider, Tuple2<String, int>>(
                                selector: (_, prov) => Tuple2(prov.selectedVariant, prov.quantity),
                                builder: (_, data, child) {
                                  double getPrice(){
                                    if(data.item1.isEmpty){
                                      return 0.0 ;
                                    }else{
                                      return product.variants.firstWhere((element) => element.id == data.item1).calculatedPrice!.calculatedAmount.toDouble() * data.item2;
                                    }
                                  }
                                  return UnitPrice(
                                    price: getPrice(),
                                    // priceAfterDiscount: 134.7,
                                  );
                                }
                            ),
                          ),

                          //quantity
                          Selector<ProductDetailsScreenProvider, int>(
                              selector: (_, prov) => prov.quantity,
                              builder: (_, quantity, child) {
                                return ProductQuantity(
                                  numOfItem: quantity,
                                  onIncrement: () {
                                    int newValue = quantity +1;
                                    context.read<ProductDetailsScreenProvider>().setQuantity(newValue);
                                  },
                                  onDecrement: () {
                                    int newValue = quantity -1;
                                    context.read<ProductDetailsScreenProvider>().setQuantity(newValue);
                                  },
                                  onLongPressIncrement: (){

                                  },
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),

                  //divider
                  const SliverToBoxAdapter(child: Divider()),

                  //color selection
                  // SliverToBoxAdapter(
                  //   child: SelectedColors(
                  //     colors: const [
                  //       Color(0xFFEA6262),
                  //       Color(0xFFB1CC63),
                  //       Color(0xFFFFBF5F),
                  //       Color(0xFF9FE1DD),
                  //       Color(0xFFC482DB),
                  //     ],
                  //     selectedColorIndex: 2,
                  //     press: (value) {},
                  //   ),
                  // ),

                  //size selection
                  // SliverToBoxAdapter(
                  //   child: SelectedSize(
                  //     title: groupAndSortVariantOptions(product.variants).first['title'],
                  //     sizes: groupAndSortVariantOptions(product.variants).first['options'],
                  //     selectedIndex: 1,
                  //     press: (value) {},
                  //   ),
                  // ),

                  //size guide
                  // SliverPadding(
                  //   padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  //   sliver: ProductListTile(
                  //     title: "Size guide",
                  //     svgSrc: "assets/icons/Sizeguid.svg",
                  //     isShowBottomBorder: true,
                  //     press: () {
                  //       customModalBottomSheet(
                  //         context,
                  //         height: MediaQuery.of(context).size.height * 0.9,
                  //         child: const SizeGuideScreen(),
                  //       );
                  //     },
                  //   ),
                  // ),

                  //store pickup availability
                  // SliverPadding(
                  //   padding:
                  //   const EdgeInsets.symmetric(horizontal: defaultPadding),
                  //   sliver: SliverToBoxAdapter(
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const SizedBox(height: defaultPadding / 2),
                  //         Text(
                  //           "Store pickup availability",
                  //           style: Theme.of(context).textTheme.titleSmall,
                  //         ),
                  //         const SizedBox(height: defaultPadding / 2),
                  //         const Text(
                  //             "Select a size to check store availability and In-Store pickup options.")
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  //check store
                  // SliverPadding(
                  //   padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  //   sliver: ProductListTile(
                  //     title: "Check stores",
                  //     svgSrc: "assets/icons/Stores.svg",
                  //     isShowBottomBorder: true,
                  //     press: () {
                  //       customModalBottomSheet(
                  //         context,
                  //         height: MediaQuery.of(context).size.height * 0.92,
                  //         child: const LocationPermissonStoreAvailabilityScreen(),
                  //       );
                  //     },
                  //   ),
                  // ),

                  const SliverToBoxAdapter(
                      child: SizedBox(height: defaultPadding))
                ],
              ),
            )
          ],
        ),
      ),
      Selector<ProductDetailsScreenProvider, bool>(
          selector: (_, prov) => prov.loading,
          builder: (_ , loading , child) {
            print(loading);
            return Visibility(
              visible: loading,
              child: SizedBox.expand(
                child:Container(
                  color: primaryColor.withAlpha(20),
                ),
              ),
            );
          }
      ),
    ],
  );
}
