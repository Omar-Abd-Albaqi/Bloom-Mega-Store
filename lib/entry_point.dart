import 'package:animations/animations.dart';
import 'package:bloom/extensions/locale_extension.dart';
import 'package:bloom/providers/cart_page_provider/cart_page_provider.dart';
import 'package:bloom/providers/home_page_provider/category_provider.dart';
import 'package:bloom/providers/home_page_provider/home_items_provider.dart';
import 'package:bloom/screens/checkout/views/payment_review_screen.dart';
import 'package:bloom/screens/checkout/views/thanks_for_order_screen.dart';
import 'package:bloom/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../providers/entry_point_providers/nav_bar_provider.dart';
import '../../providers/profile_providers/customer_details_provider.dart';
import '../../route/screen_export.dart';
import '../../screens/all_categories/all_categories_screen.dart';
import '../../utils/hive_manager.dart';
import 'models/home_items_models/main_models/product_product_category.dart';
import 'models/home_items_models/main_models/products_list_products.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {

   final List<Widget> _pages = [
     const HomeScreen(),
     // AllCategoriesScreen(),
     AllCategoriesScreen(),
     const TestingClass(),
     // EmptyPromotionScreen(),
     // const EmptyCartScreen(),
     const CartScreen(),
     const ProfileScreen(),
   ];

   Future<void> getHomePageItems() async {
     final prov = context.read<HomeItemsProvider>();
     await prov.getHomePageItems(context);
     List<dynamic> homeItems = prov.homeModels;
     for(var element in homeItems){
       if (element.runtimeType == ProductsProductsCategory){
         await prov.getProductListFromCategory( (element as ProductsProductsCategory).category!.medusaId!);
       }
       if(element.runtimeType == ProductsListProductsModel){
         await prov.getProductListFromCollection( (element as ProductsListProductsModel).collection!.medusaId!);
       }
     }
   }

   Future<void> getInitialData() async {
     getHomePageItems();
     if(HiveStorageManager.signedInNotifier.value){
       await context.read<CustomerDetailsProvider>().getCustomerDetails(context);
     }
     WidgetsBinding.instance.addPostFrameCallback((_){
       context.read<CartPageProvider>().getCart(context);
     });
   }

  @override
  void initState() {
    super.initState();
    getInitialData();
    // getHomePageItems();
    // if(HiveStorageManager.signedInNotifier.value){
    //   context.read<CustomerDetailsProvider>().getCustomerDetails(context);
    // }
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   context.read<CartPageProvider>().getCart(context);
    // });
  }


  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color, double height = 24}) {
      return SvgPicture.asset(
        src,
        height: height,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }
    return Selector<NavBarProvider, int>(
      selector: (_, prov) => prov.index,
      builder: (_, currentIndex, child) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: const SizedBox(),
            leadingWidth: 0,
            centerTitle: false,
            title: Image.asset(
              "assets/Bloom-04.png",
              width: 100,
            ),
            actions: switch(currentIndex){
              1 => [
                Container(
                  margin: const EdgeInsets.only(right: defaultPadding),
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: kToolbarHeight * 0.8,
                  child: TextFormField(
                    onChanged: (value){
                      context.read<CategoryProvider>().filterSubCategories(value);
                    },
                    decoration: InputDecoration(
                      hintText: context.loc.searchcategories,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultBorderRadious), // Corrected: defaultBorderRadius
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultBorderRadious), // Corrected: defaultBorderRadius
                        borderSide: const BorderSide( // Added const
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultBorderRadious), // Corrected: defaultBorderRadius
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white, // Or your desired background color
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      suffixIcon: IconButton( // Added suffixIcon
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          print('Search button pressed');
                        },
                      ),
                    ),
                    style: const TextStyle(fontSize: 16.0),

                  ),
                )
              ],
            3 =>  [
              Selector<CartPageProvider, bool>(
                selector: (_ , prov) => prov.needSave,
                builder: (_, needReset, child){
                  if(!needReset){
                    return const SizedBox.shrink();
                  }
                  return  GestureDetector(
                    onTap: (){
                      context.read<CartPageProvider>().resetCart();
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: kToolbarHeight,
                      width: 100,
                      alignment: const Alignment(0, 0),
                      child: const Row(
                        children: [
                          Text("Reset cart" , style: TextStyle(color: Colors.red),),
                          Icon(Icons.restart_alt_outlined , color: Colors.red,)
                        ],
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: currentIndex == 1 ? (){} : () {
                  Navigator.pushNamed(context, discoverScreenRoute);
                },
                icon: SvgPicture.asset(
                  "assets/icons/Search.svg",
                  height: 24,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyLarge!.color!,
                      BlendMode.srcIn),
                ),
              ),
              IconButton(
                onPressed: () async {
                },
                icon: SvgPicture.asset(
                  "assets/icons/Notification.svg",
                  height: 24,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyLarge!.color!,
                      BlendMode.srcIn),
                ),
              ),

            ],
              int() => [
                IconButton(
                  onPressed: currentIndex == 1 ? (){} : () {
                    Navigator.pushNamed(context, discoverScreenRoute);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Search.svg",
                    height: 24,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.bodyLarge!.color!,
                        BlendMode.srcIn),
                  ),
                ),
                IconButton(
                  onPressed: () async {
// context.read<CategoryProvider>().getCategories();
// Navigator.pushNamed(context, brandScreenRoute);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Notification.svg",
                    height: 24,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.bodyLarge!.color!,
                        BlendMode.srcIn),
                  ),
                ),
              ],
            }
          ) ,

          body: PageTransitionSwitcher(
            duration: defaultDuration,
            transitionBuilder: (child, animation, secondAnimation) {
              return FadeThroughTransition(
                fillColor: Theme.of(context).brightness == Brightness.dark ? blackColor: Colors.white,
                animation: animation,
                secondaryAnimation: secondAnimation,
                child: child,
              );
            },
            child: _pages[currentIndex],
          ),


          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(top: defaultPadding / 2),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF101015),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                if (index != currentIndex) {
                  context.read<NavBarProvider>().setIndex(index);
                }
              },
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF101015),
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              selectedItemColor: primaryColor,
              unselectedItemColor: Colors.transparent,
              items: [
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/Shop.svg"),
                  activeIcon: svgIcon("assets/icons/Shop.svg", color: primaryColor),
                  label: context.loc.shop,
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/Category.svg"),
                  activeIcon: svgIcon("assets/icons/Category.svg", color: primaryColor),
                  label: context.loc.categories,
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/promotion_BNB.svg" , height: 28),
                  activeIcon: svgIcon("assets/icons/promotion_BNB.svg", color: primaryColor, height: 28),
                  label: context.loc.promotions,
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/Bag.svg"),
                  activeIcon: svgIcon("assets/icons/Bag.svg", color: primaryColor),
                  label: context.loc.cart,
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/Profile.svg"),
                  activeIcon: svgIcon("assets/icons/Profile.svg", color: primaryColor),
                  label: context.loc.profile,
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}

