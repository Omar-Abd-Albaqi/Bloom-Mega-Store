import 'package:bloom/route/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';

import '../../../models/cart_models/order_model.dart';
import 'components/order_summery.dart';

class ThanksForOrderScreen extends StatelessWidget {
  final OrderModel order;
  const ThanksForOrderScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final email = order.email;
    final total = order.total.toDouble(); // e.g. 105.0
    final items = order.items;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order #${order.displayId}"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/Share.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? "assets/Illustration/Success_darkTheme.png"
                      : "assets/Illustration/Success_lightTheme.png",
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              const SizedBox(height: defaultPadding * 2),
              Text(
                "Thanks for your order!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: defaultPadding),
              Text(
                "A confirmation email has been sent to",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: defaultPadding * 2),

              // Order totals summary
              OrderSummary(
                orderId: "#${order.displayId}",
                amount: total,
              ),

              const SizedBox(height: defaultPadding * 2),

              // Item list preview
              Text(
                "Your items",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: defaultPadding),
              ...items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: defaultPadding),
                  child: Row(
                    children: [
                      Image.network(
                        item.thumbnail,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: defaultPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${item.quantity} × \$${item.unitPrice}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${item.total}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              }),

              const Spacer(),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, entryPointScreenRoute, (route) =>false);
                  // navigate to tracking or orders page
                },
                icon: SvgPicture.asset(
                  "assets/icons/Trackorder.svg",
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: const Text("Done!"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

