import 'dart:convert';

import 'package:bloom/api/cart_api_manager.dart';
import 'package:bloom/models/cart_models/address_model.dart';
import 'package:bloom/providers/auth/login_provider.dart';
import 'package:bloom/providers/home_page_provider/category_provider.dart';
import 'package:bloom/providers/locale_provider.dart';
import 'package:bloom/providers/profile_providers/addresses_provider.dart';
import 'package:bloom/providers/profile_providers/customer_details_provider.dart';
import 'package:bloom/utils/hive_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import 'api/auth_api_manager.dart';
import 'constants.dart';
import 'models/cart_models/cart_model.dart';
import 'models/cart_models/region_model.dart';
class TestingClass extends StatefulWidget {
  const TestingClass({super.key});

  @override
  State<TestingClass> createState() => _TestingClassState();
}

class _TestingClassState extends State<TestingClass> {
  Cart? cart;
  dynamic error = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Region> regions = context.read<CategoryProvider>().regions;
    return Column(
      children: [
        GestureDetector(
          onTap: () async {

            String shippingId = "so_01JZ2NHNBYYTQED87F7DAYFXWH";
            String regionId = "reg_01JK96E8Y9KM1Y14S916J0KJKC";
            String providerId = "pp_cod_cod";
            String paymentId = "pay_col_01JZ32TX2EC4XQTJ9A3YZGDBE2";
            final cartId = HiveStorageManager.getCartId();
             String paymentCollectionId = "pay_col_01K0RT4DKVWX09CYG689SZRZQ6";
            // final temp = await CartApiManager.linkCartToUser(cartId: cartId, customerEmail: customerId, customerToken: HiveStorageManager.getToken(), );
            // final temp = await CartApiManager.getPaymentProviders(regionId);
            HiveStorageManager.setCartId("");
            // AuthApiManager.updateCustomer({
            //   'metadata': {
            //     'cartId' : ""
            //   },
            // });
           await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.black.withOpacity(0.5),
              enableDrag: false, // Disable default full-area drag
              isDismissible: true,
              builder: (ctx) {
                return const DraggableSheetWrapper();
              },
            );
           setState(() {
             error = context.read<LocaleProvider>().test;
           });

            },
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: const Alignment(0, 0),
            child: const Text("Submit" , style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),),
          ),
        ),
        Expanded(child: DataViewer(data: error)),
      ],
    );
  }
}



class DataViewer extends StatelessWidget {
  final dynamic data; // Accepts various data types
  final double textSize;
  final EdgeInsetsGeometry padding;
  final String title;

  const DataViewer({
    super.key,
    required this.data,
    this.textSize = 14.0,
    this.padding = const EdgeInsets.all(16.0),
    this.title = "Formatted Data Viewer",
  });

