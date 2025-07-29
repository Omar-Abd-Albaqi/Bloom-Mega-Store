import '../general_models/image_model.dart';

class SlidersWideSliders {
  final String component;
  final int id;
  final String extraSpace;
  final String view;
  final List<SliderItem> item;

  SlidersWideSliders({
    required this.component,
    required this.id,
    required this.extraSpace,
    required this.view,
    required this.item,
  });

  factory SlidersWideSliders.fromJson(Map<String, dynamic> json) {
    return SlidersWideSliders(
      component: json['__component'],
      id: json['id'],
      extraSpace: json['extra_space'],
      view: json['view'],
      item: (json['item'] as List<dynamic>)
          .map((itemJson) => SliderItem.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
    );
  }

}

class SliderItem {
  final int id;
  final String link;
  final ImageModel image;
  final ImageModel? imageApp;

  SliderItem({
    required this.id,
    required this.link,
    required this.image,
     this.imageApp,
  });

  factory SliderItem.fromJson(Map<String, dynamic> json) {
    return SliderItem(
      id: json['id'],
      link: json['link'],
      image: ImageModel.fromJson(json['image'] as Map<String, dynamic>),
      imageApp:json['image_app'] == null ? null :  ImageModel.fromJson(json['image_app'] as Map<String, dynamic>),
    );
  }
}