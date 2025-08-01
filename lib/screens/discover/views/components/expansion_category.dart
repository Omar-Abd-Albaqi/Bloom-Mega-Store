import 'package:flutter/material.dart';
import '../../../../l10n/l10n.dart';
import '../../../../models/category_model.dart';
import '../../../../route/screen_export.dart';

import '../../../../constants.dart';

class ExpansionCategory extends StatelessWidget {
  const ExpansionCategory({
    super.key,
    required this.title,
    required this.subCategory,
    required this.svgSrc,
  });

  final String title, svgSrc;
  final List<CategoryModel> subCategory;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedIconColor: Theme.of(context).textTheme.bodyMedium!.color,
      // leading: SvgPicture.asset(
      //   svgSrc,
      //   height: 24,
      //   width: 24,
      //   colorFilter: ColorFilter.mode(
      //     Theme.of(context).iconTheme.color!,
      //     BlendMode.srcIn,
      //   ),
      // ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      textColor: Theme.of(context).textTheme.bodyLarge!.color,
      childrenPadding: const EdgeInsets.only(left: defaultPadding * 3.5),
      children: List.generate(
        subCategory.length,
        (index) => Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, onSaleScreenRoute);
              },
              title: Text(
                L10n.getLocalizedCategory(context, subCategory[index].name) ,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            if (index < subCategory.length - 1) const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
