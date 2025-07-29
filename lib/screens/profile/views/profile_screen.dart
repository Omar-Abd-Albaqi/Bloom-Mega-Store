import 'package:bloom/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../components/list_tile/divider_list_tile.dart';
import '../../../constants.dart';
import '../../../models/customer_models/customer_details_model.dart';
import '../../../providers/profile_providers/customer_details_provider.dart';
import '../../../route/screen_export.dart';
import '../../../screens/profile/views/components/favorite_banner.dart';
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
            text: context.loc.orders,
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
            text: context.loc.wishlist,
            svgSrc: "assets/icons/Wishlist.svg",
            press: () {},
          ),
          ProfileMenuListTile(
            text: context.loc.addresses,
            svgSrc: "assets/icons/Address.svg",
            press: () {
              Navigator.pushNamed(context, addressesScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: context.loc.payment,
            svgSrc: "assets/icons/card.svg",
            press: () {
              Navigator.pushNamed(context, emptyPaymentScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: context.loc.wallet,
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
              context.loc.personalization,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          DividerListTileWithTrilingText(
            svgSrc: "assets/icons/Notification.svg",
            title: context.loc.notification,
            trilingText: "Off",
            press: () {
              Navigator.pushNamed(context, enableNotificationScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: context.loc.preferences,
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
              context.loc.settings,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: context.loc.languages,
            svgSrc: "assets/icons/Language.svg",
            press: () {
              Navigator.pushNamed(context, selectLanguageScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: context.loc.location,
            svgSrc: "assets/icons/Location.svg",
            press: () {},
          ),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Text(
              context.loc.helpandsupport,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: context.loc.gethelp,
            svgSrc: "assets/icons/Help.svg",
            press: () {
              Navigator.pushNamed(context, getHelpScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: context.loc.faq,
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
            leading: HiveStorageManager.signedInNotifier.value? SvgPicture.asset(
               "assets/icons/Logout.svg",
              height: 24,
              width: 24,
              colorFilter: const ColorFilter.mode(
                errorColor,
                BlendMode.srcIn,
              ),
            ) : const Icon(Icons.login , color: Colors.green,),
            title: Text(
              HiveStorageManager.signedInNotifier.value ? context.loc.logout : context.loc.signup,
              style:  TextStyle(color: HiveStorageManager.signedInNotifier.value ? errorColor: Colors.green, fontSize: 14, height: 1),
            ),
          )
        ],
      ),
    );
  }
}
