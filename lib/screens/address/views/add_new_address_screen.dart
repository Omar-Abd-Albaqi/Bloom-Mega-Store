import 'package:bloom/providers/profile_providers/addresses_provider.dart';
import 'package:bloom/screens/address/views/components/address_note_field.dart';
import 'package:bloom/screens/address/views/components/address_text_field.dart';
import 'package:bloom/screens/address/views/components/select_city.dart';
import 'package:bloom/screens/address/views/components/select_country.dart';
import 'package:bloom/screens/address/views/components/select_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

import '../../../utils/location_service.dart';
import 'components/use_current_location_card.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  String? lat;
  String? lon;
   getAddressFromPosition(Position position) async {
    final prov = context.read<AddressesProvider>();
    lat = position.latitude.toString();
    lon = position.longitude.toString();
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final Placemark placeMark = placemarks.first;
        prov.setDataFromLocation(placeMark);
      } else {
        throw Exception('Could not find any address for the given coordinates.');
      }
    } catch (e) {
      debugPrint('Error getting address from position: $e');
      rethrow;
    }
  }


  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();

  Position? position;
   fetchLocation() async {
     position = await LocationService.getCurrentPosition();
    if (position != null) {
      getAddressFromPosition(position!);
    } else {
      print("Location permission denied or location services off.");
    }
  }
@override
  void initState() {
  Future.microtask(() {
    context.read<AddressesProvider>().loadAllAddressData();
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New address"),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Form(
              key: _addressFormKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [

                    //use current location
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 1.5),
                      child: UseCurrentLocationCard(
                          press: () async {
                         await fetchLocation();
                      }),
                    ),

                    //First name
                    Selector<AddressesProvider, String>(
                      selector: (_, prov) => prov.firstName,
                      builder: (_, firstName, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          firstNameController.text = firstName;
                        });
                        return AddressTextField(
                          textEditingController: firstNameController,
                            prefixIcon: "assets/icons/Profile.svg",
                            hint: "First name",
                          onSaved: (value){
                            context.read<AddressesProvider>().firstName = value??"";
                          }
                        );
                      }
                    ),
                    const SizedBox(height: defaultPadding),

                    //Last name
                    Selector<AddressesProvider, String>(
                      selector: (_, prov) => prov.lastName,
                      builder: (_, lastName, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          lastNameController.text = lastName;
                        });
                        return AddressTextField(
                          textEditingController: lastNameController,
                          prefixIcon: "assets/icons/Profile.svg",
                          hint: "Last name",
                            onSaved: (value){
                              context.read<AddressesProvider>().lastName = value??"";
                            }
                        );
                      }
                    ),
                    const SizedBox(height: defaultPadding),

                    //Country/Region
                    const SelectCountry(),
                    const SizedBox(height: defaultPadding),

                    //State
                    const SelectState(),
                    const SizedBox(height: defaultPadding),

                    //City
                    const SelectCity(),
                    const SizedBox(height: defaultPadding),

                    //Phone number
                    Selector<AddressesProvider , String>(
                      selector: (_, prov) => prov.phoneNumber,
                      builder: (_, phone, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          phoneController.text = phone;
                        });
                        return TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Phone number",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: defaultPadding),
                              child: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/Call.svg",
                                      height: 24,
                                      width: 24,
                                      colorFilter: ColorFilter.mode(
                                          Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color!,
                                          BlendMode.srcIn),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: defaultPadding / 2),
                                      child: Selector<AddressesProvider, Country?>(
                                        selector: (_, prov)=> prov.selectedCountry,
                                        builder: (_, country, child) {
                                          return Text(country?.phoneCode ?? "",
                                              style:
                                              Theme.of(context).textTheme.bodyLarge);
                                        }
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                      child: VerticalDivider(
                                        thickness: 1,
                                        width: defaultPadding / 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onSaved: (value){
                            context.read<AddressesProvider>().phoneNumber = value??"";
                          },
                        );
                      }
                    ),
                    const SizedBox(height: defaultPadding),

                    //Street
                    Selector<AddressesProvider, String>(
                      selector: (_, prov) => prov.street,
                      builder: (_, street, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          streetController.text = street;
                        });
                        return AddressTextField(
                          textEditingController: streetController,
                          hint: "Street",
                            onSaved: (value){
                              context.read<AddressesProvider>().street = value??"";
                            }
                        );
                      }
                    ),
                    const SizedBox(height: defaultPadding),

                    //Building number
                    Selector<AddressesProvider, String>(
                      selector: (_, prov) => prov.buildingNumber,
                      builder: (_, building, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          buildingController.text = building;
                        });
                        return AddressTextField(
                          textEditingController: buildingController,
                          hint: "Building number",
                          onSaved: (value){
                            context.read<AddressesProvider>().buildingNumber = value ?? "";
                          },
                        );
                      }
                    ),
                    const SizedBox(height: defaultPadding),

                    //Postal code
                    Selector<AddressesProvider, String>(
                      selector: (_, prov) => prov.postalCde,
                      builder: (_, postalCode,child) {
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          postalCodeController.text = postalCode;
                        });
                        return AddressTextField(
                          textEditingController: postalCodeController,
                          hint: "Postal code",
                          onSaved: (value){
                            context.read<AddressesProvider>().postalCde = value ?? "";
                          },
                        );
                      }
                    ),
                    const SizedBox(height: defaultPadding),


                    //Address name
                    Selector<AddressesProvider, String>(
                        selector: (_, prov) => prov.addressName,
                        builder: (_, addressName, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_){
                            addressNameController.text = addressName;
                          });
                          return AddressTextField(
                              textEditingController: firstNameController,
                              hint: "Address name",
                              onSaved: (value){
                                context.read<AddressesProvider>().addressName = value??"";
                              }
                          );
                        }
                    ),
                    const SizedBox(height: defaultPadding),


                    const AddressNoteField(),
                    const SizedBox(height: defaultPadding),







                    // ListTile(
                    //   contentPadding:
                    //       const EdgeInsets.symmetric(vertical: defaultPadding),
                    //   title: const Text("P.O. Box"),
                    //   trailing: CupertinoSwitch(
                    //     onChanged: (value) {},
                    //     value: false,
                    //     activeColor: primaryColor,
                    //   ),
                    // ),



                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text("Set default address"),
                      trailing: Selector<AddressesProvider, bool>(
                        selector: (_, prov) => prov.isDefault,
                        builder: (_, isDefault, child) {
                          return CupertinoSwitch(
                            onChanged: (value) {
                              context.read<AddressesProvider>().toggleIsDefault();
                            },
                            value: isDefault,
                            activeTrackColor: primaryColor,
                          );
                        }
                      ),
                    ),
                    const SizedBox(height: defaultPadding * 1.5),
                    ElevatedButton(
                      onPressed: () async {
                        if (_addressFormKey.currentState!.validate()) {
                          _addressFormKey.currentState?.save();
                          await context.read<AddressesProvider>().saveAddress();
                          if(context.mounted){
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Text("Save address"),
                    )
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
      ),
    );
  }
}
