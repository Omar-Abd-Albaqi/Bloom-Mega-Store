import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth/login_provider.dart';

import '../../../../constants.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({
    super.key,
    required this.formKey,
    this.onSubmit
  });

  final GlobalKey<FormState> formKey;
  final void Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (emal) {
              context.read<LoginProvider>().email = emal ?? "";
            },
            onFieldSubmitted: onSubmit,
            validator: emaildValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,

            decoration: InputDecoration(
              hintText: "Email address",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Message.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.3),
                      BlendMode.srcIn),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Selector<LoginProvider, bool>(
              selector: (_, prov) => prov.showPass,
              builder: (_, showPass, child) {
              return TextFormField(
                onSaved: (pass) {
                  context.read<LoginProvider>().password = pass ?? "";
                },

                onFieldSubmitted: onSubmit,
                validator: passwordValidator.call,
                obscureText: !showPass,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                    child: SvgPicture.asset(
                      "assets/icons/Lock.svg",
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.3),
                          BlendMode.srcIn),
                    ),
                  ),
                  suffixIcon: Padding(padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                  child: GestureDetector(
                    onTap: (){
                      context.read<LoginProvider>().toggleShowPass();
                    },
                    child: Icon(showPass ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  ),
                  )
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
