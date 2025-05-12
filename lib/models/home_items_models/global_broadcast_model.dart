class GlobalBroadcastModel {
  final int id;
  final String title;
  final String description;
  final String? extraSpace;

  GlobalBroadcastModel({
    required this.id,
    required this.title,
    required this.description,
    required this.extraSpace,
  });

  factory GlobalBroadcastModel.fromJson(Map<String, dynamic> json) {
    return GlobalBroadcastModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      extraSpace: json['extra_space'],
    );
  }
}
