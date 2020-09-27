import 'package:base_project/model/entity/category_model.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/ui/components/atoms/base_input.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/molecules/detail_appbar.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/create_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController titleController;
  TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => CreatePostViewModel(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          appBar: DetailAppBar(
            title: "Postingan Baru",
            backAction: () => model.goBack(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Gap.m),
            child: ListView(
              children: <Widget>[
                SizedBox(height: Gap.m),
                GestureDetector(
                  onTap: () => model.showImageDialog(),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      width: double.infinity,
                      color: ProjectColor.grey1,
                      alignment: Alignment.center,
                      child: (model.image == null)
                          ? Text("Pilih gambar")
                          : Image.file(model.image),
                    ),
                  ),
                ),
                SizedBox(height: Gap.m),
                Text("Judul"),
                BaseInput(
                  controller: titleController,
                  placeHolder: "Judul",
                  onChanged: (val) => model.changeTitle(val),
                ),
                SizedBox(height: Gap.m),
                Text("Deskripsi"),
                BaseInput(
                  controller: descriptionController,
                  placeHolder: "Deskripsi",
                  onChanged: (val) => model.changeDescription(val),
                  minLines: 2,
                  maxLines: 5,
                ),
                SizedBox(height: Gap.m),
                Text("Kategori"),
                BaseButton(
                  outlineType: true,
                  title: model.category?.name ?? "Pilih kategori",
                  onPressed: () => model.showCategoriesDialog(),
                ),
                SizedBox(height: Gap.m),
                Text("Link"),
                BaseButton(
                  onPressed: () => model.showLinkDialog(),
                  title: "Tambah link",
                ),
                if (model.links.length > 0)
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, index) => LinkListItem(
                      index: index,
                      link: model.links[index],
                      editAction: (link, index) =>
                          model.showLinkDialog(link: link, index: index),
                      removeAction: (val) => model.showRemoveDialog(val),
                    ),
                    itemCount: model.links.length,
                  ),
                SizedBox(height: Gap.m),
                BaseButton(
                  onPressed: () => model.createPost(),
                  title: "Tambah Postingan",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinkListItem extends StatelessWidget {
  final ExternalLink link;
  final int index;
  final Function(ExternalLink, int) editAction;
  final Function(int) removeAction;

  const LinkListItem({
    Key key,
    this.link,
    this.index,
    this.editAction,
    this.removeAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(link.title),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => editAction(link, index),
            child: Icon(Icons.edit),
          ),
          GestureDetector(
            onTap: () => removeAction(index),
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

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
            BaseInput(controller: titleController),
            SizedBox(height: Gap.s),
            BaseInput(controller: urlController),
            SizedBox(height: Gap.m),
            BaseButton(
              title: (widget.link == null) ? "Tambah" : "Edit",
              onPressed: () {
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
              },
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesDialog extends StatelessWidget {
  final List<CategoryModel> list;
  final String selectedId;
  final Function(CategoryModel) selectAction;

  const CategoriesDialog({
    Key key,
    this.list,
    this.selectAction,
    this.selectedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => CategoryListItem(
            name: list[index].name,
            isSelected: list[index].categoryId == selectedId,
            selectAction: () {
              Navigator.of(context).pop();
              selectAction(list[index]);
            },
          ),
          itemCount: list.length,
        ),
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final bool isSelected;
  final String name;
  final VoidCallback selectAction;

  const CategoryListItem({
    Key key,
    this.isSelected,
    this.name,
    this.selectAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectAction(),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? ProjectColor.main : ProjectColor.white1,
        ),
        child: Text(name),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final VoidCallback openGallery;
  final VoidCallback openCamera;

  const ImageDialog({
    Key key,
    this.openGallery,
    this.openCamera,
  }) : super(key: key);
  @override
  Widget build(context) {
    return Dialog(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                openGallery();
              },
              child: Text("Pilih dari galeri"),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  openCamera();
                },
                child: Text("Buka kamera")),
          ],
        ),
      ),
    );
  }
}
