import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../constants.dart';

class AddressTextField extends StatelessWidget {
  const AddressTextField({super.key, required this.textEditingController, this.prefixIcon, required this.hint, this.onSaved});
  final TextEditingController textEditingController;
  final String? prefixIcon;
  final String hint;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: RequiredValidator(errorText: "This field is required").call,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon == null ? null : Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultPadding * 0.74),
          child: SvgPicture.asset(
            prefixIcon!,
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
    );
  }
}
