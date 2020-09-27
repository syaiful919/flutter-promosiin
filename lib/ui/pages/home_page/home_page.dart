import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/atoms/shimmer_placeholder.dart';
import 'package:base_project/ui/components/molecules/post_card.dart';
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
            body: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: Gap.m),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: Gap.m),
                    Text(
                      "Promosiin",
                      style: TypoStyle.sectionLabel.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: Gap.m),
                    if (model.newPost != null)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) => PostCard(
                          post: model.newPost[index],
                          saveAction: (val) {
                            print(">>> save");
                          },
                          detailAction: (val) {
                            print(">>> detail");
                          },
                        ),
                        itemCount: model.newPost.length,
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
