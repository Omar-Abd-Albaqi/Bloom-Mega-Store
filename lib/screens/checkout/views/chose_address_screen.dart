import 'package:bloom/api/cart_api_manager.dart';
import 'package:bloom/providers/cart_page_provider/cart_page_provider.dart';
import 'package:bloom/providers/profile_providers/addresses_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/cart_models/address_model.dart';
import '../../../route/screen_export.dart';
import '../../address/views/components/address_card.dart';


class ChoseAddressScreen extends StatelessWidget {
  const ChoseAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Addresses"),
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //     },
            //     icon: SvgPicture.asset(
            //       "assets/icons/DotsV.svg",
            //       colorFilter: ColorFilter.mode(
            //           Theme.of(context).iconTheme.color!, BlendMode.srcIn),
            //     ),
            //   )
            // ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding),
            child: Column(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, addNewAddressesScreenRoute);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Location.svg",
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!, BlendMode.srcIn),
                  ),
                  label: Text(
                    "Add new address",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ),
                const SizedBox(height: defaultPadding / 2),
                Selector<AddressesProvider, List<Address>>(
                    selector: (_, prov) => prov.addressList,
                    builder: (_, addresses, child) {
                      return Expanded(
                        child: ListView.separated(
                            padding:  EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (_, index){
                              Address address = addresses[index];
                              String addressDescription = "${address.metadata?['country'] ?? ""}, ${address.province}, ${address.city}, ${address.metadata?['street'] ?? ""}, ${address.metadata?['buildingNumber'] ?? ""}";
                              return AddressCard(
                                  isActive: address.metadata?['isDefault'] ==  null ? false : address.metadata?['isDefault'] == "YES",
                                  title: address.metadata?['addressName'] ?? "No Address Name",
                                  address: addressDescription,
                                  pnNumber: "${address.metadata?['country_phone_code'] ?? ""} ${address.phone}",
                                  press: (){
                                    context.read<CartPageProvider>().addAddressToCart(context, address: address);
                                  }
                              );
                            },
                            separatorBuilder: (_, index) => const SizedBox(height: defaultPadding),
                            itemCount: addresses.length),
                      );
                    }
                ),
              ],
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
