class CategoryModelDummy {
  final String title;
  final String? image, svgSrc;
  final List<CategoryModelDummy>? subCategories;

  CategoryModelDummy({
    required this.title,
    this.image,
    this.svgSrc,
    this.subCategories,
  });
}

final List<CategoryModelDummy> demoCategoriesWithImage = [
  CategoryModelDummy(title: "Woman’s", image: "https://i.imgur.com/5M89G2P.png"),
  CategoryModelDummy(title: "Man’s", image: "https://i.imgur.com/UM3GdWg.png"),
  CategoryModelDummy(title: "Kid’s", image: "https://i.imgur.com/Lp0D6k5.png"),
  CategoryModelDummy(title: "Accessories", image: "https://i.imgur.com/3mSE5sN.png"),
];

final List<CategoryModelDummy> demoCategories = [
  CategoryModelDummy(
    title: "On sale",
    svgSrc: "assets/icons/Sale.svg",
    subCategories: [
      CategoryModelDummy(title: "All Clothing"),
      CategoryModelDummy(title: "New In"),
      CategoryModelDummy(title: "Coats & Jackets"),
      CategoryModelDummy(title: "Dresses"),
      CategoryModelDummy(title: "Jeans"),
    ],
  ),
  CategoryModelDummy(
    title: "Man’s & Woman’s",
    svgSrc: "assets/icons/Man&Woman.svg",
    subCategories: [
      CategoryModelDummy(title: "All Clothing"),
      CategoryModelDummy(title: "New In"),
      CategoryModelDummy(title: "Coats & Jackets"),
    ],
  ),
  CategoryModelDummy(
    title: "Kids",
    svgSrc: "assets/icons/Child.svg",
    subCategories: [
      CategoryModelDummy(title: "All Clothing"),
      CategoryModelDummy(title: "New In"),
      CategoryModelDummy(title: "Coats & Jackets"),
    ],
  ),
  CategoryModelDummy(
    title: "Accessories",
    svgSrc: "assets/icons/Accessories.svg",
    subCategories: [
      CategoryModelDummy(title: "All Clothing"),
      CategoryModelDummy(title: "New In"),
    ],
  ),
];
