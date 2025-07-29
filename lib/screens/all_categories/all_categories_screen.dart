import 'package:bloom/extensions/locale_extension.dart';
import 'package:bloom/l10n/l10n.dart';
import 'package:bloom/utils/hive_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/category_model.dart';
import '../../../providers/home_page_provider/category_provider.dart';
import '../../../screens/all_categories/componenbts/category_card.dart';
import '../../route/route_constants.dart';

class AllCategoriesScreen extends StatelessWidget {
  AllCategoriesScreen({super.key});
  final PageController controller = PageController(initialPage: 0);
  String getName(String name) {
    if (name.contains(" ")) {
      List<String> temp = name.split(" ");
      String allButLast = temp.sublist(0, temp.length - 1).join(" ");
      String last = temp.last;
      return "$allButLast\n$last";
    } else {
      return name;
    }
  }
  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = context.read<CategoryProvider>().categories;
    final List<List<CategoryModel>> subCategories = context.read<CategoryProvider>().subCategories;
    final bool isRTL = HiveStorageManager.getLocale() == "ar";
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              //Categories
              Container(
                color: Colors.blueGrey.withAlpha(40),
                width: MediaQuery.of(context).size.width * 0.30,
                // height: MediaQuery.of(context).size.height - kToolbarHeight  - defaultPadding - 120,
                height: double.infinity,
                child: Selector<CategoryProvider, int>(
                    selector: (_, prov) => prov.selectedCat,
                    builder: (_, selectedIndex, child) {
                      return Stack(
                        children: [
                          AnimatedContainer(
                            margin: EdgeInsets.only(top: (selectedIndex * 50 ) ),
                            duration: const Duration(milliseconds: 200),
                            width: double.infinity,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(left: BorderSide(color: primaryColor, width: 5))
                            ),

                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            // shrinkWrap: true,
                            itemCount: categories.length  ,
                            itemBuilder: (_, index) {
                              bool selected = selectedIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  context.read<CategoryProvider>().setSelectedCat(index);
                                  controller.jumpToPage(index);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: double.infinity,
                                  height: 50,
                                  alignment: const Alignment(0, 0),
                                  color: Colors.transparent,
                                  child: Text(
                                    getName(L10n.getLocalizedCategory(context, categories[index].name)),
                                    // getName(categories[index].name),
                                    textAlign: TextAlign.center,
                                    style:  TextStyle(
                                      color:  Colors.black.withAlpha(selected ? 255 : 120),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, index) => const Divider(height: 0,thickness: 2,endIndent: 5,indent: 5,),
                          ),

                        ],
                      );
                    }
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                    child: InkWell(
                      onTap: (){
                        context.read<CategoryProvider>().getProduct();
                        Navigator.pushNamed(context, showAllCategoriesRout , arguments: categories);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        alignment: const Alignment(0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(context.loc.showall , style: const TextStyle(color: primaryColor , fontSize: 14 , fontWeight: FontWeight.w400),),
                             Icon(isRTL ?Icons.keyboard_arrow_left_rounded :Icons.keyboard_arrow_right_rounded , size: 30,color: primaryColor,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Selector<CategoryProvider, int>(
                    selector: (_, prov) => prov.selectedCat,
                    builder: (_, selected, child) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height - kToolbarHeight  - defaultPadding - 201,
                        child: PageView.builder(
                          controller: controller,
                          itemCount: subCategories.length,
                          onPageChanged: (index) {
                            context.read<CategoryProvider>().setSelectedCat(index);
                          },
                          itemBuilder: (_, pageIndex) {
                            List<CategoryModel> subCats = subCategories[pageIndex];
                            return Align(
                              alignment: Alignment.topCenter,
                              child: GridView.builder(
                                key: ValueKey(pageIndex),
                                padding: const EdgeInsets.all(12),
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.76,
                                ),
                                itemCount: subCats.length,
                                itemBuilder: (_, index) {
                                  final cat = subCats[index];
                                  return CategoryCard(categoryModel: cat);
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                ],
              )
            ],
          ),


          Selector<CategoryProvider, bool>(
            selector: (_, prov) => prov.filteredSubCats.isNotEmpty,
            builder: (_ , isSearching, child){
              if(isSearching) {
                return  SizedBox.expand(
                  child: Container(
                    color: Colors.grey.withAlpha(40),
                  ),
                );
              }
              return const SizedBox();
            },
          ),

          Selector<CategoryProvider, List<CategoryModel>>(
            selector: (_ , prov) => prov.filteredSubCats,
            builder: (_ , cats, child){
              return Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: Align(
                  alignment: const Alignment(1, -1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: cats.length * 40 > 240 ? 240 : cats.length * 40,
                    // height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white
                    ),
                    child: ListView.separated(
                        itemCount: cats.length,
                        itemBuilder: (_, index){
                          return Container(
                            width: double.infinity,
                            height: 39,
                            alignment: const Alignment(-0.9, 0),
                            child: Text(L10n.getLocalizedCategory(context, cats[index].name)),
                          );
                        },
                        separatorBuilder: (_ , index) => const Divider(height: 0),

                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}