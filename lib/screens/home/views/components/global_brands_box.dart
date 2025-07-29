import 'package:bloom/components/network_image_with_loader.dart';
import 'package:bloom/extensions/locale_extension.dart';
import 'package:bloom/utils/hive_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/home_items_models/main_models/global_brands_box.dart';


class GlobalBrandsBox extends StatelessWidget {
  const GlobalBrandsBox({super.key, required this.globalBrandsBox});
  final GlobalBrandsBoxModel globalBrandsBox;

  @override
  Widget build(BuildContext context) {
    final bool isRTL = HiveStorageManager.getLocale() == "ar";
    final List<BrandItem> brands = globalBrandsBox.brands;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: NetworkImageWithLoader(globalBrandsBox.cover.url),
              ),
              const SizedBox(width: defaultPadding,),
              Text(context.loc.brands ,style: Theme.of(context).textTheme.titleMedium,)
            ],
          ),
        ),
        GridView.builder(
          padding: const EdgeInsets.all(defaultPadding / 2),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Prevents inner scroll if inside another scroll view
          itemCount: brands.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // 3 items per row
            childAspectRatio: 6, // width / height
            crossAxisSpacing: 8.0, // spacing between items (optional)
            mainAxisSpacing: 8.0,
          ),
            itemBuilder: (context, index) {
              final BrandItem brand = brands[index];

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: isRTL? const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ) :const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: brand.brand.logo,
                        ),
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width - 80 - defaultPadding,
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding /2),
                      decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: isRTL ? const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ) : const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            brand.brand.category ?? "",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            brand.brand.name,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );

            }

        ),
        const SizedBox(height: defaultPadding,)
      ],
    );
  }
}
