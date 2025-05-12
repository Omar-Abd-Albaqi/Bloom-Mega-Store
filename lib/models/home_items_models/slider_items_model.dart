class SliderAndBoxesModel {
  final int id;
  final String extraSpace;
  final SliderModel slider;
  final List<SideBoxModel> sideBox;

  SliderAndBoxesModel({
    required this.id,
    required this.extraSpace,
    required this.slider,
    required this.sideBox,
  });

  factory SliderAndBoxesModel.fromJson(Map<String, dynamic> json) {
    return SliderAndBoxesModel(
      id: json['id'],
      extraSpace: json['extra_space'] ?? '',
      slider: SliderModel.fromJson(json['slider']),
      sideBox: (json['side_box'] as List)
          .map((e) => SideBoxModel.fromJson(e))
          .toList(),
    );
  }
}

class SliderModel {
  final int id;
  final List<SliderItemModel> items;

  SliderModel({
    required this.id,
    required this.items,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      items: (json['items'] as List)
          .map((e) => SliderItemModel.fromJson(e))
          .toList(),
    );
  }
}

class SliderItemModel {
  final int id;
  final String title;
  final String legend;
  final String description;
  final String ctaText;
  final String ctaLink;
  final ImageModel cover;

  SliderItemModel({
    required this.id,
    required this.title,
    required this.legend,
    required this.description,
    required this.ctaText,
    required this.ctaLink,
    required this.cover,
  });

  factory SliderItemModel.fromJson(Map<String, dynamic> json) {
    return SliderItemModel(
      id: json['id'],
      title: json['title'] ?? '',
      legend: json['legend'] ?? '',
      description: json['description'] ?? '',
      ctaText: json['cta_text'] ?? '',
      ctaLink: json['cta_link'] ?? '',
      cover: ImageModel.fromJson(json['cover']),
    );
  }
}

class SideBoxModel {
  final int id;
  final String title;
  final String? link;
  final double regularPrice;
  final double promoPrice;
  final String priceLegend;
  final ImageModel cover;

  SideBoxModel({
    required this.id,
    required this.title,
    this.link,
    required this.regularPrice,
    required this.promoPrice,
    required this.priceLegend,
    required this.cover,
  });

  factory SideBoxModel.fromJson(Map<String, dynamic> json) {
    return SideBoxModel(
      id: json['id'],
      title: json['title'] ?? '',
      link: json['link'],
      regularPrice: (json['regular_price'] as num).toDouble(),
      promoPrice: (json['promo_price'] as num).toDouble(),
      priceLegend: json['price_legend'] ?? '',
      cover: ImageModel.fromJson(json['cover']),
    );
  }

  @override
  String toString() {
    return 'SideBoxModel{id: $id, title: $title, link: $link, regularPrice: $regularPrice, promoPrice: $promoPrice, priceLegend: $priceLegend, cover: $cover}';
  }
}

class ImageModel {
  final int id;
  final String documentId;
  final String name;
  final int width;
  final int height;
  final String mime;
  final double size;
  final String url;
  final String? alternativeText;
  final String? caption;
  final Map<String, ImageFormatModel>? formats;

  ImageModel({
    required this.id,
    required this.documentId,
    required this.name,
    required this.width,
    required this.height,
    required this.mime,
    required this.size,
    required this.url,
    this.alternativeText,
    this.caption,
    this.formats,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      documentId: json['documentId'] ?? '',
      name: json['name'] ?? '',
      width: json['width'],
      height: json['height'],
      mime: json['mime'] ?? '',
      size: (json['size'] as num).toDouble(),
      url: json['url'] ?? '',
      alternativeText: json['alternativeText'],
      caption: json['caption'],
      formats: json['formats'] != null
          ? (json['formats'] as Map<String, dynamic>).map((key, value) =>
          MapEntry(key, ImageFormatModel.fromJson(value)))
          : null,
    );
  }
}

class ImageFormatModel {
  final String ext;
  final String url;
  final String hash;
  final String mime;
  final String name;
  final double size;
  final int width;
  final int height;
  final int? sizeInBytes;

  ImageFormatModel({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    required this.size,
    required this.width,
    required this.height,
    this.sizeInBytes,
  });

  factory ImageFormatModel.fromJson(Map<String, dynamic> json) {
    return ImageFormatModel(
      ext: json['ext'] ?? '',
      url: json['url'] ?? '',
      hash: json['hash'] ?? '',
      mime: json['mime'] ?? '',
      name: json['name'] ?? '',
      size: (json['size'] as num).toDouble(),
      width: json['width'],
      height: json['height'],
      sizeInBytes: json['sizeInBytes'],
    );
  }
}
