class GlobalTestimonialsModel {
  final int id;
  final String title;
  final String legend;
  final int number;
  final String? extraSpace;

  GlobalTestimonialsModel({
    required this.id,
    required this.title,
    required this.legend,
    required this.number,
    required this.extraSpace,
  });

  factory GlobalTestimonialsModel.fromJson(Map<String, dynamic> json) {
    return GlobalTestimonialsModel(
      id: json['id'],
      title: json['title'] ?? '',
      legend: json['legend'] ?? '',
      number: json['number'] ?? 0,
      extraSpace: json['extra_space'],
    );
  }
}
