import 'package:base_project/locator/locator.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/utils/project_icons.dart';
import 'package:base_project/utils/project_images.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/my_account_viewmodel.dart';
import 'package:base_project/extension/extended_string.dart';
import 'package:flushbar/flushbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAccountViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => locator<MyAccountViewModel>(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: Gap.m),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 100),
                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: ClipOval(
                      child: (model.user?.profilePicture == null)
                          ? Image.asset(ProjectImages.avatar)
                          : Image.network(model.user.profilePicture)),
                ),
                SizedBox(height: Gap.s),
                if (model.user != null)
                  Text(
                    model.user.username.capitalize(),
                    style: TypoStyle.head600,
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: Gap.l),
                ListItem(
                  title: "Edit Profile",
                  iconPath: ProjectIcons.edit,
                  onTap: () {
                    Flushbar(
                      duration: Duration(milliseconds: 3000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: ProjectColor.red3,
                      message: "Sorry, this feature isn't available right now",
                    )..show(context);
                  },
                ),
                ListItem(
                  title: "My Post",
                  iconPath: ProjectIcons.post,
                  onTap: () => model.goToUserPostPage(),
                ),
                ListItem(
                  title: "Rate promosiin on Playstore",
                  iconPath: ProjectIcons.rate,
                  onTap: () {
                    Flushbar(
                      duration: Duration(milliseconds: 3000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: ProjectColor.red3,
                      message:
                          "Sorry, Promosiin App isn't available at playstore right now",
                    )..show(context);
                  },
                ),
                ListItem(
                  title: "Log out",
                  iconPath: ProjectIcons.logout,
                  onTap: () => model.showLogoutDialog(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String title;

  const ListItem({
    Key key,
    this.onTap,
    this.iconPath,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Gap.s),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  iconPath,
                  width: IconSize.m,
                  color: ProjectColor.main,
                ),
                SizedBox(width: Gap.m),
                Text(
                  title,
                  style: TypoStyle.paragraph500,
                ),
              ],
            ),
            SizedBox(height: Gap.m),
            DashDivider(width: MediaQuery.of(context).size.width - 2 * Gap.m),
          ],
        ),
      ),
    );
  }
}

class DashDivider extends StatelessWidget {
  final double width;

  const DashDivider({Key key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int n = width ~/ 5;
    return Row(
      children: List.generate(
          n,
          (index) => (index % 2 == 0)
              ? Container(
                  height: 2,
                  width: width / n,
                  color: ProjectColor.grey2,
                )
              : SizedBox(
                  width: width / n,
                )),
    );
  }
}
