import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/molecules/no_internet_content.dart';

import 'package:base_project/viewmodel/no_internet_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NoInternetPage extends StatelessWidget {
  final routeName;
  final argument;

  const NoInternetPage(this.routeName, {this.argument});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoInternetViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(
        context: context,
        routeName: routeName,
        argument: argument,
      ),
      viewModelBuilder: () => NoInternetViewModel(),
      builder: (_, model, __) => WillPopScope(
        onWillPop: () async {
          model.goBack();
          return true;
        },
        child: BaseStatusBar(
          child: Scaffold(
            body: NoInternetContent(ctaAction: () => model.goBack()),
          ),
        ),
      ),
    );
  }
}
