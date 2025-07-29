import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

import '../../../providers/cart_page_provider/cart_page_provider.dart';
import 'components/pay_with_card.dart';
import 'components/pay_with_cash.dart';
import 'components/pay_with_credit.dart';
import 'components/payment_method_button.dart';


class _PaymentOption {
  final String id;
  final String title;
  final String svgSrc;
  final Widget widget;

  _PaymentOption({
    required this.id,
    required this.title,
    required this.svgSrc,
    required this.widget,
  });
}

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key, required this.payments});
  final List<PaymentProviderModel> payments;

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late List<_PaymentOption> availableOptions;
  int _selectedMethodIndex = 0;

  @override
  void initState() {
    super.initState();

    // Dynamically generate available options
    availableOptions = [
      if (widget.payments.any((e) => e.id == "pp_cod_cod" && e.isEnabled))
        _PaymentOption(
          id: "pp_cod_cod",
          title: "Pay with cash",
          svgSrc: "assets/icons/Cash.svg",
          widget: const PayWithCash(providerId: "pp_cod_cod"),
        ),
      // You can add more methods here in the same way
      // e.g.
      // if (widget.payments.any((e) => e.id == "pp_card" && e.isEnabled))
      //   _PaymentOption(
      //     id: "pp_card",
      //     title: "Pay with card",
      //     svgSrc: "assets/icons/card.svg",
      //     widget: const PayWithCard(),
      //   ),
    ];

    // Select first available payment method dynamically
    if (availableOptions.isNotEmpty) {
      _selectedMethodIndex = 0;
    } else {
      _selectedMethodIndex = -1; // No available options
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Payment method"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/icons/info.svg",
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!,
                    BlendMode.srcIn,
                  ),
                ),
              )
            ],
          ),
          body: availableOptions.isEmpty
              ? const Center(child: Text("No payment methods available"))
              : Column(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    availableOptions.length,
                        (index) {
                      final option = availableOptions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: PayentMethodButton(
                          svgSrc: option.svgSrc,
                          title: option.title,
                          isActive: _selectedMethodIndex == index,
                          press: () {
                            setState(() {
                              _selectedMethodIndex = index;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (_selectedMethodIndex != -1)
                availableOptions[_selectedMethodIndex].widget,
            ],
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
