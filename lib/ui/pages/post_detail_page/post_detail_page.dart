import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/molecules/detail_appbar.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/post_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PostDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => PostDetailViewModel(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          appBar: DetailAppBar(
            title: "Post Detail Page",
            backAction: () => model.goBack(),
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: Text(
                    "This page contains stream data. if you lost your internet connection, it will redirect to no internet page",
                    style: TypoStyle.paragraph,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
