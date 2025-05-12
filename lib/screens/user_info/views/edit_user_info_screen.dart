
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/customer_models/customer_details_model.dart';
import '../../../providers/profile_providers/customer_details_provider.dart';

import 'components/user_info_form.dart';

class EditUserInfoScreen extends StatelessWidget {
   EditUserInfoScreen({super.key});

  final GlobalKey<FormState> editProfileForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/info.svg",
              color: Theme.of(context).iconTheme.color,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Selector<CustomerDetailsProvider, CustomerDetailsModel?>(
                  selector: (_, prov) => prov.customerDetailsModel,
                  builder: (_, customer, child) {
                    return Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Hero(
                              tag: customer?.email ?? "qwerty",
                              child:Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Image.asset("assets/Transparent Logo.png"),
                              )

                            ),
                            // Positioned(
                            //   bottom: -14,
                            //   right: -14,
                            //   child: SizedBox(
                            //     height: 56,
                            //     width: 56,
                            //     child: ElevatedButton(
                            //       onPressed: () async {
                            //         // await PopUps.selectPhotoPickType(context);
                            //       },
                            //       style: ElevatedButton.styleFrom(
                            //         shape: const CircleBorder(),
                            //         side: BorderSide(
                            //             width: 4,
                            //             color: Theme.of(context)
                            //                 .scaffoldBackgroundColor),
                            //       ),
                            //       child: SvgPicture.asset(
                            //         "assets/icons/Edit-Bold.svg",
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        // TextButton(
                        //   onPressed: () async {
                        //     // await PopUps.selectPhotoPickType(context);
                        //   },
                        //   child: const Text("Edit photo"),
                        // ),
                        const SizedBox(height: defaultPadding),
                         UserInfoForm(formState: editProfileForm)
                      ],
                    );
                  }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: ElevatedButton(
                onPressed: () {
                  editProfileForm.currentState?.save();
                  context.read<CustomerDetailsProvider>().updateCustomerInfo(context);
                  Navigator.pop(context);
                },
                child: const Text("Done"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
