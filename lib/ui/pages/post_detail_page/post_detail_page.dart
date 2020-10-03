import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/molecules/detail_appbar.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/post_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PostDetailPage extends StatelessWidget {
  final PostModel post;

  const PostDetailPage({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context, post: post),
      viewModelBuilder: () => PostDetailViewModel(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          appBar: DetailAppBar(
            title: "Post Detail",
            backAction: () => model.goBack(),
          ),
          body: (model.post == null)
              ? Container()
              : ListView(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Image.network(model.post.imagePath),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Gap.m),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            model.post.title,
                            style: TypoStyle.title,
                          ),
                          SizedBox(height: Gap.m),
                          Text(model.post.description),
                          SizedBox(height: Gap.m),
                          if (model.showLink)
                            Text("Links", style: TypoStyle.title),
                          if (model.showLink)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: model.post.externalLink.length,
                              itemBuilder: (_, index) => LinkListItem(
                                link: model.post.externalLink[index],
                                launchUrl: (url) => model.launchUrl(url),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class LinkListItem extends StatelessWidget {
  final ExternalLink link;
  final Function(String url) launchUrl;

  const LinkListItem({
    Key key,
    this.link,
    this.launchUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => launchUrl(link.url), child: Text(link.title));
  }
}
