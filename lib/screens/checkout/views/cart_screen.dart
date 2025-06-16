import 'package:bloom/providers/cart_page_provider/cart_page_provider.dart';
import 'package:bloom/screens/checkout/views/components/cart_item_widget.dart';
import 'package:bloom/screens/checkout/views/empty_cart_screen.dart';
import 'package:bloom/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../../models/cart_models/cart_model.dart';
import '../../../models/cart_models/line_item_model.dart';
import '../../../route/screen_export.dart';
import '../../../screens/order/views/components/order_summary_card.dart';

import '../../../constants.dart';
import 'components/coupon_code.dart';
import 'components/review_your_items_skelton.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnPullRefreshWidget(
        onRefresh: () async {
          await context.read<CartPageProvider>().getCart();
        },
        imagePath: 'assets/Transparent Logo.png',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Selector<CartPageProvider, Tuple2<Cart? , bool>>(
            selector: (_ , prov) => Tuple2(prov.cart, prov.loading),
            builder: (_, data, child) {
              bool loading = data.item1 == null ||  data.item2;
              print(data.item1!.items);
              return data.item1!.items.isEmpty && data.item1 != null  ? const  EmptyCartScreen(): CustomScrollView(
                physics:  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverToBoxAdapter(
                    child: Text(
                      "Review your order",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  // While loading use 👇
                  // const ReviewYourItemsSkelton(),
                  if(loading)
                   const ReviewYourItemsSkelton(),
                  if(!loading)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          LineItem item = data.item1!.items[index];
                          return  Padding(
                            padding: const EdgeInsets.only(bottom: defaultPadding),
                            child: CartItemWidget(
                              cartId: data.item1!.id,
                              item: item,
                              press: (){
                                Navigator.pushNamed(context, productDetailsScreenRoute,arguments: {'productId': item.product.id});
                              },
                            ),
                          );
                        },
                        childCount: data.item1!.items.length,
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(
                    child: CouponCode(),
                  ),

                  const SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
                    sliver: SliverToBoxAdapter(
                      child: OrderSummaryCard(
                        subTotal: 169.0,
                        discount: 10,
                        totalWithVat: 185,
                        vat: 5,
                      ),
                    ),
                  ),
                  SliverPadding(
                    // Use padding on the SliverToBoxAdapter's child for horizontal padding
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                    sliver: SliverToBoxAdapter(
                      // Give the child of the adapter some horizontal padding
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: Row(
                          children: [
                            // Wrap the button in Expanded
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, paymentMethodScreenRoute);
                                },
                                child: const Text("Continue"),
                              ),
                            ),
                            // Add some space between the widgets
                            const SizedBox(width: defaultPadding),
                            // Your Selector now implicitly gets constraints from the Row
                            Selector<CartPageProvider, bool>(
                              selector: (_, prov) => prov.stateChanged,
                              builder: (_, stateChanged, child) {
                                // No need to wrap this in Expanded if the size is fixed
                                // The first Expanded widget above constrains the Row's width.
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: stateChanged ? 120 : 0, // Increased width for better text visibility
                                  height: 48, // Match a typical button height
                                  child: stateChanged
                                      ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green, // Or your theme's success color
                                    ),
                                    onPressed: () {
                                      // Call your provider's save method here
                                      // context.read<CartPageProvider>().saveChanges();
                                    },
                                    child: const Text("Save"),
                                  )
                                      : const SizedBox.shrink(), // Use SizedBox.shrink() to hide completely
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
