import 'package:base_project/locator/locator.dart';
import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/my_account_viewmodel.dart';
import 'package:flutter/material.dart';
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                    width: 300,
                    child: BaseButton(
                      onPressed: () => model.logOut(),
                      title: "Log out",
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
