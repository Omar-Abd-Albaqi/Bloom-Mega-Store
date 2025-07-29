import '../general_models/cover_model.dart';

class BoxesInlineBoxesModel {
  final int id;
  final int? colsRow;
  final List<InlineBoxItem> items;

  BoxesInlineBoxesModel({
    required this.id,
     this.colsRow,
    required this.items,
  });

  factory BoxesInlineBoxesModel.fromJson(Map<String, dynamic> json) {
    return BoxesInlineBoxesModel(
      id: json['id'],
      colsRow: json['cols_row_mobile'],
      items: (json['items'] as List)
          .map((item) => InlineBoxItem.fromJson(item))
          .toList(),
    );
  }
}

class InlineBoxItem {
  final int id;
  final String ctaLink;
  final Cover cover;
  final Cover? coverApp;

  InlineBoxItem({
    required this.id,
    required this.ctaLink,
    required this.cover,
    this.coverApp
  });

  factory InlineBoxItem.fromJson(Map<String, dynamic> json) {
    return InlineBoxItem(
      id: json['id'],
      ctaLink: json['cta_link'] ?? "",
      cover: Cover.fromJson(json['cover']),
      coverApp: json['cover_app'] == null ? null : Cover.fromJson(json['cover_app']),
    );
  }
}