  /// Formats the input [displayData] for display.
  ///
  /// This method handles different types of data:
  /// 1. Null: Returns "null".
  /// 2. String:
  ///    - If the string is valid JSON (e.g., `http.Response.body` that is JSON, or any JSON string),
  ///      it's parsed and pretty-printed.
  ///    - If the string is not JSON (e.g., normal text, `http.Response.body` that is plain text),
  ///      it's returned as is, with a clarifying note.
  /// 3. Map<String, dynamic> (and other Dart objects):
  ///    - Attempts to convert the object to a JSON string (using `json.encode`, which respects `toJson()` methods).
  ///    - If successful, the resulting JSON is then pretty-printed.
  ///    - If `json.encode` fails (e.g., the object is not directly serializable and lacks a suitable `toJson()` method),
  ///      it falls back to the object's `toString()` method.
  String _formatData(dynamic displayData) {
    try {
      if (displayData == null) {
        return "null";
      }

      // Case 1: Input data is a String.
      // This handles:
      // - Plain text strings.
      // - JSON strings (e.g., from an API like http.Response.body).
      if (displayData is String) {
        try {
          // Attempt to parse and pretty-print if it's a JSON string.
          var decodedJson = json.decode(displayData); // Parses JSON string to Map/List.
          var encoder = const JsonEncoder.withIndent('  '); // 2 spaces for indentation.
          return encoder.convert(decodedJson); // Converts Map/List back to a formatted JSON string.
        } catch (e) {
          // If it's a string but not valid JSON (e.g., plain text, malformed JSON).
          // This path will be taken for "normal Text" or an http.Response.body that isn't JSON.
          return "--- Plain String (or invalid JSON String) ---\n$displayData";
        }
      }
      // Case 2: Input data is NOT a String.
      // This handles:
      // - Map<String, dynamic>.
      // - Lists.
      // - Custom Dart objects (if they have a toJson() method or are otherwise serializable by json.encode).
      else {
        try {
          // Attempt to convert the Dart object to a JSON string, then pretty-print.
          // json.encode will call toJson() on the object if it exists and
          // if toJson() returns a value that json.encode knows how to serialize
          // (e.g., Map, List, String, num, bool, null).
          // This directly handles Map<String, dynamic>.
          String compactJsonString = json.encode(displayData);

          // Now decode this compact JSON string to get a Map/List structure,
          // then re-encode with indent for pretty printing.
          var decodedForPrettyPrint = json.decode(compactJsonString);
          var encoder = const JsonEncoder.withIndent('  ');
          return encoder.convert(decodedForPrettyPrint);
        } catch (e1) {
          // If json.encode(displayData) failed (e.g., object not directly serializable
          // and no suitable toJson() method was found by json.encode).
          // Fall back to the object's toString() method.
          final e1FirstLine = e1.toString().split('\n').first;
          try {
            return "--- Dart Object (fallback to toString(), JSON conversion failed: $e1FirstLine) ---\n${displayData.toString()}";
          } catch (e2) {
            final e2FirstLine = e2.toString().split('\n').first;
            return "Error converting object to string: $e2FirstLine\n(Also failed to convert to JSON: $e1FirstLine)\n\nObject runtimeType: ${displayData.runtimeType}";
          }
        }
      }
    } catch (e) {
      // Catch-all for any unexpected errors during the formatting process.
      final eFirstLine = e.toString().split('\n').first;
      return "An unexpected error occurred while formatting data: $eFirstLine\n\nOriginal data runtimeType: ${displayData.runtimeType}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDataString = _formatData(data);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
      body: SingleChildScrollView(
        padding: padding,
        child: SelectableText(
          formattedDataString,
          style: TextStyle(
            fontFamily: 'monospace', // Use a monospaced font for better alignment of JSON/Map data.
            fontSize: textSize,
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
          ),
        ),
      ),
    );
  }
}





class DraggableSheetWrapper extends StatefulWidget {

  const DraggableSheetWrapper({super.key });

  @override
  State<DraggableSheetWrapper> createState() => _DraggableSheetWrapperState();
}

