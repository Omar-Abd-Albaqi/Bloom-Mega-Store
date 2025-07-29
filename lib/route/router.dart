import 'package:animations/animations.dart';
import 'package:bloom/models/cart_models/order_model.dart';
import 'package:bloom/models/cart_models/payment_collection_model.dart';
import 'package:bloom/screens/all_categories/componenbts/show_all_categories_screen.dart';
import 'package:bloom/screens/checkout/views/components/select_shipping_option_screen.dart';
import 'package:bloom/screens/checkout/views/payment_review_screen.dart';
import 'package:flutter/material.dart';
import '../entry_point.dart';
import '../models/category_model.dart';
import '../providers/cart_page_provider/cart_page_provider.dart';
import '../screens/checkout/views/chose_address_screen.dart';
import '../screens/checkout/views/thanks_for_order_screen.dart';
import '../screens/language/view/select_language_screen.dart';
import '../screens/payment/views/add_new_card_screen.dart';
import '../screens/product_list/product_list_screen.dart';
import '../screens/profile/views/favorite_screen.dart';
import '../screens/splash/splash_screen.dart';

import '../constants.dart';
import '../screens/all_categories/all_categories_screen.dart';
import 'screen_export.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case onbordingScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const OnBordingScreen(),
      );
    case notificationPermissionScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const NotificationPermissionScreen(),
      );
    case preferredLanuageScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PreferredLanguageScreen(),
      );
    case logInScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case signUpScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );
    case profileSetupScreenRoute:
      return MaterialPageRoute(
        builder: (context) =>  ProfileSetupScreen(),
      );
    case passwordRecoveryScreenRoute:
      return MaterialPageRoute(
        builder: (context) =>  PasswordRecoveryScreen(),
      );
    case verificationMethodScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const VerificationMethodScreen(),
      );
    case otpScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const OtpScreen(),
      );
    case newPasswordScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SetNewPasswordScreen(),
      );
    case doneResetPasswordScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const DoneResetPasswordScreen(),
      );
    case termsOfServicesScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const TermsOfServicesScreen(),
      );
    case noInternetScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const NoInternetScreen(),
      );
    case serverErrorScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const ServerErrorScreen(),
      );
    case signUpVerificationScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SignUpVerificationScreen(),
      );
    case setupFingerprintScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SetupFingerprintScreen(),
      );
    case setupFaceIdScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SetupFaceIdScreen(),
      );
    case productDetailsScreenRoute:
      return MaterialPageRoute(
        builder: (context) {
          Map<String , dynamic>? data = settings.arguments as Map<String, dynamic>? ?? {};
          return ProductDetailsScreen(isProductAvailable: data['isProductAvailable'] ?? true, productId: data['productId'],);
        },
      );
    case productReviewsScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const ProductReviewsScreen(),
      );
    case addReviewsScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const AddReviewScreen(),
      );
    case homeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case brandScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const BrandScreen(),
      );
    case discoverWithImageScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const DiscoverWithImageScreen(),
      );
    case subDiscoverScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SubDiscoverScreen(),
      );
    case discoverScreenRoute:
      return MaterialPageRoute(
        builder: (context) =>  DiscoverScreen(),
      );
    case onSaleScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const OnSaleScreen(),
      );
    case kidsScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const KidsScreen(),
      );
    case searchScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      );
    case searchHistoryScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SearchHistoryScreen(),
      );
    case bookmarkScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PromotionScreen(),
      );
    case entryPointScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EntryPoint(),
      );
    case profileScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      );
    case getHelpScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const GetHelpScreen(),
      );
    case chatScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      );
    case userInfoScreenRoute:
      return MaterialPageRoute(
        builder: (context) {
          return const UserInfoScreen();
        },
      );
    case currentPasswordScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const CurrentPasswordScreen(),
      );
    case editUserInfoScreenRoute:
      return MaterialPageRoute(
        builder: (context) => EditUserInfoScreen(),
      );
    case notificationsScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const NotificationsScreen(),
      );
    case noNotificationScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const NoNotificationScreen(),
      );
    case enableNotificationScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EnableNotificationScreen(),
      );
    case notificationOptionsScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const NotificationOptionsScreen(),
      );
    case selectLanguageScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SelectLanguageScreen(),
      );
    case noAddressScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const NoAddressScreen(),
      );
    case addressesScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const AddressesScreen(),
      );
    case addNewAddressesScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const AddNewAddressScreen(),
      );
    case ordersScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const OrdersScreen(),
      );
    case orderProcessingScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const OrderProcessingScreen(),
      );
    case orderDetailsScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const OrderDetailsScreen(),
      );
    case cancleOrderScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const CancleOrderScreen(),
      );
    case deliveredOrdersScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const DelivereOrdersdScreen(),
      );
    case cancledOrdersScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const CancledOrdersScreen(),
      );
    case preferencesScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PreferencesScreen(),
      );
    case emptyPaymentScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EmptyPaymentScreen(),
      );
    case emptyWalletScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EmptyWalletScreen(),
      );
    case walletScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const WalletScreen(),
      );
    case cartScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const CartScreen(),
      );
    case paymentMethodScreenRoute:
      List<PaymentProviderModel> payments = settings.arguments as List<PaymentProviderModel> ?? [];
      return MaterialPageRoute(
        builder: (context) => PaymentMethodScreen(payments: payments),
      );
    case paymentScreenRoutePath:
      PaymentCollection paymentCollection = settings.arguments as PaymentCollection;
      return MaterialPageRoute(
          builder: (context) => PaymentCollectionScreen(paymentCollection: paymentCollection));
    case addNewCardScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const AddNewCardScreen(),
      );
    case thanksForOrderScreenRoute:
      OrderModel order = settings.arguments as OrderModel;
      return MaterialPageRoute(
        builder: (context) => ThanksForOrderScreen(order: order),
      );
    case splashScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case allCategoriesRoute:
      return MaterialPageRoute(
          builder: (context) =>  AllCategoriesScreen());
    case selectShippingOptionPath:
      return MaterialPageRoute(
          builder: (context) => const SelectShippingOptionScreen());

    case choseAddressScreenPath:
      return MaterialPageRoute(
          builder: (context) =>  const ChoseAddressScreen());
    case productListScreenRoute:
      return MaterialPageRoute(
          builder: (context) {
              String catId = settings.arguments as String? ?? "";
            return ProductListScreen(catId: catId,);
            },
      );
    case favoriteScreenRoute:
      return MaterialPageRoute(builder: (context)=> const FavoriteScreen());
    case showAllCategoriesRout:
      List<CategoryModel> categories = settings.arguments as List<CategoryModel>;
      return MaterialPageRoute(builder: (context) => ShowAllCategoriesScreen(categories: categories,));
    default:
      return MaterialPageRoute(
        // Make a screen for undefine
        builder: (context) => const OnBordingScreen(),
      );
  }
}
 Widget _animatedRoute(Widget widget){
  return PageTransitionSwitcher(
    duration: defaultDuration,
    transitionBuilder: (child, animation, secondAnimation) {
      return FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondAnimation,
        child: child,
      );
    },
    child: widget,
  );
 }
