import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class BaseInput extends StatefulWidget {
  final TextEditingController controller;
  final String errorMessage;
  final String placeHolder;
  final bool showError;
  final bool autoFocus;
  final bool disabled;
  final bool passwordType;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  const BaseInput({
    Key key,
    this.errorMessage,
    this.placeHolder = "",
    this.showError = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
    @required this.controller,
    this.autoFocus = false,
    this.disabled = false,
    this.passwordType = false,
  }) : super(key: key);

  @override
  _BaseInputState createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  bool hideText;

  @override
  void initState() {
    super.initState();
    hideText = widget.passwordType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          autofocus: widget.autoFocus,
          enabled: !widget.disabled,
          obscureText: hideText,
          onChanged: (val) => widget.onChanged(val),
          onSubmitted: (val) => widget.onSubmitted(val),
          decoration: InputDecoration(
            suffixIcon: widget.passwordType
                ? GestureDetector(
                    onTap: () {
                      hideText = !hideText;
                      setState(() {});
                    },
                    child: Icon(
                      !hideText ? Icons.remove_red_eye : Icons.visibility_off,
                      color: ProjectColor.main,
                      size: IconSize.m,
                    ),
                  )
                : null,
            contentPadding:
                const EdgeInsets.fromLTRB(Gap.m, Gap.s, Gap.m, Gap.s),
            hintText: widget.placeHolder,
            hintStyle: TypoStyle.paragraphGrey,
            counterText: "",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusSize.m),
              borderSide: BorderSide(
                width: 1,
                color: widget.showError ? ProjectColor.red2 : ProjectColor.main,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusSize.m),
              borderSide: BorderSide(
                width: 1.5,
                color: widget.showError ? ProjectColor.red2 : ProjectColor.main,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusSize.m),
              borderSide: BorderSide(color: ProjectColor.grey2),
            ),
          ),
        ),
        if (widget.showError) SizedBox(height: Gap.s),
        if (widget.showError) ErrorValidator(message: widget.errorMessage)
      ],
    );
  }
}

class ErrorValidator extends StatelessWidget {
  final String message;

  const ErrorValidator({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Gap.s),
      decoration: ShapeDecoration(
        color: ProjectColor.white1,
        shape: _ErrorValidator(arrowArc: 0.5),
        shadows: [
          BoxShadow(
            color: ProjectColor.grey2,
            blurRadius: RadiusSize.s,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: Gap.xs),
            child: Icon(
              Icons.info,
              color: ProjectColor.red2,
              size: IconSize.s,
            ),
          ),
          Flexible(
            child: Text(
              message,
              style: TypoStyle.caption,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorValidator extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double arrowArc;
  final double radius;

  _ErrorValidator({
    this.radius = 4.0,
    this.arrowWidth = 20.0,
    this.arrowHeight = 10.0,
    this.arrowArc = 0.0,
  }) : assert(arrowArc <= 1.0 && arrowArc >= 0.0);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    rect = Rect.fromPoints(
        rect.topLeft, rect.bottomRight - Offset(0, arrowHeight));
    double x = arrowWidth, y = arrowHeight, r = 1 - arrowArc;

    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.topLeft.dx + x, rect.topCenter.dy)
      ..relativeLineTo(x / 2 * r, -y * r)
      ..relativeQuadraticBezierTo(x / 2 * (1 - r), -y * (1 - r), x * (1 - r), 0)
      ..relativeLineTo(x / 2 * r, y * r);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