class _DraggableSheetWrapperState extends State<DraggableSheetWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dragOffset = 0.0;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _phoneAuthKey = GlobalKey<FormState>();

  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    Future.microtask(() {
      context.read<AddressesProvider>().loadAllAddressData();
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.primaryDelta!;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragOffset > 100) {
      Navigator.of(context).pop(); // Smooth close
    } else {
      _controller.forward(from: 0); // Snap back
      setState(() => _dragOffset = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sheetHeight = screenHeight * 0.8;
    return Transform.translate(
      offset: Offset(0, _dragOffset.clamp(0.0, sheetHeight)),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(defaultBorderRadious), topLeft: Radius.circular(defaultBorderRadious)), // your top border radius constant
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  _isSelecting = false;
                });
              },
              child: Form(
                key: _phoneAuthKey,
                child: Material(
                  color: Colors.white,
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.8,
                    minChildSize: 0.8,
                    maxChildSize: 0.8,
                    expand: false,
                    builder: (context, scrollController) {
                      return Column(

                        children: [
                          GestureDetector(
                            onVerticalDragUpdate: _onVerticalDragUpdate,
                            onVerticalDragEnd: _onVerticalDragEnd,
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Container(
                                width: 40,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          const Divider(height: 1),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enter your phone number",
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "We'll send you a verification code",
                                  ),
                                  const SizedBox(height: 32),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    width: double.infinity,
                                    height: _isSelecting ? 240 : 55,
                                    decoration: BoxDecoration(
                                        color: lightGreyColor,
                                        borderRadius: BorderRadius.circular(defaultBorderRadious)),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Selector<AddressesProvider, Country?>(
                                            selector: (_, prov) => prov.selectedCountry,
                                            builder: (_, country, child) {
                                              WidgetsBinding.instance.addPostFrameCallback((_){
                                                _textEditingController.text = country?.name ?? "";
                                              });
                                              return TextFormField(
                                                controller: _textEditingController,
                                                validator:
                                                RequiredValidator(errorText: "This field is required")
                                                    .call,
                                                readOnly: !_isSelecting,
                                                decoration: InputDecoration(
                                                  prefixIcon: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: defaultPadding * 0.74),
                                                    child: SvgPicture.asset(
                                                      "assets/icons/Address.svg",
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
                                                  contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding- 1),
                                                  suffixIcon: IconButton(
                                                    icon: AnimatedRotation(
                                                      turns: _isSelecting ? 0.5 : 0,
                                                      duration: const Duration(milliseconds: 200),
                                                      child: const Icon(Icons.keyboard_arrow_down_rounded),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isSelecting = !_isSelecting;
                                                      });
                                                    },
                                                  ),
                                                  border: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  enabledBorder: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder: InputBorder.none,
                                                  hintText: "Country/Region",
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(color: greyColor),
                                                  filled: false,
                                                  // contentPadding: const EdgeInse(vertical: 21.0),
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(color: Colors.black87),
                                                onChanged: (value){
                                                  context.read<AddressesProvider>().filterCountries(value);
                                                },
                                                onTap: () {
                                                  setState(() {
                                                    _isSelecting = true;
                                                  });
                                                },
                                              );
                                            }
                                        ),
                                        if (_isSelecting) const Divider(height: 1, thickness: 1),
                                        if (_isSelecting)
                                          Expanded(
                                            child: Scrollbar(
                                              controller: _scrollController,
                                              interactive: true, // Allows dragging the thumb
                                              thumbVisibility: true, // Always show the thumb
                                              thickness: 8.0, // Set a comfortable thickness
                                              radius: const Radius.circular(4.0),
                                              child: Selector<AddressesProvider, List<Country>>(
                                                  selector: (_, prov) => prov.filteredCountries,
                                                  builder: (_, countries, child) {
                                                    return ListView.builder(
                                                      controller: _scrollController,
                                                      padding: EdgeInsets.zero,
                                                      itemCount: countries.length,
                                                      itemBuilder: (_, index) {
                                                        if (countries.isEmpty) {
                                                          return const Center(child: Text("No matching countries"));
                                                        }
                                                        final country = countries[index];
                                                        return ListTile(
                                                          leading: Text(
                                                            country.emoji,
                                                            style: const TextStyle(fontSize: 28),
                                                          ),
                                                          title: Text(country.name),
                                                          trailing: Text(
                                                            '+${country.phoneCode}',
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black54,
                                                            ),
                                                          ),

                                                          onTap: () {
                                                            Provider.of<AddressesProvider>(context, listen: false)
                                                                .setCountry(country);
                                                            setState(() {
                                                              _isSelecting = false;
                                                            });
                                                            FocusScope.of(context).unfocus();
                                                          },
                                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                                        );
                                                      },
                                                    );
                                                  }
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: defaultPadding * 2),

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

                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_phoneAuthKey.currentState!.validate()) {
                                        _phoneAuthKey.currentState?.save();
                                        dynamic test = await AuthApiManager.phoneAuth(phoneController.text, context.read<AddressesProvider>().selectedCountry!.iSO2.toUpperCase(), true);
                                        if(context.mounted){
                                          context.read<LocaleProvider>().setTest(test);
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    child: const Text("Save address"),
                                  ),
                                  const SizedBox(height: defaultPadding * 2),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Selector<LoginProvider, bool>(
                selector: (_, prov) => prov.loginLoading,
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
      ),
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}