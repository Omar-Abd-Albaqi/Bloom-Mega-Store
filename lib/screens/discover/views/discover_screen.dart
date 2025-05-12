import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../screens/search/views/components/search_form.dart';

import '../../../models/category_model.dart';
import '../../../providers/home_page_provider/category_provider.dart';
import 'components/expansion_category.dart';

class DiscoverScreen extends StatelessWidget {
   DiscoverScreen({super.key});

  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = context.read<CategoryProvider>().categories;
    final List<List<CategoryModel>> subCategories = context.read<CategoryProvider>().subCategories;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Stack(
                  children: [
                    Visibility(
                      visible: !focusNode.hasFocus,
                      child: Align(
                        alignment: const Alignment(-1, 0),
                        child: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.arrow_back_ios_new)),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1, 0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                          width: !focusNode.hasFocus ? MediaQuery.of(context).size.width - 100 :MediaQuery.of(context).size.width ,
                          child: SearchForm(focusNode: focusNode,onTabFilter: focusNode.unfocus,)),
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: !focusNode.hasFocus,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding / 2),
                  child: Text(
                    "Categories",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              // While loading use 👇
              // const Expanded(
              //   child: DiscoverCategoriesSkelton(),
              // ),

              Visibility(
                visible: !focusNode.hasFocus,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) => ExpansionCategory(
                      svgSrc: "",
                      title: categories[index].name,
                      subCategory: subCategories[index],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
