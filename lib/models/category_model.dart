class CategoryModel {
  final String id;
  final String name;
  final String? parentCategoryId;
  CategoryModel({
    required this.id,
    required this.name,
    this.parentCategoryId
});
factory CategoryModel.fromJson(Map<String, dynamic> json){
  return CategoryModel(
      id: json['id'],
      name: json['name'],
      parentCategoryId: json['parent_category_id']);
}

  @override
  String toString() {
    return 'CategoryModel{name: $name}';
  }


}



// class CategoryModel {
//   final String id;
//   final String name;
//   final String description;
//   final String handle;
//   final int rank;
//   final String parentCategoryId;
//   final ParentCategoryModel? parentCategory;
//   final List<CategoryChildrenModel>? categoryChildren;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? deletedAt;
//
//   CategoryModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.handle,
//     required this.rank,
//     required this.parentCategoryId,
//     this.parentCategory,
//     this.categoryChildren,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//   });
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'] ?? '',
//       handle: json['handle'] ?? '',
//       rank: json['rank'] ?? 0,
//       parentCategoryId: json['parent_category_id'] ?? '',
//       parentCategory: json['parent_category'] != null
//           ? ParentCategoryModel.fromJson(json['parent_category'])
//           : null,
//       categoryChildren: json['category_children'] != null
//           ? List<CategoryChildrenModel>.from(
//         (json['category_children'] as List)
//             .map((item) => CategoryChildrenModel.fromJson(item)),
//       )
//           : null,
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       deletedAt:
//       json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'handle': handle,
//       'rank': rank,
//       'parent_category_id': parentCategoryId,
//       'parent_category': parentCategory?.toJson(),
//       'category_children': categoryChildren?.map((e) => e.toJson()).toList(),
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'deleted_at': deletedAt?.toIso8601String(),
//     };
//   }
// }
//
// class ParentCategoryModel {
//   final String id;
//   final String name;
//   final String description;
//   final String handle;
//   final int rank;
//   final Map<String, dynamic>? metadata;
//   final String? parentCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   ParentCategoryModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.handle,
//     required this.rank,
//     this.metadata,
//     this.parentCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory ParentCategoryModel.fromJson(Map<String, dynamic> json) {
//     return ParentCategoryModel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'] ?? '',
//       handle: json['handle'] ?? '',
//       rank: json['rank'] ?? 0,
//       metadata: json['metadata'] != null
//           ? Map<String, dynamic>.from(json['metadata'])
//           : null,
//       parentCategoryId: json['parent_category_id'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'handle': handle,
//       'rank': rank,
//       'metadata': metadata,
//       'parent_category_id': parentCategoryId,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//     };
//   }
// }
//
// class CategoryChildrenModel {
//   final String id;
//   final String name;
//   final String description;
//   final String handle;
//   final String mpath;
//   final bool isActive;
//   final bool isInternal;
//   final int rank;
//   final Map<String, dynamic>? metadata;
//   final String parentCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   CategoryChildrenModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.handle,
//     required this.mpath,
//     required this.isActive,
//     required this.isInternal,
//     required this.rank,
//     this.metadata,
//     required this.parentCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory CategoryChildrenModel.fromJson(Map<String, dynamic> json) {
//     return CategoryChildrenModel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'] ?? '',
//       handle: json['handle'] ?? '',
//       mpath: json['mpath'] ?? '',
//       isActive: json['is_active'] ?? false,
//       isInternal: json['is_internal'] ?? false,
//       rank: json['rank'] ?? 0,
//       metadata: json['metadata'] != null
//           ? Map<String, dynamic>.from(json['metadata'])
//           : null,
//       parentCategoryId: json['parent_category_id'] ?? '',
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'handle': handle,
//       'mpath': mpath,
//       'is_active': isActive,
//       'is_internal': isInternal,
//       'rank': rank,
//       'metadata': metadata,
//       'parent_category_id': parentCategoryId,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//     };
//   }
// }
