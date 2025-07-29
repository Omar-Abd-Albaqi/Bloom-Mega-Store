class CategoryModel {
  final String id;
  final String name;
  final String? parentCategoryId;
  final String? medusaId;
  final String? handle;
  CategoryModel({
    required this.id,
    required this.name,
    this.parentCategoryId,
    this.medusaId,
    this.handle
});
factory CategoryModel.fromJson(Map<String, dynamic> json){
  return CategoryModel(
      id: json['id'].toString(),
      name: json['name'],
      parentCategoryId: json['parent_category_id'],
      medusaId: json['medusa_id'],
      handle: json['handle']
  );
}
}
