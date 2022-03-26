import 'package:base_project/dictionary/no_internet_dict.dart';
import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/utils/project_images.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class NoInternetContent extends StatelessWidget {
  final VoidCallback ctaAction;

  const NoInternetContent({
    Key key,
    this.ctaAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            ProjectImages.noInternet,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          SizedBox(height: Gap.m),
          Text(
            NoInternetDict.checkConnection,
            style: TypoStyle.title,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Gap.l),
          SizedBox(
            width: 150,
            child: BaseButton(
              title: NoInternetDict.tryAgain,
              onPressed: () => ctaAction(),
            ),
          )
        ],
      ),
    );
  }
}
