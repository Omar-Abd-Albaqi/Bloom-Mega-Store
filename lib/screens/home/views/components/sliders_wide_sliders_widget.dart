import 'package:bloom/models/home_items_models/sliders_wide_sliders.dart';
import 'package:bloom/screens/home/views/components/offers_carousel.dart';
import 'package:flutter/material.dart';

class SlidersWideSlidersWidget extends StatelessWidget {
  const SlidersWideSlidersWidget({super.key, required this.sliders});
  final SlidersWideSliders sliders;

  @override
  Widget build(BuildContext context) {
    return OffersCarousel(length: sliders.item.length,titles: null, imageUrls: sliders.item.map((item) => item.imageApp?.url ?? item.image.url).toList(),showButton: false,aspectRatio: sliders.item[0].imageApp == null ? sliders.item[0].image.width / sliders.item[0].image.height: sliders.item[0].imageApp!.width / sliders.item[0].imageApp!.height,);
  }
}
