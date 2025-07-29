import 'package:bloom/extensions/locale_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth/sign_up_provider.dart';
import '../../../screens/auth/views/components/sign_up_form.dart';
import '../../../route/route_constants.dart';

import '../../../constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/signUp_dark.png",
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.loc.letsgetstarted,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                   Text(
                    context.loc.signuptitle,
                  ),
                  const SizedBox(height: defaultPadding),
                  SignUpForm(formKey: _formKey),
                  const SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      Selector<SignUpProvider,bool>(
                        selector: (_ , prov) => prov.agree,
                        builder: (_ , agree , child) {
                          return Checkbox(
                            onChanged: (value) {
                              context.read<SignUpProvider>().setAgree(value ?? false);
                            },
                            value: agree,
                          );
                        }
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: context.loc.agreement,
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, termsOfServicesScreenRoute);
                                  },
                                text: " ${context.loc.termsofservices} ",
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(
                                text: "& privacy policy.",
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  ElevatedButton(
                    onPressed: () async {

                      bool agree = context.read<SignUpProvider>().agree;
                      if (_formKey.currentState!.validate() && agree) {
                        _formKey.currentState!.save();
                        Navigator.pushNamed(context, profileSetupScreenRoute, arguments: _formKey);
                      }else{
                        print(_formKey.currentState?.toStringShort());
                      }
                    },
                    child: Text(context.loc.continueword),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(context.loc.doyouhaveanaccount),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, logInScreenRoute);
                        },
                        child:Text(context.loc.login),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
