import 'package:bloom/components/skleton/product/products_skelton.dart';
import 'package:bloom/constants.dart';
import 'package:bloom/providers/home_page_provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/product/product_card.dart';
import '../../../models/category_model.dart';
import '../../../models/local_storage_models/product_model/product_model.dart';
import '../../../route/route_constants.dart';
import '../../bookmark/component/bookmarks_skelton.dart';


class ShowAllCategoriesScreen extends StatefulWidget {
  const ShowAllCategoriesScreen({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  State<ShowAllCategoriesScreen> createState() => _ShowAllCategoriesScreenState();
}

class _ShowAllCategoriesScreenState extends State<ShowAllCategoriesScreen> {
  String getName(String name) {
    if (name.contains(" ")) {
      List<String> temp = name.split(" ");
      String allButLast = temp.sublist(0, temp.length - 1).join(" ");
      String last = temp.last;
      return "$allButLast\n$last";
    } else {
      return name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: const Drawer(),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Image.asset(
          "assets/Bloom-04.png",
          width: 100,
        ),
        centerTitle: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: const [SizedBox()],
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            floating: true,
            pinned: false,
            toolbarHeight: 100,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: defaultPadding * 2),
                    itemBuilder: (context, index) {
                      final category = widget.categories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            productListScreenRoute,
                            arguments: category.id.toString(),
                          );
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  "assets/subs.webp",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: Text(
                                getName(category.name),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          ProductDisplay(),



        ],
      ),

    );
  }
}





// Assuming 'ProductModel', 'CategoryProvider', 'BookMarksSlelton',
// 'ProductCard', 'defaultPadding', and 'productDetailsScreenRoute' are defined elsewhere.

// The corrected ProductDisplay widget implementation
class ProductDisplay extends StatelessWidget {
  const ProductDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CategoryProvider, List<ProductModel>?>(
      selector: (_, prov) => prov.products,
      builder: (_, products, __) {
        // If products are null, show the loading skeleton sliver
        if (products == null) {
          return const BookMarksSlelton(); // Must be a sliver widget
        }

        // When products are available, show the content with a fade-in animation
        return SliverFadeIn(
          sliver: SliverLayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 2;
              if (constraints.crossAxisExtent >= 900) {
                crossAxisCount = 4;
              } else if (constraints.crossAxisExtent >= 600) {
                crossAxisCount = 3;
              }

              return SliverPadding(
                padding: const EdgeInsets.all(16.0), // Or your defaultPadding
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.0, // Or your defaultPadding
                    mainAxisSpacing: 16.0, // Or your defaultPadding
                    childAspectRatio: 0.65,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final product = products[index];
                      return ProductCard(
                      image: product.thumbnail,
                      brandName: product.type.value,
                      title: product.title,
                      price: product.variants[0].calculatedPrice!.calculatedAmount.toDouble(),
                      priceAfetDiscount: null,
                      dicountpercent: null,
                      press: () {
                        Navigator.pushNamed(
                            context,
                            productDetailsScreenRoute,
                            arguments: {'productId': products[index].id}
                        );
                      }
                      );


                      },
                    childCount: products.length,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// A sliver version of AnimatedSwitcher
class SliverFadeIn extends StatefulWidget {
  final Widget sliver;
  final Duration duration;

  const SliverFadeIn({
    super.key,
    required this.sliver,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<SliverFadeIn> createState() => _SliverFadeInState();
}

class _SliverFadeInState extends State<SliverFadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFadeTransition(
      opacity: _animation,
      sliver: widget.sliver,
    );
  }
}

