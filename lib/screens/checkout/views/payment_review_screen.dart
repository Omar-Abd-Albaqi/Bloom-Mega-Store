import 'package:bloom/providers/cart_page_provider/cart_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/cart_models/cart_model.dart';
import '../../../models/cart_models/payment_collection_model.dart';
import '../../../route/route_constants.dart';
import '../../../utils/loading.dart';
import '../../order/views/components/order_summary_card.dart';
import 'components/cart_item_widget.dart';

class PaymentCollectionScreen extends StatelessWidget {
  final PaymentCollection paymentCollection;
  const PaymentCollectionScreen({super.key, required this.paymentCollection});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Payment review"),

          ),
          body: OnPullRefreshWidget(
            onRefresh: () async {
              // Refresh logic, if any
            },
            imagePath: 'assets/Transparent Logo.png',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [

                  Selector<CartPageProvider, Cart?>(
                    selector: (_ , prov) => prov.cart,
                    builder: (_, cart, child) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            Text(
                              "Items",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: defaultPadding),
                            ...cart!.items.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: defaultPadding),
                              child: CartItemWidget(
                                cartId: cart.id,
                                item: item,
                                press: () {
                                  Navigator.pushNamed(
                                    context,
                                    productDetailsScreenRoute,
                                    arguments: {'productId': item.product.id},
                                  );
                                },
                              ),
                            )),
                          ]),
                        ),
                      );

                    }
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: defaultPadding * 1.5),
                        Text(
                          "Payment Options",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: defaultPadding),
                      ],
                    ),
                  ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final session = paymentCollection.paymentSessions[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: defaultPadding),
                          child: PaymentSessionCard(session: session),
                        );
                      },
                      childCount: paymentCollection.paymentSessions.length,
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const Divider(height: defaultPadding * 2),
                        OrderSummaryCard(
                          subTotal: double.tryParse(paymentCollection.paymentSessions.first.rawAmount.value) ?? 0,
                          discount: 0,
                          totalWithVat: double.tryParse(paymentCollection.paymentSessions.first.rawAmount.value) ?? 0,
                          vat: 0,
                        ),
                        const SizedBox(height: defaultPadding),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<CartPageProvider>().completeOrder(context);
                            },
                            child: const Text("Place Order"),
                          ),
                        ),
                        const SizedBox(height: defaultPadding * 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Selector<CartPageProvider, bool>(
            selector: (_, prov) => prov.loading,
            builder: (_, loading, child) {
              if (loading) {
                return SizedBox.expand(
                  child: Container(
                    color: primaryColor.withAlpha(20),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
      ],
    );
  }
}


class PaymentSessionCard extends StatelessWidget {
  final PaymentSession session;
  const PaymentSessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    String getProviderId(String providerId){
      switch(providerId){
        case "PP_COD_COD" : {
          return "Cash on delivery";
        }
        default :return"";
      }
    }
    final currencyFormat = NumberFormat.simpleCurrency(name: session.currencyCode.toUpperCase());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getProviderId(session.providerId.toUpperCase()),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Status: ${session.status}", style: Theme.of(context).textTheme.bodyMedium),
              Text(currencyFormat.format(double.tryParse(session.rawAmount.value) ?? 0), style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          if (session.data.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...session.data.entries.map((e) => Text("${e.key}: ${e.value}", style: Theme.of(context).textTheme.bodySmall)),
          ],
        ],
      ),
    );
  }
}

