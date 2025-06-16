import 'package:bloom/providers/profile_providers/addresses_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../components/list_tile/divider_list_tile.dart';
import '../../../components/network_image_with_loader.dart';
import '../../../constants.dart';
import '../../../models/customer_models/customer_details_model.dart';
import '../../../providers/profile_providers/customer_details_provider.dart';
import '../../../route/screen_export.dart';
import '../../../screens/profile/views/components/favorite_banner.dart';
import '../../../utils/api_manager.dart';
import '../../../utils/hive_manager.dart';

import 'components/profile_card.dart';
import 'components/profile_menu_item_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Selector<CustomerDetailsProvider, CustomerDetailsModel?>(
            selector: (_ , prov) => prov.customerDetailsModel,
            builder: (_, customer, child) {
              return ProfileCard(
                name: customer?.firstName,
                email: customer?.email,
                imageSrc: "",
                // proLableText: "Sliver",
                // isPro: true, if the user is pro
                press: HiveStorageManager.signedInNotifier.value ?  () {
                  Navigator.pushNamed(context, userInfoScreenRoute);
                } : (){
                  Navigator.pushReplacementNamed(context, logInScreenRoute);
                },
              );
            }
          ),

          const FavoriteBanner(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //       horizontal: defaultPadding, vertical: defaultPadding * 1.5),
          //   child: GestureDetector(
          //     onTap: () async {
          //
          //     },
          //     child: const AspectRatio(
          //       aspectRatio: 1.8,
          //       child:
          //       NetworkImageWithLoader("https://i.imgur.com/dz0BBom.png"),
          //     ),
          //   ),
          // ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          //   child: Text(
          //     "Account",
          //     style: Theme.of(context).textTheme.titleSmall,
          //   ),
          // ),
          const SizedBox(height: defaultPadding),
          ProfileMenuListTile(
            text: "Orders",
            svgSrc: "assets/icons/Order.svg",
            press: () {
              Navigator.pushNamed(context, ordersScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: "Returns",
            svgSrc: "assets/icons/Return.svg",
            press: () {},
          ),
          ProfileMenuListTile(
            text: "Wishlist",
            svgSrc: "assets/icons/Wishlist.svg",
            press: () {},
          ),
          ProfileMenuListTile(
            text: "Addresses",
            svgSrc: "assets/icons/Address.svg",
            press: () {
              ApiManager.getAddresses();
              Navigator.pushNamed(context, addressesScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: "Payment",
            svgSrc: "assets/icons/card.svg",
            press: () {
              Navigator.pushNamed(context, emptyPaymentScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: "Wallet",
            svgSrc: "assets/icons/Wallet.svg",
            press: () {
              Navigator.pushNamed(context, walletScreenRoute);
            },
          ),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Text(
              "Personalization",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          DividerListTileWithTrilingText(
            svgSrc: "assets/icons/Notification.svg",
            title: "Notification",
            trilingText: "Off",
            press: () {
              Navigator.pushNamed(context, enableNotificationScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: "Preferences",
            svgSrc: "assets/icons/Preferences.svg",
            press: () {
              Navigator.pushNamed(context, preferencesScreenRoute);
            },
          ),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Text(
              "Settings",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "Language",
            svgSrc: "assets/icons/Language.svg",
            press: () {
              Navigator.pushNamed(context, selectLanguageScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: "Location",
            svgSrc: "assets/icons/Location.svg",
            press: () {},
          ),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Text(
              "Help & Support",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "Get Help",
            svgSrc: "assets/icons/Help.svg",
            press: () {
              Navigator.pushNamed(context, getHelpScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: "FAQ",
            svgSrc: "assets/icons/FAQ.svg",
            press: () {},
            isShowDivider: false,
          ),
          const SizedBox(height: defaultPadding),

          // Log Out
          ListTile(
            onTap:HiveStorageManager.signedInNotifier.value ? () {
              HiveStorageManager.setSignedIn(false);
              HiveStorageManager.setToken("");
              context.read<CustomerDetailsProvider>().customerDetailsModel = null;
              Navigator.pushNamedAndRemoveUntil(context, logInScreenRoute, ModalRoute.withName(profileScreenRoute));
            }: (){
              Navigator.pushReplacementNamed(context, signUpScreenRoute);
            } ,
            minLeadingWidth: 24,
            leading: SvgPicture.asset(
              "assets/icons/Logout.svg",
              height: 24,
              width: 24,
              colorFilter: const ColorFilter.mode(
                errorColor,
                BlendMode.srcIn,
              ),
            ),
            title: Text(
              HiveStorageManager.signedInNotifier.value ? "Log Out" : "Sign Up",
              style: const TextStyle(color: errorColor, fontSize: 14, height: 1),
            ),
          )
        ],
      ),
    );
  }
}
