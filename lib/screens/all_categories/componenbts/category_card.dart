import 'package:bloom/l10n/l10n.dart';
import 'package:flutter/material.dart';
import '../../../models/category_model.dart';

import '../../../route/route_constants.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

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
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, productListScreenRoute, arguments: categoryModel.id.toString());
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 60,
              width: 60,
              color: Colors.grey[300],
              child: Image.asset("assets/subs.webp"),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            getName(L10n.getLocalizedCategory(context, categoryModel.name)),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
