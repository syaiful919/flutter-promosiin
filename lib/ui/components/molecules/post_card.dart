import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final Function(PostModel post) detailAction;
  final Function(PostModel post) saveAction;

  const PostCard({
    Key key,
    this.post,
    this.detailAction,
    this.saveAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(post.title),
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () => detailAction(post),
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      post.imagePath,
                    ),
                  ),
                ),
                Positioned(
                  bottom: Gap.m,
                  right: Gap.m,
                  child: GestureDetector(
                    onTap: () => saveAction(post),
                    child: Icon(Icons.favorite),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
