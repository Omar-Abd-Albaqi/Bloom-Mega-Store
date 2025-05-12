import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/customer_models/customer_details_model.dart';
import '../../../providers/profile_providers/customer_details_provider.dart';
import '../../../route/route_constants.dart';

import '../../profile/views/components/profile_card.dart';
import 'components/user_info_list_tile.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, editUserInfoScreenRoute);
            },
            child: const Text("Edit"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Selector<CustomerDetailsProvider, CustomerDetailsModel?>(
          selector: (_, prov) => prov.customerDetailsModel,
          builder: (_, customerDetailsModel, child) {
            return Column(
              children: [
                const SizedBox(height: defaultPadding),
                 ProfileCard(
                  name: customerDetailsModel?.firstName,
                  email: customerDetailsModel?.email,
                  imageSrc: "",
                  // proLableText: "Sliver",
                  // isPro: true, if the user is pro
                  isShowHi: false,
                  isShowArrow: false,
                ),
                const SizedBox(height: defaultPadding * 1.5),
                 UserInfoListTile(
                  leadingText: "Name",
                  trailingText: "${customerDetailsModel?.firstName} ${customerDetailsModel?.lastName}",
                ),
                 UserInfoListTile(
                  leadingText: "Date of birth",
                  trailingText: customerDetailsModel?.metadata['date_of_birth'] == null || customerDetailsModel?.metadata['date_of_birth'] == "" ? "Undefined" : customerDetailsModel?.metadata['date_of_birth'],
                ),
                 UserInfoListTile(
                  leadingText: "Phone number",
                  trailingText: "+961-${customerDetailsModel?.phone == null || customerDetailsModel!.phone!.isEmpty ? "Undefined" : customerDetailsModel!.phone!}",
                ),
                 UserInfoListTile(
                  leadingText: "Gender",
                  trailingText: customerDetailsModel?.metadata['gender'] == "" || customerDetailsModel?.metadata['gender'] == null ? "Undefined" : customerDetailsModel?.metadata['gender'],
                ),
                 UserInfoListTile(
                  leadingText: "Email",
                  trailingText: customerDetailsModel?.email ?? "",
                ),
                ListTile(
                  leading: const Text("Password"),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, currentPasswordScreenRoute);
                    },
                    child: const Text("Change password"),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
