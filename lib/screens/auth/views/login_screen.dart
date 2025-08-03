import 'package:bloom/extensions/locale_extension.dart';
import 'package:bloom/utils/hive_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../providers/auth/login_provider.dart';
import '../../../providers/profile_providers/addresses_provider.dart';
import '../../../route/route_constants.dart';

import '../../../providers/home_page_provider/home_items_provider.dart';
import 'components/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    HiveStorageManager.setIsGuest(false);
    HiveStorageManager.setFirstTime(false);
    super.initState();
  }

  void showFullScreenSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      enableDrag: false, // Disable default full-area drag
      isDismissible: true,
      builder: (context) {
        return _DraggableSheetWrapper();
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/login_dark.png",
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.loc.welcomeback,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: defaultPadding / 2),
                           Text(
                            context.loc.logintitle,
                          ),
                          const SizedBox(height: defaultPadding),
                          LogInForm(
                            formKey: _formKey,
                            onSubmit: (_) {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                context.read<LoginProvider>().login(context);
                              }
                            },
                          ),
                          Align(
                            child: TextButton(
                              child:  Text(context.loc.forgotpassword),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, passwordRecoveryScreenRoute);
                              },
                            ),
                          ),
                          const SizedBox(height: defaultPadding,),
                          // SizedBox(
                          //   height: size.height > 700
                          //       ? size.height * 0.1
                          //       : defaultPadding,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(defaultBorderRadious),
                                onTap: (){},
                                child: Container(
                                  height: 40,
                                  width: 60,
                                  child: SvgPicture.asset("assets/icons/Facebook.svg"),
                                ),
                              ),
                              const SizedBox(width: defaultPadding),
                              InkWell(
                                borderRadius: BorderRadius.circular(defaultBorderRadious),
                                onTap: (){},
                                child: Container(
                                  height: 40,
                                  width: 60,
                                  padding: const EdgeInsets.all(3),
                                  child: SvgPicture.asset("assets/icons/google.svg"),
                                ),
                              ),
                              const SizedBox(width: defaultPadding),
                              InkWell(
                                borderRadius: BorderRadius.circular(defaultBorderRadious),
                                onTap: () => showFullScreenSheet(context),
                                child: Container(
                                  height: 40,
                                  width: 60,
                                  padding: const EdgeInsets.all(3),
                                  child: SvgPicture.asset("assets/icons/Call.svg"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height > 700
                                ? size.height * 0.06
                                : defaultPadding,
                          ),
                          Selector<LoginProvider, bool>(
                              selector: (_, prov) => prov.loginLoading,
                              builder: (_, loading, child) {
                                return ElevatedButton(
                                  onPressed: loading
                                      ? () {}
                                      : () {
                                          if (_formKey.currentState!.validate()) {
                                            _formKey.currentState?.save();
                                            context.read<LoginProvider>().login(context);
                                          }
                                        },
                                  child: loading
                                      ? const SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(),
                                        )
                                      :  Text(context.loc.login),
                                );
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(context.loc.donthaveanaccount),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, signUpScreenRoute);
                                },
                                child:  Text(context.loc.signup),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.9, -0.85),
                child: GestureDetector(
                  onTap: () {
                    context.read<HomeItemsProvider>().getHomePageItems(context);
                    HiveStorageManager.setIsGuest(true);
                    Navigator.pushReplacementNamed(
                      context,
                      entryPointScreenRoute,
                      // ModalRoute.withName(logInScreenRoute),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 35,
                    color: Colors.transparent,
                    alignment: const Alignment(0, 0),
                    child:  Text(
                      context.loc.skiplogin,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
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
    );
  }
}


class _DraggableSheetWrapper extends StatefulWidget {
  @override
  State<_DraggableSheetWrapper> createState() => _DraggableSheetWrapperState();
}

class _DraggableSheetWrapperState extends State<_DraggableSheetWrapper>
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
                                        if(context.mounted){
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