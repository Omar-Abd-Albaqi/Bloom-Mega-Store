import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';




// class Categories extends StatelessWidget {
//   const Categories({
//     super.key, required this.globalListIconsModel,
//   });
//   final GlobalListIconsModel globalListIconsModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           ...List.generate(
//             globalListIconsModel.icons!.length,
//             (index) => Padding(
//               padding: EdgeInsets.only(
//                   left: index == 0 ? defaultPadding : defaultPadding / 2,
//                   right:
//                       index == demoCategories.length - 1 ? defaultPadding : 0),
//               child: CategoryBtn(
//                 category: globalListIconsModel.icons![index].title!,
//                 svgSrc: globalListIconsModel.icons![index].icon!.url,
//                 isActive: false,
//                 press: () {
//                   // if (demoCategories[index].route != null) {
//                   //   Navigator.pushNamed(context, demoCategories[index].route!);
//                   // }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.category,
    this.svgSrc,
    required this.isActive,
    required this.press,
  });

  final String category;
  final String? svgSrc;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            if (svgSrc != null)
              // CachedNetworkImage(imageUrl: svgSrc! , height: 20),
              SvgPicture.network(
                svgSrc!,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
            if (svgSrc != null) const SizedBox(width: defaultPadding / 2),
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
