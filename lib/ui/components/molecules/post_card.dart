import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/utils/project_images.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:base_project/extension/extended_string.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final Function(PostModel post) detailAction;
  final Function(PostModel post) saveAction;
  final Function(String id, UserModel user) userAction;

  const PostCard({
    Key key,
    this.post,
    this.detailAction,
    this.saveAction,
    this.userAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(Gap.m, Gap.zero, Gap.m, Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () => userAction(post.userId, post.user),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: post.user.profilePicture == null
                          ? AssetImage(ProjectImages.avatar)
                          : NetworkImage(post.user.profilePicture),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: EdgeInsets.only(right: Gap.s),
                  width: 36,
                  height: 36,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => userAction(post.userId, post.user),
                    child: Text(
                      post.user.username.capitalize(),
                      style: TypoStyle.caption500,
                    ),
                  ),
                  Text(
                    post.location.capitalize(),
                    style: TypoStyle.captionGrey,
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: Gap.m),
          Text(
            post.title,
            style: TypoStyle.caption500,
          ),
          SizedBox(height: Gap.s),
          ClipRRect(
            borderRadius: BorderRadius.circular(Gap.l),
            child: AspectRatio(
              aspectRatio: 1,
              child: GestureDetector(
                onTap: () => detailAction(post),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    post.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
