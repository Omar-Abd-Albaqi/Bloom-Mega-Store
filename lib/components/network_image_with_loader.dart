import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/local_storage_models/product_model/product_model.dart';

import '../constants.dart';
import '../screens/product/views/components/favorite_button.dart';
import 'skleton/skelton.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final BoxFit fit;

  const NetworkImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
    this.radius = defaultPadding,
        this.fullScreen = false,
        this.product
  });

  final String src;
  final double radius;
  final bool? fullScreen;
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          child: CachedNetworkImage(
            fit: fit,
            imageUrl: src,
            imageBuilder: (context, imageProvider) => Align(
              alignment:Alignment.centerRight,
              child: Image(
                image: imageProvider,
                fit: fit,
                height: double.infinity,
                width: fullScreen! ? double.infinity : null,
              ),
            ),
            placeholder: (context, url) => const Skeleton(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        if(product != null)
        Align(
            alignment: const Alignment(0.9, -0.9),
            child: FavoriteButton(product: product!)),
      ],
    );

  }
}
