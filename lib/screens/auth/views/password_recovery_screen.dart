import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../providers/auth/password_recovery_provider.dart';

class PasswordRecoveryScreen extends StatelessWidget {
   PasswordRecoveryScreen({super.key});
  final passwordRecoveryFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Text(
                "Password recovery",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: defaultPadding / 2),
              const Text("Enter your E-mail address to recover your password"),
              const SizedBox(height: defaultPadding * 2),
              Form(
                key: passwordRecoveryFormKey,
                child: TextFormField(
                  autofocus: true,
                  onSaved: (emal) {
                    context.read<PasswordRecoveryProvider>().email = emal ?? "";
                  },
                  validator: emaildValidator.call,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email address",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 0.75),
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
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if(passwordRecoveryFormKey.currentState!.validate()) {
                    passwordRecoveryFormKey.currentState?.save();
                    context.read<PasswordRecoveryProvider>().sendResetPasswordRequest(context);
                  }

                },
                child: const Text("Next"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
