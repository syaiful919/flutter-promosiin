import 'package:base_project/ui/components/atoms/category_item.dart';
import 'package:base_project/ui/components/atoms/section_row.dart';
import 'package:base_project/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CategoriesSection extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(context, model) {
    return SliverToBoxAdapter(
      child: (model.categories == null || model.categories.length == 0)
          ? Container()
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SectionRow(title: "Kategori", showSubtitle: false),
                Container(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.categories.length,
                    itemBuilder: (_, index) => CategoryItem(
                      id: model.categories[index].categoryId,
                      isFirst: index == 0,
                      isLast: index == (model.categories.length - 1),
                      name: model.categories[index].name,
                      onTap: () =>
                          model.goToCategoryPage(cat: model.categories[index]),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
