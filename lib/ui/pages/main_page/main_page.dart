import 'package:animations/animations.dart';
import 'package:base_project/locator/locator.dart';
import 'package:base_project/ui/pages/home_page/home_page.dart';
import 'package:base_project/ui/pages/my_account_page/my_account_page.dart';
import 'package:base_project/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
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
              body: PageTransitionSwitcher(
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
              bottomNavigationBar: BottomNavigationBar(
                onTap: model.setPageIndex,
                currentIndex: model.currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Home"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    title: Text("New"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    title: Text("My Account"),
                  ),
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
      return HomePage();
    case 2:
      return MyAccountPage();

    default:
      return HomePage();
  }
}
