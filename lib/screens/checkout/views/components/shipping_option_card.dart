import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';
import '../../../../models/cart_models/shipping_options_model.dart';

class ShippingOptionCard extends StatelessWidget {
  const ShippingOptionCard({
    super.key,
    required this.option,
    required this.press,
  });

  final ShippingOption option;
  final VoidCallback press;

  String get locationString {
    final List<String> parts = [
      option.serviceZoneCity,
      option.serviceZoneProvince,
      option.serviceZoneCountry?.toUpperCase(),
    ].where((e) => e != null && e.trim().isNotEmpty).cast<String>().toList();

    return parts.isNotEmpty ? parts.join(', ') : "No location data";
  }

  String get priceDisplay {
    if (option.amount == 0) {
      return "Free";
    } else {
      return "${(option.amount / 100).toStringAsFixed(2)} ${option.priceType.toUpperCase()}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding /2),
      child: InkWell(
        onTap: press,
        borderRadius: const BorderRadius.all(Radius.circular(defaultPadding)),
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(defaultPadding)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // CircleAvatar(
                  //   backgroundColor: Theme.of(context)
                  //       .textTheme
                  //       .bodyLarge!
                  //       .color!
                  //       .withOpacity(0.1),
                  //   child: SvgPicture.asset(
                  //     "assets/icons/Shipping.svg", // Replace with your icon
                  //     height: 20,
                  //     colorFilter: ColorFilter.mode(
                  //       Theme.of(context).iconTheme.color!,
                  //       BlendMode.srcIn,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: defaultPadding),
                  Text(
                    option.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!,
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Text(locationString),
              const SizedBox(height: defaultPadding / 2),
              Text(
                priceDisplay,
                style: const TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
