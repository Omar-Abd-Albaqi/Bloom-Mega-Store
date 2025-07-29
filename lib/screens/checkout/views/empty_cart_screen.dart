import 'package:bloom/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../providers/cart_page_provider/cart_page_provider.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnPullRefreshWidget(
        onRefresh: () async {
          await context.read<CartPageProvider>().getCart(context);
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
                    Image.asset(
                      "assets/icons/empty-cart.png",
                      height: 200,
                      color: Colors.black45,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      "Your cart is empty",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: defaultPadding),
                    const Text(
                      "Customer network effects freemium. Advisor android paradigm shift product management. Customer disruptive crowdsource",
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