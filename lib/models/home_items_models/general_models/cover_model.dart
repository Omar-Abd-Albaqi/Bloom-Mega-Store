class Cover {
  final int id;
  final String documentId;
  final String name;
  final int? width;
  final int? height;
  final String? alternativeText;
  final String? caption;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String hash;
  final String? previewUrl;
  final String? provider;
  final Map<String, dynamic>? formats;

  Cover({
    required this.id,
    required this.documentId,
    required this.name,
    required this.width,
    required this.height,
    required this.alternativeText,
    required this.caption,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.hash,
    required this.previewUrl,
    required this.provider,
    required this.formats,
  });

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      id: json['id'],
      documentId: json['documentId'],
      name: json['name'],
      width: json['width'],
      height: json['height'],
      alternativeText: json['alternativeText'],
      caption: json['caption'],
      ext: json['ext'],
      mime: json['mime'],
      size: json['size']?.toDouble() ?? 0,
      url: json['url'],
      hash: json['hash'],
      previewUrl: json['previewUrl'],
      provider: json['provider'],
      formats: json['formats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentId': documentId,
      'name': name,
      'width': width,
      'height': height,
      'alternativeText': alternativeText,
      'caption': caption,
      'ext': ext,
      'mime': mime,
      'size': size,
      'url': url,
      'hash': hash,
      'previewUrl': previewUrl,
      'provider': provider,
      'formats': formats,
    };
  }
}