import 'package:flutter/material.dart';
import '../../../../components/network_image_with_loader.dart';
import '../../../../models/home_items_models/boxes_inline_boxes_model.dart';
import '../../../../models/home_items_models/global_list_icons_model.dart';
import '../../../../route/route_constants.dart';

import '../../../../components/skleton/others/categories_skelton.dart';
import '../../../../components/skleton/others/offers_skelton.dart';
import '../../../../components/skleton/skelton.dart';
import '../../../../constants.dart';
import '../../../../models/home_items_models/slider_items_model.dart';
import 'categories.dart';
import 'offers_carousel.dart';

class OffersCarouselAndCategories extends StatelessWidget {
  const OffersCarouselAndCategories({
    super.key, required this.sliderAndBoxesModel,
  });
  final SliderAndBoxesModel? sliderAndBoxesModel;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading use 👇
        // const OffersSkelton(),
        sliderAndBoxesModel != null?
          OffersCarousel(sliderAndBoxesModel: sliderAndBoxesModel!):
          const OffersSkelton(),
        const SizedBox(height: defaultPadding / 2),
        sliderAndBoxesModel != null ?
        AspectRatio(
          aspectRatio: 2.65,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              padding: const EdgeInsets.all(defaultPadding /2),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: sliderAndBoxesModel!.sideBox.length,
              itemBuilder: (_, index){
                return AspectRatio(
                  aspectRatio: 1.65,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, productDetailsScreenRoute);
                    },
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
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, defaultPadding, defaultPadding /2, defaultPadding),
                            child: NetworkImageWithLoader(
                                sliderAndBoxesModel!.sideBox[index].cover.url
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 80 , top: defaultPadding, bottom: defaultPadding , left: defaultPadding /2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sliderAndBoxesModel!.sideBox[index].title,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "\$${sliderAndBoxesModel!.sideBox[index].promoPrice.toString()}",
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "\$${sliderAndBoxesModel!.sideBox[index].regularPrice.toString()}",
                                  maxLines: 1,
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Color(0xFF8b90a3),
                                    color:Color(0xFF8b90a3),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index){
                return const SizedBox(width: defaultPadding / 2,);
              },
            ),
          ),
        ): const SideBoxSkeleton(),
        const SizedBox(height: defaultPadding / 2),

      ],
    );
  }
}


class InlineBoxesWidget extends StatelessWidget {
  const InlineBoxesWidget({super.key, required this.inlineBoxes});
  final List<InlineBoxItem>? inlineBoxes;
  @override
  Widget build(BuildContext context) {
    return inlineBoxes != null?
    AspectRatio(
      aspectRatio: 2.5,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          padding: const EdgeInsets.all(defaultPadding /2),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: inlineBoxes!.length,
          itemBuilder: (_, index){
            return AspectRatio(
              aspectRatio: 1.65,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                elevation: 4,
                shadowColor: Colors.black12,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    // Your onTap logic
                    print('Box tapped');
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            0, defaultPadding * 2, defaultPadding / 2, defaultPadding * 2),
                        child: NetworkImageWithLoader(inlineBoxes![index].cover.url),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 100,
                          top: defaultPadding,
                          bottom: defaultPadding,
                          left: defaultPadding / 2,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              inlineBoxes![index].title,
                              style: const TextStyle(color: Colors.black, fontSize: 13),
                            ),
                            Text(
                              inlineBoxes![index].description,
                              maxLines: 3,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              inlineBoxes![index].legend,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

          },
          separatorBuilder: (_, index){
            return const SizedBox(width: defaultPadding / 2,);
          },
        ),
      ),
    ): const SideBoxSkeleton();
  }
}



class ProductCategoriesWidget extends StatelessWidget {
  const ProductCategoriesWidget({super.key, required this.globalListIconsModel});
  final GlobalListIconsModel? globalListIconsModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding),
        // Padding(
        //   padding: const EdgeInsets.all(defaultPadding),
        //   child: Text(
        //     "Categories",
        //     style: Theme.of(context).textTheme.titleSmall,
        //   ),
        // ),
        // While loading use 👇
        globalListIconsModel == null ?
        const CategoriesSkelton():
        Categories(globalListIconsModel: globalListIconsModel!,),
        const SizedBox(height: defaultPadding /4),
      ],
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


