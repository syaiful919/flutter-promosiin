import 'package:base_project/ui/components/atoms/section_row.dart';
import 'package:base_project/ui/components/molecules/post_card.dart';
import 'package:base_project/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewPostsSection extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(context, model) {
    return SliverToBoxAdapter(
      child: (model.newPost == null)
          ? Container()
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SectionRow(title: "Postingan Baru", showSubtitle: false),
                ListView.builder(
                  shrinkWrap: true,
                  key: PageStorageKey("new-key"),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => PostCard(
                    post: model.newPost[index],
                    saveAction: (val) {
                      print(">>> save");
                    },
                    detailAction: (val) => model.goToPostDetailPage(val),
                  ),
                  itemCount: model.newPost.length,
                ),
              ],
            ),
    );
  }
}
