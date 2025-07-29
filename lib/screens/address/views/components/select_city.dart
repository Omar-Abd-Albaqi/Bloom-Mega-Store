import 'package:bloom/providers/profile_providers/addresses_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';


class SelectCity extends StatefulWidget {
  const SelectCity({super.key});

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
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
          Selector<AddressesProvider, CityModel?>(
            selector: (_, prov) => prov.selectedCity,
            builder: (_, city, child) {
              WidgetsBinding.instance.addPostFrameCallback((_){
                _textEditingController.text = city?.name ?? "";
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
                      "assets/icons/city.svg",
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
                  hintText: "City",
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
                  context.read<AddressesProvider>().filterCities(value);
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
              child: Selector<AddressesProvider, List<CityModel>>(
                  selector: (_, prov) => prov.filteredCities,
                  builder: (_, cities, child) {
                    if(cities.isEmpty){
                      return const Center(
                        child: Text('No matching cities'),
                      );
                    }
                  return Scrollbar(
                    controller: _controller,
                    interactive: true,
                    thumbVisibility: true,
                    thickness: 8.0,
                    radius: const Radius.circular(4.0),
                    child: ListView.builder(
                      controller: _controller,
                      padding: EdgeInsets.zero,
                      itemCount: cities.length,
                      itemBuilder: (_, index) {
                        final city = cities[index];
                        return ListTile(
                          title: Text(city.name),
                          onTap: () {
                            Provider.of<AddressesProvider>(context, listen: false)
                                .setCity(city);
                            setState(() {
                              _isSelecting = false;
                            });
                            FocusScope.of(context).unfocus();
                          },
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                        );
                      },
                    ),
                  );
                }
              ),
            )
        ],
      ),
    );
  }
}