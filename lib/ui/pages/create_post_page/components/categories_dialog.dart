import 'package:base_project/model/entity/category_model.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class CategoriesDialog extends StatelessWidget {
  final List<CategoryModel> list;
  final String selectedId;
  final Function(CategoryModel) selectAction;

  const CategoriesDialog({
    Key key,
    this.list,
    this.selectAction,
    this.selectedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusSize.m),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusSize.m),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(RadiusSize.m),
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => CategoryListItem(
              name: list[index].name,
              isSelected: list[index].categoryId == selectedId,
              selectAction: () {
                Navigator.of(context).pop();
                selectAction(list[index]);
              },
              isFirst: index == 0,
            ),
            itemCount: list.length,
          ),
        ),
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final bool isSelected;
  final String name;
  final VoidCallback selectAction;
  final bool isFirst;

  const CategoryListItem({
    Key key,
    this.isSelected,
    this.name,
    this.selectAction,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectAction(),
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: Gap.s + Gap.xs, horizontal: Gap.m),
        decoration: BoxDecoration(
          color: isSelected
              ? ProjectColor.main.withOpacity(0.75)
              : ProjectColor.white1,
        ),
        child: Text(
          name,
          style: isSelected ? TypoStyle.paragraph600 : TypoStyle.paragraph,
        ),
      ),
    );
  }
}
