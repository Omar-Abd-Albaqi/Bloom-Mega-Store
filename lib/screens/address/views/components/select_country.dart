import 'package:bloom/constants.dart';
import 'package:bloom/providers/profile_providers/addresses_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({super.key});

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  bool _isSelecting = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
                controller: _controller,
                interactive: true, // Allows dragging the thumb
                thumbVisibility: true, // Always show the thumb
                thickness: 8.0, // Set a comfortable thickness
                radius: const Radius.circular(4.0),
                child: Selector<AddressesProvider, List<Country>>(
                  selector: (_, prov) => prov.filteredCountries,
                  builder: (_, countries, child) {
                    return ListView.builder(
                      controller: _controller,
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
    );
  }
}
