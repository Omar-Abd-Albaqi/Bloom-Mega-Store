import '../../models/home_items_models/products_promo_banner.dart';

class BoxesInlineBoxesModel {
  final int id;
  final String extraSpace;
  final List<InlineBoxItem> items;

  BoxesInlineBoxesModel({
    required this.id,
    required this.extraSpace,
    required this.items,
  });

  factory BoxesInlineBoxesModel.fromJson(Map<String, dynamic> json) {
    return BoxesInlineBoxesModel(
      id: json['id'],
      extraSpace: json['extra_space'],
      items: (json['items'] as List)
          .map((item) => InlineBoxItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'extra_space': extraSpace,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class InlineBoxItem {
  final int id;
  final String title;
  final String description;
  final String ctaText;
  final String ctaLink;
  final String legend;
  final String imagePosition;
  final Cover cover;

  InlineBoxItem({
    required this.id,
    required this.title,
    required this.description,
    required this.ctaText,
    required this.ctaLink,
    required this.legend,
    required this.imagePosition,
    required this.cover,
  });

  factory InlineBoxItem.fromJson(Map<String, dynamic> json) {
    return InlineBoxItem(
      id: json['id'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      ctaText: json['cta_text'] ?? "",
      ctaLink: json['cta_link'] ?? "",
      legend: json['legend'] ??"",
      imagePosition: json['image_position'] ??"",
      cover: Cover.fromJson(json['cover']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'cta_text': ctaText,
      'cta_link': ctaLink,
      'legend': legend,
      'image_position': imagePosition,
      'cover': cover.toJson(),
    };
  }
}
