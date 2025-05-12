class ProductsCategoriesModel {
  final int id;
  final String title;
  final String legend;
  final String? extraSpace;
  final List<ProductCategory> categories;

  ProductsCategoriesModel({
    required this.id,
    required this.title,
    required this.legend,
    this.extraSpace,
    required this.categories,
  });

  factory ProductsCategoriesModel.fromJson(Map<String, dynamic> json) {
    return ProductsCategoriesModel(
      id: json['id'],
      title: json['title'],
      legend: json['legend'],
      extraSpace: json['extra_space'],
      categories: (json['categories'] as List)
          .map((e) => ProductCategory.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'legend': legend,
      'extra_space': extraSpace,
      'categories': categories.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ProductsCategoriesModel{id: $id, title: $title, legend: $legend, extraSpace: $extraSpace, categories: $categories}';
  }
}





class ProductCategory {
  final int id;
  final String name;
  final String url;
  final String? target;
  final CategoryIcon icon;

  ProductCategory({
    required this.id,
    required this.name,
    required this.url,
    this.target,
    required this.icon,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      target: json['target'],
      icon: CategoryIcon.fromJson(json['icon']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'target': target,
      'icon': icon.toJson(),
    };
  }

  @override
  String toString() {
    return 'ProductCategory{id: $id, name: $name, url: $url, target: $target, icon: $icon}';
  }
}

class CategoryIcon {
  final int id;
  final String documentId;
  final String name;
  final String? alternativeText;
  final String? caption;
  final int? width;
  final int? height;
  final dynamic formats;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String? previewUrl;
  final String provider;
  final dynamic providerMetadata;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;

  CategoryIcon({
    required this.id,
    required this.documentId,
    required this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  factory CategoryIcon.fromJson(Map<String, dynamic> json) {
    return CategoryIcon(
      id: json['id'],
      documentId: json['documentId'],
      name: json['name'],
      alternativeText: json['alternativeText'],
      caption: json['caption'],
      width: json['width'],
      height: json['height'],
      formats: json['formats'],
      hash: json['hash'],
      ext: json['ext'],
      mime: json['mime'],
      size: (json['size'] as num).toDouble(),
      url: json['url'],
      previewUrl: json['previewUrl'],
      provider: json['provider'],
      providerMetadata: json['provider_metadata'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentId': documentId,
      'name': name,
      'alternativeText': alternativeText,
      'caption': caption,
      'width': width,
      'height': height,
      'formats': formats,
      'hash': hash,
      'ext': ext,
      'mime': mime,
      'size': size,
      'url': url,
      'previewUrl': previewUrl,
      'provider': provider,
      'provider_metadata': providerMetadata,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'publishedAt': publishedAt,
    };
  }
}
