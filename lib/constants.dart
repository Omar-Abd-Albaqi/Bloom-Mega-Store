import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';


const String authority = "shop.bloommegastore.com";
const String strapiAuthority = "cms.bloommegastore.com";
const String registerCustomerPath = "/auth/customer/emailpass/register";
const String authenticateCustomerPath = "/auth/customer/emailpass";
const String createCustomerAccountPath = "/store/customers";
const String refreshAuthenticationTokenPath = "/auth/token/refresh";
const String resetPasswordPath = "/auth/customer/emailpass/reset-password";
const String customerDetailsPath = "/store/customers/me";
const String updateCustomerPath = "/store/customers/me";
const String uploadPath = "/admin/uploads";
const String adminAuthPath = "/admin/auth";
const String categoriesPath = "/store/product-categories";
const String homeItemsPath = "/api/pages";
const Map<String, dynamic> homeItemsParams = {"filters[slug][\$eq]" : "homepage", "pLevel" : ""};
const String productsListPath = "/store/products";
const String collectionPath = "/store/collections";
const String searchProductPath = "/store/products/search";
const String regionPath = "/store/regions";
const String getCartPath = "/store/carts";
const String getCustomerAddressesPath = "/store/customers/me/addresses";
const String productSearchPath = "/store/products/search";
const String gettingShippingOptionsPath = "/store/shipping-options";
const String removeCustomerAddressPath = "/store/customers/me/addresses/";
const String phoneAuthPath = "/auth/customer/phone-auth";


const String publishableKey = "pk_ad1e3b268e86531617f55c7fcede01b65a63f6611edc49c1c13aa027793e5ba7";


// Just for demo
const productDemoImg1 = "https://i.imgur.com/CGCyp1d.png";
const productDemoImg2 = "https://i.imgur.com/AkzWQuJ.png";
const productDemoImg3 = "https://i.imgur.com/J7mGZ12.png";
const productDemoImg4 = "https://i.imgur.com/q9oF9Yq.png";
const productDemoImg5 = "https://i.imgur.com/MsppAcx.png";
const productDemoImg6 = "https://i.imgur.com/JfyZlnO.png";

// End For demo

const grandisExtendedFont = "Grandis Extended";


/*
skip login on th login page
price color
bnv 2nd Categories {
bnv 3rd Promotions
move Facvorite buttn stack on pictures


if not loggeedin
bl pofile
logout => signup on orange
check edit profile phone number
gender is not changeble
}
 */

// On color 80, 60.... those means opacity

const Color primaryColor = Color(0xFFF4AF24);

const MaterialColor primaryMaterialColor =
    MaterialColor(0xFF9581FF, <int, Color>{
  50: Color(0xFF000000),
  100: Color(0xFFD7D0FF),
  200: Color(0xFFBDB0FF),
  300: Color(0xFFA390FF),
  400: Color(0xFF8F79FF),
  500: Color(0xFF7B61FF),
  600: Color(0xFF7359FF),
  700: Color(0xFF684FFF),
  800: Color(0xFF5E45FF),
  900: Color(0xFF6C56DD),
});

const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);

const Color whiteColor = Colors.white;
const Color whileColor80 = Color(0xFFCCCCCC);
const Color whileColor60 = Color(0xFF999999);
const Color whileColor40 = Color(0xFF666666);
const Color whileColor20 = Color(0xFF333333);
const Color whileColor10 = Color(0xFF191919);
const Color whileColor5 = Color(0xFF0D0D0D);

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xFF1C1C25);
// const Color greyColor80 = Color(0xFFC6C4CF);
// const Color greyColor60 = Color(0xFFD4D3DB);
// const Color greyColor40 = Color(0xFFE3E1E7);
// const Color greyColor20 = Color(0xFFF1F0F3);
// const Color greyColor10 = Color(0xFFF8F8F9);
// const Color greyColor5 = Color(0xFFFBFBFC);

const Color purpleColor = Color(0xFF7B61FF);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFEA5B5B);

const double defaultPadding = 16.0;
const double defaultBorderRadious = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(6, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

final nameValidator = MultiValidator([
  RequiredValidator(errorText: 'Full name is required'),
  PatternValidator(
    r'^[A-Za-z]+(?: [A-Za-z]+)+$',
    errorText: 'Enter full name with at least one space (first and last name)',
  ),
]);

final dateOfBirthValidator = MultiValidator([
  RequiredValidator(errorText: 'Date of birth is required'),
  // PatternValidator(
  //   r'^\d{4}-\d{2}-\d{2}$', // Format: yyyy-mm-dd
  //   errorText: 'Enter date in format YYYY-MM-DD',
  // ),
]);

final phoneValidator = MultiValidator([
  RequiredValidator(errorText: 'Phone number is required'),
  PatternValidator(
    r'^\+?\d{8,15}$',
    errorText: 'Enter a valid phone number (9–15 digits)',
  ),
]);



final emaildValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: "Enter a valid email address"),
]);

const pasNotMatchErrorText = "passwords do not match";
