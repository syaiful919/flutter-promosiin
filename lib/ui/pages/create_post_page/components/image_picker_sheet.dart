import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class ImagePickerSheet extends StatelessWidget {
  final VoidCallback openGallery;
  final VoidCallback openCamera;

  const ImagePickerSheet({
    Key key,
    @required this.openGallery,
    @required this.openCamera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              openGallery();
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: Gap.s, top: Gap.m),
              child: Text(
                "Pilih dari galeri",
                style: TypoStyle.paragraph500,
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                openCamera();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: Gap.s, bottom: Gap.m),
                child: Text(
                  "Buka kamera",
                  style: TypoStyle.paragraph500,
                ),
              )),
        ],
      ),
    );
  }
}
