import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/atoms/transparent_back_button.dart';
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
          body: (model.post == null)
              ? Container()
              : Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            child: Image.network(
                              model.post.imagePath,
                              fit: BoxFit.cover,
                            ),
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
                                style: TypoStyle.title500,
                              ),
                              SizedBox(height: Gap.m),
                              Text(model.post.description),
                              SizedBox(height: Gap.m),
                              if (model.showLink)
                                Text("Links", style: TypoStyle.title500),
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: TransparentBackButton(
                        onTap: () => model.goBack(),
                      ),
                    )
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
      onTap: () => launchUrl(link.url),
      child: Text(
        link.title,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
