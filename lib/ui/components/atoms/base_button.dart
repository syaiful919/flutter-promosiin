import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool outlineType;
  final bool isLoading;
  final bool disabled;

  const BaseButton({
    Key key,
    this.title,
    this.onPressed,
    this.outlineType = false,
    this.isLoading = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: Gap.s),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusSize.s),
          side: outlineType
              ? BorderSide(color: ProjectColor.main)
              : BorderSide.none,
        ),
        color: outlineType ? ProjectColor.white1 : ProjectColor.main,
        disabledColor: ProjectColor.grey1,
        minWidth: MediaQuery.of(context).size.width,
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ProjectColor.white1),
                ),
              )
            : Text(
                title,
                style: outlineType
                    ? TypoStyle.titleWhite.copyWith(color: ProjectColor.main)
                    : TypoStyle.titleWhite,
              ),
        onPressed: (onPressed == null)
            ? null
            : () {
                if (!isLoading && !disabled) onPressed();
              },
      ),
    );
  }
}
