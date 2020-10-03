import 'package:base_project/model/entity/category_model.dart';
import 'package:base_project/model/entity/promotion_model.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/molecules/detail_appbar.dart';
import 'package:base_project/ui/components/molecules/post_card.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/category_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CategoryPage extends StatelessWidget {
  final CategoryModel category;
  final PromotionModel promotion;

  const CategoryPage({
    Key key,
    this.category,
    this.promotion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(
        context: context,
        cat: category,
        promo: promotion,
      ),
      viewModelBuilder: () => CategoryViewModel(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          appBar: DetailAppBar(
            title: "Stream Sample Page",
            backAction: () => model.goBack(),
          ),
          body: (model.posts != null && model.posts.length > 0)
              ? ListView.builder(
                  shrinkWrap: true,
                  key: PageStorageKey("new-key"),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => PostCard(
                    post: model.posts[index],
                    saveAction: (val) {
                      print(">>> save");
                    },
                    detailAction: (val) => model.goToPostDetailPage(val),
                  ),
                  itemCount: model.posts.length,
                )
              : Container(),
        ),
      ),
    );
  }
}
