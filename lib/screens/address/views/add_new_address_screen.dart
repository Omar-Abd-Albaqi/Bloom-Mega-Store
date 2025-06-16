import 'package:bloom/models/cart_models/address_model.dart';
import 'package:bloom/providers/profile_providers/addresses_provider.dart';
import 'package:bloom/screens/address/views/components/address_note_field.dart';
import 'package:bloom/screens/address/views/components/address_text_field.dart';
import 'package:bloom/screens/address/views/components/select_city.dart';
import 'package:bloom/screens/address/views/components/select_country.dart';
import 'package:bloom/screens/address/views/components/select_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
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

   getAddressFromPosition(Position position) async {
    final prov = context.read<AddressesProvider>();
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


  TextEditingController firstNameController = TextEditingController();
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
      body: SafeArea(
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
                AddressTextField(
                    textEditingController: firstNameController,
                    prefixIcon: "assets/icons/Profile.svg",
                    hint: "First name",
                  onSaved: (value){
                      context.read<AddressesProvider>().firstName = value ?? "";
                  },
                ),
                const SizedBox(height: defaultPadding),


                //Last name
                AddressTextField(
                  textEditingController: firstNameController,
                  prefixIcon: "assets/icons/Profile.svg",
                  hint: "Last name",
                  onSaved: (value){
                    context.read<AddressesProvider>().lastName = value ?? "";
                  },
                ),
                const SizedBox(height: defaultPadding),

                //Last name
                TextFormField(
                  onSaved: (newValue) {},
                  validator:
                  RequiredValidator(errorText: "This field is required")
                      .call,
                  decoration: InputDecoration(
                    hintText: "Last name",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 0.74),
                      child: SvgPicture.asset(
                        "assets/icons/Profile.svg",
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context)
                                .inputDecorationTheme
                                .hintStyle!
                                .color!,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
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
                TextFormField(
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
                ),
                const SizedBox(height: defaultPadding),

                //Address 1
                TextFormField(
                  onSaved: (newValue) {},
                  validator:
                  RequiredValidator(errorText: "This field is required")
                      .call,
                  decoration: const InputDecoration(
                    hintText: "Address line 1",
                  ),
                ),
                const SizedBox(height: defaultPadding),

                //Postal code
                AddressTextField(
                  textEditingController: firstNameController,
                  hint: "Postal code",
                  onSaved: (value){
                    context.read<AddressesProvider>().postalCde = value ?? "";
                  },
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
                  trailing: CupertinoSwitch(
                    onChanged: (value) {},
                    value: true,
                    activeColor: primaryColor,
                  ),
                ),
                const SizedBox(height: defaultPadding * 1.5),
                ElevatedButton(
                  onPressed: () {
                    if (_addressFormKey.currentState!.validate()) {
                      _addressFormKey.currentState?.save();
                    }
                  },
                  child: const Text("Save address"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
