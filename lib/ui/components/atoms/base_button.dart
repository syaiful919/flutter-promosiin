import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const BaseButton({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(Gap.s),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusSize.s),
      ),
      color: ProjectColor.main,
      disabledColor: ProjectColor.grey1,
      minWidth: MediaQuery.of(context).size.width,
      child: Text(
        title,
        style: TypoStyle.mainButton,
      ),
      onPressed: (onPressed == null) ? null : () => onPressed(),
    );
  }
}
