import 'package:base_project/ui/components/atoms/loading.dart';
import 'package:base_project/ui/components/atoms/section_row.dart';
import 'package:base_project/ui/components/molecules/post_card.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewPostsSection extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(context, model) {
    return SliverToBoxAdapter(
      child: (model.newPost == null)
          ? Loading()
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: Gap.s),
                SectionRow(title: "Postingan Baru", showSubtitle: false),
                SizedBox(height: Gap.m),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  key: PageStorageKey("new-key"),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => PostCard(
                    post: model.newPost[index],
                    saveAction: (val) {
                      print(">>> save");
                    },
                    detailAction: (val) => model.goToPostDetailPage(val),
                    userAction: (id, user) => model.goToUserPostPage(id, user),
                  ),
                  itemCount: model.newPost.length,
                ),
              ],
            ),
    );
  }
}
