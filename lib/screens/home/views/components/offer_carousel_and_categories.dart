import 'package:flutter/material.dart';
import '../../../../components/network_image_with_loader.dart';
import '../../../../models/home_items_models/main_models/boxes_inline_boxes_model.dart';
import '../../../../components/skleton/skelton.dart';
import '../../../../constants.dart';



// class InlineBoxesWidget extends StatelessWidget {
//   const InlineBoxesWidget({super.key, required this.inlineBoxes});
//   final List<InlineBoxItem>? inlineBoxes;
//   @override
//   Widget build(BuildContext context) {
//     return inlineBoxes != null?
//     inlineBoxes!.length == 1 ? SizedBox(
//       height: 50,
//       child: NetworkImageWithLoader(inlineBoxes![0].cover.url,fullScreen: false, fit: BoxFit.contain,width: MediaQuery.of(context).size.width - defaultPadding,alignment: const Alignment(0, 0),),
//     ):
//     SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: inlineBoxes?[0].cover.height?.toDouble() ?? 40,
//       child: ListView.separated(
//         padding: const EdgeInsets.all(defaultPadding /2),
//         physics: const BouncingScrollPhysics(),
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount: inlineBoxes!.length,
//         itemBuilder: (_, index){
//           InlineBoxItem inlineBoxItem = inlineBoxes![index];
//           int width =  inlineBoxItem.cover.width ?? 0  ;
//           int height =  inlineBoxItem.cover.height ?? 0  ;
//           return AspectRatio(
//             aspectRatio: width / height,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: () {
//                 // Your onTap logic
//                 print('Box tapped');
//               },
//               child: Stack(
//                 children: [
//                   NetworkImageWithLoader(inlineBoxes![index].cover.url),
//                 ],
//               ),
//             ),
//           );
//
//         },
//         separatorBuilder: (_, index){
//           return const SizedBox(width: defaultPadding / 2,);
//         },
//       ),
//     ): const SideBoxSkeleton();
//   }
// }




class InlineBoxesWidget extends StatelessWidget {
  const InlineBoxesWidget({super.key, required this.model});
  final BoxesInlineBoxesModel model;

  @override
  Widget build(BuildContext context) {
    if (model.items.isEmpty) {
      return const SideBoxSkeleton();
    }

    final screenWidth = MediaQuery.of(context).size.width;

    // Get how many columns per row (fallback to 1)
    final int crossAxisCount = model.colsRow ?? 1;

    // Use dimensions from first item
    final tempItem = model.items[0];
    final double itemWidth = (tempItem.coverApp?.width ?? tempItem.cover.width ?? 100).toDouble();
    final double itemHeight = (tempItem.coverApp?.height ?? tempItem.cover.height ?? 100).toDouble();

    // Case: Only one item → full width
    if (model.items.length == 1) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding /2),
        height: itemHeight,
        width: screenWidth,
        child: NetworkImageWithLoader(
          tempItem.cover.url,
          fullScreen: false,
          fit: BoxFit.contain,
          width: screenWidth,
          alignment: Alignment.center,
        ),
      );
    }

    // Multiple items → GridView using colsRow
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: model.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding / 2,
          mainAxisSpacing: defaultPadding / 2,
          childAspectRatio: itemWidth / itemHeight,
        ),
        itemBuilder: (context, index) {
          final item = model.items[index];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // Add tap action if needed
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: NetworkImageWithLoader(item.coverApp == null ? item.cover.url : item.coverApp!.url , fullScreen: true,),
            ),
          );
        },
      ),
    );
  }
}














class SideBoxSkeleton extends StatelessWidget {
  const SideBoxSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.65,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          padding: const EdgeInsets.all(defaultPadding /2),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (_, index){
            return AspectRatio(
              aspectRatio: 1.65,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12, // Soft and subtle shadow
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 2), // Minimal downward offset
                    ),
                  ],
                ),
                child: const Stack(
                  children: [
                    Align(
                      alignment: Alignment(1, 0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, defaultPadding, defaultPadding /2, defaultPadding),
                        child: Skeleton(height: double.infinity, width: 70,)
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 80 , top: defaultPadding, bottom: defaultPadding , left: defaultPadding /2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeleton(height: 20,),
                          Spacer(),
                          Skeleton(height: 20, width: 50,),
                          SizedBox(height: defaultPadding/2),
                          Skeleton(height: 20, width: 70,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, index){
            return const SizedBox(width: defaultPadding / 2,);
          },
        ),
      ),
    );
  }
}


