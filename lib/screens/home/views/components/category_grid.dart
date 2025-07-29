import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../components/skleton/skelton.dart';
import '../../../../constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../models/home_items_models/main_models/products_categories.dart';
import '../../../../route/route_constants.dart';

class CategoryGrid extends StatelessWidget {
  final ProductsCategoriesModel model; // Replace with your actual model

  const CategoryGrid({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // You can customize how many items per row depending on screen width
    int crossAxisCount = screenWidth > 900
        ? 7
        : screenWidth > 600
        ? 5
        : 3;

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

    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Scroll outside if needed
        itemCount: model.categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: defaultPadding ,
          crossAxisSpacing: defaultPadding ,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final category = model.categories[index];
            print(getName(L10n.getLocalizedCategory(context, category.name ?? "")));
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
                  child: CachedNetworkImage(
                    imageUrl: category.icon!.url,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Skeleton(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    getName(L10n.getLocalizedCategory(context, category.name ?? "")),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
