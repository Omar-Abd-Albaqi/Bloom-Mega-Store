class GlobalListIconsModel {
  final int? id;
  final String? extraSpace;
  final List<GlobalListIconItem>? icons;

  GlobalListIconsModel({
    this.id,
    this.extraSpace,
    this.icons,
  });

  factory GlobalListIconsModel.fromJson(Map<String, dynamic> json) {
    return GlobalListIconsModel(
      id: json['id'],
      extraSpace: json['extra_space'],
      icons: (json['icons'] as List<dynamic>?)
          ?.map((e) => GlobalListIconItem.fromJson(e))
          .toList(),
    );
  }
}

class GlobalListIconItem {
  final int? id;
  final String? title;
  final String? subtitle;
  final GlobalListIconImage? icon;

  GlobalListIconItem({
    this.id,
    this.title,
    this.subtitle,
    this.icon,
  });

  factory GlobalListIconItem.fromJson(Map<String, dynamic> json) {
    return GlobalListIconItem(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      icon: json['icon'] != null ? GlobalListIconImage.fromJson(json['icon']) : null,
    );
  }
}

class GlobalListIconImage {
  final int? id;
  final String? documentId;
  final String? name;
  final String? alternativeText;
  final String? caption;
  final int? width;
  final int? height;
  final dynamic formats;
  final String? hash;
  final String? ext;
  final String? mime;
  final double? size;
  final String? url;
  final String? previewUrl;
  final String? provider;
  final dynamic providerMetadata;
  final String? createdAt;
  final String? updatedAt;
  final String? publishedAt;

  GlobalListIconImage({
    this.id,
    this.documentId,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
  });

  factory GlobalListIconImage.fromJson(Map<String, dynamic> json) {
    return GlobalListIconImage(
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
      size: (json['size'] as num?)?.toDouble(),
      url: json['url'],
      previewUrl: json['previewUrl'],
      provider: json['provider'],
      providerMetadata: json['provider_metadata'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
    );
  }
}
