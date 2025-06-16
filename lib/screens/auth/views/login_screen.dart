import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../providers/auth/login_provider.dart';
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
                            "Welcome back!",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          const Text(
                            "Log in with your data that you intered during your registration.",
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
                              child: const Text("Forgot password"),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, passwordRecoveryScreenRoute);
                              },
                            ),
                          ),
                          SizedBox(
                            height: size.height > 700
                                ? size.height * 0.1
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
                                      : const Text("Log in"),
                                );
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, signUpScreenRoute);
                                },
                                child: const Text("Sign up"),
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
                    Navigator.pushReplacementNamed(
                      context,
                      entryPointScreenRoute,
                      // ModalRoute.withName(logInScreenRoute),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 35,
                    color: Colors.transparent,
                    alignment: const Alignment(0, 0),
                    child: const Text(
                      "Skip login",
                      style: TextStyle(color: Colors.white),
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
