import 'package:animations/animations.dart';
import 'package:bloom/models/category_model.dart';
import 'package:bloom/providers/cart_page_provider/cart_page_provider.dart';
import 'package:bloom/providers/home_page_provider/category_provider.dart';
import 'package:bloom/screens/checkout/views/empty_cart_screen.dart';
import 'package:bloom/testing.dart';
import 'package:bloom/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../providers/entry_point_providers/nav_bar_provider.dart';
import '../../providers/profile_providers/customer_details_provider.dart';
import '../../route/screen_export.dart';
import '../../screens/all_categories/all_categories_screen.dart';
import '../../utils/hive_manager.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final List _pages = [

    const HomeScreen(),
    // AllCategoriesScreen(),
     AllCategoriesScreen(),
    const TestingClass(),
    // const BookmarkScreen(),
    // const EmptyCartScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    if(HiveStorageManager.signedInNotifier.value){
      context.read<CustomerDetailsProvider>().getCustomerDetails();
    }
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<CartPageProvider>().getCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
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
            // pinned: true,
            // floating: true,
            // snap: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: const SizedBox(),
            leadingWidth: 0,
            centerTitle: false,
            title: Image.asset(
              "assets/Bloom-04.png",
              width: 100,
            ),
            actions: currentIndex == 1 ? [
              Container(
                margin: const EdgeInsets.only(right: defaultPadding),
                width: MediaQuery.of(context).size.width * 0.65,
                height: kToolbarHeight * 0.8,
                child: TextFormField(
                  onChanged: (value){
                    context.read<CategoryProvider>().filterSubCategories(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search categories...',
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
                        // Add your search logic here
                        // For example, you might get the text from a TextEditingController
                        // and then perform a search.
                        print('Search button pressed');
                      },
                    ),
                  ),
                  style: const TextStyle(fontSize: 16.0),
                  // controller: _searchController, // You'll likely want a TextEditingController
                  // onFieldSubmitted: (value) {
                  //   // Add your search logic for when the user submits (e.g., presses enter)
                  //   print('Search submitted: $value');
                  // },
                ),
              )
            ]:[
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
          ) ,
          // body: _pages[_currentIndex],
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
              // selectedLabelStyle: TextStyle(color: primaryColor),
              selectedFontSize: 12,
              selectedItemColor: primaryColor,
              unselectedItemColor: Colors.transparent,
              items: [
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/Shop.svg"),
                  activeIcon: svgIcon("assets/icons/Shop.svg", color: primaryColor),
                  label: "Shop",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/Category.svg"),
                  activeIcon:
                      svgIcon("assets/icons/Category.svg", color: primaryColor),
                  label: "Categories",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/Bookmark.svg"),
                  activeIcon:
                      svgIcon("assets/icons/Bookmark.svg", color: primaryColor),
                  label: "Bookmark",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/Bag.svg"),
                  activeIcon: svgIcon("assets/icons/Bag.svg", color: primaryColor),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/Profile.svg"),
                  activeIcon:
                      svgIcon("assets/icons/Profile.svg", color: primaryColor),
                  label: "Profile",
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
