
import 'package:bloom/models/home_items_models/products_promo_banner.dart';

class GlobalCountersModel {
  final int id;
  final String title;
  final String legend;
  final String description;
  final DateTime endAt;
  final String ctaText;
  final String ctaLink;
  final String? extraSpace;
  final Cover cover;

  GlobalCountersModel({
    required this.id,
    required this.title,
    required this.legend,
    required this.description,
    required this.endAt,
    required this.ctaText,
    required this.ctaLink,
    required this.extraSpace,
    required this.cover,
  });

  factory GlobalCountersModel.fromJson(Map<String, dynamic> json) {
    return GlobalCountersModel(
      id: json['id'],
      title: json['title'] ?? '',
      legend: json['legend'] ?? '',
      description: json['description'] ?? '',
      endAt: DateTime.parse(json['end_at']),
      ctaText: json['cta_text'] ?? '',
      ctaLink: json['cta_link'] ?? '',
      extraSpace: json['extra_space'],
      cover: Cover.fromJson(json['cover']),
    );
  }
}
