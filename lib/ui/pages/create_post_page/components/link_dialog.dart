import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/ui/components/atoms/base_input.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class LinkDialog extends StatefulWidget {
  final Function(ExternalLink) saveLink;

  // for edit link
  final ExternalLink link;
  final int index;
  final Function(ExternalLink, int) editLink;

  const LinkDialog({
    Key key,
    this.link,
    this.saveLink,
    this.editLink,
    this.index,
  }) : super(key: key);

  @override
  _LinkDialogState createState() => _LinkDialogState();
}

class _LinkDialogState extends State<LinkDialog> {
  TextEditingController titleController;
  TextEditingController urlController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.link?.title ?? "");
    urlController = TextEditingController(text: widget.link?.url ?? "");
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusSize.m),
      ),
      child: Container(
        padding: EdgeInsets.all(Gap.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              (widget.link == null) ? "Tambah Link" : "Edit Link",
              style: TypoStyle.head600,
            ),
            SizedBox(height: Gap.m),
            BaseInput(
              controller: titleController,
              placeHolder: "Nama situs",
              onChanged: (_) {
                setState(() {});
              },
            ),
            SizedBox(height: Gap.s),
            BaseInput(
              controller: urlController,
              placeHolder: "link url",
              onChanged: (_) {
                setState(() {});
              },
            ),
            SizedBox(height: Gap.m),
            BaseButton(
              title: (widget.link == null) ? "Tambah" : "Edit",
              onPressed: (titleController.text.isNotEmpty &&
                      urlController.text.isNotEmpty)
                  ? () {
                      Navigator.of(context).pop();

                      if (widget.link == null) {
                        widget.saveLink(
                          ExternalLink(
                            title: titleController.text,
                            url: urlController.text,
                          ),
                        );
                      } else {
                        widget.editLink(
                          ExternalLink(
                            title: titleController.text,
                            url: urlController.text,
                          ),
                          widget.index,
                        );
                      }
                    }
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
