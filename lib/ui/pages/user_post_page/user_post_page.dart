import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/atoms/loading.dart';
import 'package:base_project/ui/components/atoms/up_button.dart';
import 'package:base_project/ui/components/molecules/detail_appbar.dart';
import 'package:base_project/ui/components/molecules/empty_content.dart';
import 'package:base_project/ui/components/molecules/no_internet_content.dart';
import 'package:base_project/ui/components/molecules/post_card.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/user_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';

class UserPostPage extends HookWidget {
  final String userId;
  final UserModel user;
  const UserPostPage({
    Key key,
    @required this.userId,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainScroll = useScrollController();
    var showUpButton = useState(false);

    void updateButtonState() {
      if (mainScroll.offset >= 400) {
        showUpButton.value = true;
      } else {
        showUpButton.value = false;
      }
    }

    useEffect(() {
      mainScroll.addListener(() => updateButtonState());
      return () => mainScroll.removeListener(() => updateButtonState());
    }, [mainScroll]);
    return ViewModelBuilder<UserPostViewModel>.reactive(
      onModelReady: (model) =>
          model.firstLoad(context: context, id: userId, usr: user),
      viewModelBuilder: () => UserPostViewModel(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          appBar: DetailAppBar(
            title: model.appBarTitle,
            backAction: () => model.goBack(),
          ),
          body: (model.isNetworkError)
              ? NoInternetContent(
                  ctaAction: () =>
                      model.firstLoad(context: context, id: userId, usr: user),
                )
              : (model.posts == null)
                  ? Loading()
                  : (model.posts.length > 0)
                      ? Stack(
                          children: <Widget>[
                            RefreshIndicator(
                              onRefresh: () => model.firstLoad(
                                  context: context, id: userId, usr: user),
                              child: ListView(
                                controller: mainScroll,
                                children: <Widget>[
                                  SizedBox(height: Gap.m),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) => PostCard(
                                      post: model.posts[index],
                                      saveAction: (val) {
                                        print(">>> save");
                                      },
                                      detailAction: (val) =>
                                          model.goToPostDetailPage(val),
                                    ),
                                    itemCount: model.posts.length,
                                  ),
                                ],
                              ),
                            ),
                            if (showUpButton.value)
                              Positioned(
                                bottom: Gap.l,
                                right: Gap.m,
                                child: UpButton(
                                  onTap: () {
                                    mainScroll.animateTo(
                                      0,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                ),
                              )
                          ],
                        )
                      : EmptyContent(),
        ),
      ),
    );
  }
}
