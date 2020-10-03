import 'package:animations/animations.dart';
import 'package:base_project/locator/locator.dart';
import 'package:base_project/ui/pages/home_page/home_page.dart';
import 'package:base_project/ui/pages/my_account_page/my_account_page.dart';
import 'package:base_project/utils/project_icons.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class MainPage extends StatelessWidget {
  final int initialIndex;

  const MainPage({
    Key key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<MainViewModel>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        fireOnModelReadyOnce: true,
        viewModelBuilder: () => locator<MainViewModel>(),
        onModelReady: (model) => model.firstLoad(),
        builder: (_, model, __) => Stack(
          children: <Widget>[
            Scaffold(
              body: Stack(
                children: <Widget>[
                  PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 200),
                    reverse: model.reverse,
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return SharedAxisTransition(
                        child: child,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                      );
                    },
                    child: getViewForIndex(model.currentIndex),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipPath(
                      clipper: BottomNavBarClipper(),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: ProjectColor.white1,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(RadiusSize.xxl),
                            topLeft: Radius.circular(RadiusSize.xxl),
                          ),
                        ),
                        child: BottomNavigationBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          onTap: model.setPageIndex,
                          currentIndex: model.currentIndex,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          items: [
                            BottomNavigationBarItem(
                              icon: SvgPicture.asset(
                                ProjectIcons.homeDisabled,
                                color: ProjectColor.grey1,
                                width: IconSize.m,
                              ),
                              activeIcon: SvgPicture.asset(
                                ProjectIcons.home,
                                color: ProjectColor.main,
                                width: IconSize.m,
                              ),
                              title: Text("Home"),
                            ),
                            BottomNavigationBarItem(
                              icon: SvgPicture.asset(
                                ProjectIcons.userDisabled,
                                color: ProjectColor.grey1,
                                width: IconSize.m,
                              ),
                              activeIcon: SvgPicture.asset(
                                ProjectIcons.user,
                                color: ProjectColor.main,
                                width: IconSize.m,
                              ),
                              title: Text("My Account"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 46,
                      width: 46,
                      margin: EdgeInsets.only(bottom: 42),
                      child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: ProjectColor.main,
                        child: SizedBox(
                          height: 26,
                          width: 26,
                          child: Icon(
                            Icons.add,
                            color: ProjectColor.white1,
                          ),
                        ),
                        onPressed: () => model.goToCreatePostPage(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (model.isFirstInstall) Container()
          ],
        ),
      );
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return HomePage();
    case 1:
      return MyAccountPage();
    case 2:
      return MyAccountPage();

    default:
      return HomePage();
  }
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo((size.width / 2) - 28, 0);
    path.quadraticBezierTo((size.width / 2) - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo((size.width / 2) + 28, 33, (size.width / 2) + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
