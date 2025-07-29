import 'package:bloom/models/cart_models/shipping_options_model.dart';
import 'package:bloom/providers/cart_page_provider/cart_page_provider.dart';
import 'package:bloom/screens/checkout/views/components/shipping_option_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';


class SelectShippingOptionScreen extends StatelessWidget {
  const SelectShippingOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Shipping options"),
          ),
          body: Selector<CartPageProvider, List<ShippingOption>?>(
            selector: (_ , prov) => prov.shippingOptions,
            builder: (_, shippingOptions, child) {
              if(shippingOptions == null){
                return const SizedBox.expand(child: Center(child: CircularProgressIndicator(),),);
              }
              if(shippingOptions.isEmpty){
                return const SizedBox.expand(child: Center(child: Text("No shipping options"),),);
              }
              return ListView.builder(
                itemCount: shippingOptions.length,
                itemBuilder: (context, index) {
                  ShippingOption shippingOption = shippingOptions[index];
                  return ShippingOptionCard(
                    option: shippingOption,
                    press: () {
                      context.read<CartPageProvider>().setShippingOptions(context, shippingOption.id);
                    },

                  );
                },
              );
            }
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
