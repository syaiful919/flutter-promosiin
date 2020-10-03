import 'package:base_project/locator/locator.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/pages/home_page/sections/categories_section.dart';
import 'package:base_project/ui/pages/home_page/sections/header_section.dart';
import 'package:base_project/ui/pages/home_page/sections/new_posts_section.dart';
import 'package:base_project/ui/pages/home_page/sections/promotion_section.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<HomeViewModel>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        fireOnModelReadyOnce: true,
        onModelReady: (model) => model.firstLoad(context: context),
        viewModelBuilder: () => locator<HomeViewModel>(),
        builder: (_, model, __) => BaseStatusBar(
          child: Scaffold(
            backgroundColor: ProjectColor.white2,
            body: CustomScrollView(
              key: PageStorageKey("home-key"),
              slivers: <Widget>[
                Header(),
                PromotionsSection(),
                CategoriesSection(),
                NewPostsSection(),
                SliverPadding(padding: EdgeInsets.only(top: Gap.xxl))
              ],
            ),
          ),
        ),
      );
}
