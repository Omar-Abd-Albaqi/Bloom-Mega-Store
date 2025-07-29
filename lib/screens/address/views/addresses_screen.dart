import 'dart:ui';

import 'package:bloom/providers/profile_providers/addresses_provider.dart';
import 'package:bloom/utils/hive_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../../constants.dart';
import '../../../models/cart_models/address_model.dart';
import '../../../route/screen_export.dart';

import 'components/address_card.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Addresses"),
            actions: [
              IconButton(
                onPressed: () async {
                  final RenderBox button = context.findRenderObject() as RenderBox;
                  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                  final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);
                  final Size size = button.size;

                  // Show the menu with custom position
                  final selected = await showMenu<String>(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      position.dx,
                      position.dy + 110, // Shift 10 pixels downward
                      position.dx - size.width,
                      position.dy,
                    ),
                    items: [
                      const PopupMenuItem(
                        value: 'remove',
                        child: Text('Remove Addresses'),
                      ),
                    ],
                  );

                  if (selected == 'remove') {

                    context.read<AddressesProvider>().setRemovingAddresses();
                    print('Remove Addresses clicked');
                  }
                },
                icon: SvgPicture.asset(
                  "assets/icons/DotsV.svg",
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!,
                    BlendMode.srcIn,
                  ),
                ),
              )

            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: HiveStorageManager.signedInNotifier.value ? [
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
                  Selector<AddressesProvider, Tuple2<List<Address>, bool>>(
                    selector: (_, prov) => Tuple2(prov.addressList, prov.removingAddresses),
                    builder: (_, data, child) {
                      List<Address> addresses  = data.item1;
                      bool isRemoving = data.item2;
                      if(isRemoving){
                        return Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: addresses.length,
                              itemBuilder: (_, index){
                                Address address = addresses[index];
                                String addressDescription = "${address.metadata?['country'] ?? ""}, ${address.province}, ${address.city}, ${address.metadata?['street'] ?? ""}, ${address.metadata?['buildingNumber'] ?? ""}";
                                return GestureDetector(
                                  onTap: (){
                                    context.read<AddressesProvider>().removeCustomerAddress(address.id);
                                  },
                                  child: Stack(
                                    children: [
                                      // The address card
                                      AddressCard(
                                        isActive: address.metadata?['isDefault'] == null
                                            ? false
                                            : address.metadata?['isDefault'] == "YES",
                                        title: address.metadata?['addressName'] ?? "No Address Name",
                                        address: addressDescription,
                                        pnNumber:
                                        "${address.metadata?['country_phone_code'] ?? ""} ${address.phone}",
                                        press: () {},
                                      ),
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12), // match AddressCard if needed
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                                            child: Container(
                                              color: Colors.redAccent.withAlpha(15),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                                size: 48,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (_, index) => const SizedBox(height: defaultPadding),
                            )
                        );
                      }
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
                                  press: (){});
                            },
                            separatorBuilder: (_, index) => const SizedBox(height: defaultPadding),
                            itemCount: addresses.length),
                      );
                    }
                  ),
                ]: [
                  const Text("Sign in please")
                ],
              ),
            ),
          ),
        ),
        Selector<AddressesProvider, bool>(
            selector: (_, prov) => prov.loadingAddresses,
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
