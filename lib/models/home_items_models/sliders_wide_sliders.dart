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

  Map<String, dynamic> toJson() {
    return {
      '__component': component,
      'id': id,
      'extra_space': extraSpace,
      'view': view,
      'item': item.map((i) => i.toJson()).toList(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'link': link,
      'image': image.toJson(),
      'image_app': imageApp?.toJson(),
    };
  }
}

class ImageModel {
  final int id;
  final String documentId;
  final String name;
  final String? alternativeText;
  final String? caption;
  final int width;
  final int height;
  final ImageFormats formats;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String? previewUrl;
  final String provider;
  final dynamic providerMetadata; // Can be null or any type
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  ImageModel({
    required this.id,
    required this.documentId,
    required this.name,
    this.alternativeText,
    this.caption,
    required this.width,
    required this.height,
    required this.formats,
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

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      documentId: json['documentId'],
      name: json['name'],
      alternativeText: json['alternativeText'],
      caption: json['caption'],
      width: json['width'],
      height: json['height'],
      formats: ImageFormats.fromJson(json['formats'] as Map<String, dynamic>),
      hash: json['hash'],
      ext: json['ext'],
      mime: json['mime'],
      size: (json['size'] as num).toDouble(),
      url: json['url'],
      previewUrl: json['previewUrl'],
      provider: json['provider'],
      providerMetadata: json['provider_metadata'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      publishedAt: DateTime.parse(json['publishedAt']),
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
      'formats': formats.toJson(),
      'hash': hash,
      'ext': ext,
      'mime': mime,
      'size': size,
      'url': url,
      'previewUrl': previewUrl,
      'provider': provider,
      'provider_metadata': providerMetadata,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'publishedAt': publishedAt.toIso8601String(),
    };
  }
}

class ImageFormats {
  final ImageFormatDetails? large;
  final ImageFormatDetails? small;
  final ImageFormatDetails? medium;
  final ImageFormatDetails? thumbnail;

  ImageFormats({
    this.large,
    this.small,
    this.medium,
    this.thumbnail,
  });

  factory ImageFormats.fromJson(Map<String, dynamic> json) {
    return ImageFormats(
      large: json['large'] != null ? ImageFormatDetails.fromJson(json['large'] as Map<String, dynamic>) : null,
      small: json['small'] != null ? ImageFormatDetails.fromJson(json['small'] as Map<String, dynamic>) : null,
      medium: json['medium'] != null ? ImageFormatDetails.fromJson(json['medium'] as Map<String, dynamic>) : null,
      thumbnail: json['thumbnail'] != null ? ImageFormatDetails.fromJson(json['thumbnail'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (large != null) 'large': large!.toJson(),
      if (small != null) 'small': small!.toJson(),
      if (medium != null) 'medium': medium!.toJson(),
      if (thumbnail != null) 'thumbnail': thumbnail!.toJson(),
    };
  }
}

class ImageFormatDetails {
  final String ext;
  final String url;
  final String hash;
  final String mime;
  final String name;
  final String? path;
  final double size;
  final int width;
  final int height;
  final int sizeInBytes;

  ImageFormatDetails({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    this.path,
    required this.size,
    required this.width,
    required this.height,
    required this.sizeInBytes,
  });

  factory ImageFormatDetails.fromJson(Map<String, dynamic> json) {
    return ImageFormatDetails(
      ext: json['ext'],
      url: json['url'],
      hash: json['hash'],
      mime: json['mime'],
      name: json['name'],
      path: json['path'],
      size: (json['size'] as num).toDouble(),
      width: json['width'],
      height: json['height'],
      sizeInBytes: json['sizeInBytes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ext': ext,
      'url': url,
      'hash': hash,
      'mime': mime,
      'name': name,
      'path': path,
      'size': size,
      'width': width,
      'height': height,
      'sizeInBytes': sizeInBytes,
    };
  }
}