import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../providers/auth/sign_up_provider.dart';

import 'components/setup_profile_form.dart';

class ProfileSetupScreen extends StatelessWidget {
   ProfileSetupScreen({super.key});
  final GlobalKey<FormState> setupFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Setup profile"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/info.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyLarge!.color!,
                BlendMode.srcIn,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                   Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // const UserImageUpload(),
                          Image.asset("assets/Transparent Logo.png"),
                          const SizedBox(height: defaultPadding),
                          SetupProfileForm(setupFormKey: setupFormKey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      // Expanded(
                      //   child: OutlinedButton(
                      //     onPressed: () {
                      //
                      //     },
                      //     child: const Text("Skip"),
                      //   ),
                      // ),
                      // const SizedBox(width: defaultPadding),
                      Selector<SignUpProvider, bool>(
                          selector: (_ , prov) => prov.signUpLoading,
                        builder: (_, loading, child) {
                          return Expanded(
                            child: ElevatedButton(
                              onPressed: loading ? (){} : () async {
                                if (setupFormKey.currentState!.validate()) {
                                  setupFormKey.currentState!.save();
                                  context.read<SignUpProvider>().signUp(context);
                                }
                              },
                              child: loading ? const SizedBox(width: 30,height: 30,child: CircularProgressIndicator(),) : const Text("Sign up"),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Selector<SignUpProvider , bool>(
              selector: (_ , prov) => prov.signUpLoading,
              builder: (_, loading, child) {
                if(loading) {
                  return SizedBox.expand(
                    child: Container(
                      color: primaryColor.withAlpha(20),
                    ),
                  );
                }
                else{
                  return const SizedBox();
                }
              }
          ),
        ],
      ),
    );
  }
}
