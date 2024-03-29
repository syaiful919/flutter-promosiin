import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/ui/components/atoms/base_input.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/atoms/loading.dart';
import 'package:base_project/ui/components/molecules/detail_appbar.dart';
import 'package:base_project/ui/pages/create_post_page/components/image_picker_sheet.dart';
import 'package:base_project/ui/pages/create_post_page/components/link_list_item.dart';
import 'package:base_project/utils/project_images.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/create_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';

class CreatePostPage extends HookWidget {
  final PostModel post;

  CreatePostPage({this.post});

  @override
  Widget build(BuildContext context) {
    var titleController = useTextEditingController(text: post?.title ?? "");
    var descriptionController =
        useTextEditingController(text: post?.description ?? "");
    var locationController =
        useTextEditingController(text: post?.location ?? "");

    return ViewModelBuilder<CreatePostViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context, post: post),
      viewModelBuilder: () => CreatePostViewModel(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          appBar: DetailAppBar(
            title: model.editType ? "Edit Postingan" : "Postingan Baru",
            backAction: () => model.goBack(),
            actions: (model.editType)
                ? <Widget>[
                    IconButton(
                      onPressed: () => model.showDeleteDialog(),
                      icon: Icon(
                        Icons.delete,
                        color: ProjectColor.white1,
                      ),
                    )
                  ]
                : null,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Gap.m),
            child: ListView(
              children: <Widget>[
                SizedBox(height: Gap.m),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(RadiusSize.m),
                          topRight: Radius.circular(RadiusSize.m),
                        ),
                      ),
                      backgroundColor: ProjectColor.white1,
                      useRootNavigator: false,
                      context: context,
                      builder: (context) => ImagePickerSheet(
                        openCamera: () => model.openCamera(),
                        openGallery: () => model.openGallery(),
                      ),
                    );
                  },
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(RadiusSize.m),
                        border: Border.all(
                          color: ProjectColor.main,
                        ),
                      ),
                      // alignment: Alignment.center,
                      child: (model.networkImagePath != null)
                          ? Image.network(model.networkImagePath,
                              fit: BoxFit.cover)
                          : (model.image == null)
                              ? Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(height: Gap.xl),
                                      Image.asset(ProjectImages.images),
                                      SizedBox(height: Gap.xl),
                                      Text("Pilih gambar"),
                                    ],
                                  ),
                                )
                              : Image.file(
                                  model.image,
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                ),
                SizedBox(height: Gap.m),
                Text(
                  "Judul",
                  style: TypoStyle.paragraph500,
                ),
                BaseInput(
                  controller: titleController,
                  placeHolder: "Judul",
                  onChanged: (val) => model.changeTitle(val),
                ),
                SizedBox(height: Gap.m),
                Text(
                  "Deskripsi",
                  style: TypoStyle.paragraph500,
                ),
                BaseInput(
                  controller: descriptionController,
                  placeHolder: "Deskripsi",
                  onChanged: (val) => model.changeDescription(val),
                  minLines: 2,
                  maxLines: 5,
                ),
                SizedBox(height: Gap.m),
                Text(
                  "Lokasi",
                  style: TypoStyle.paragraph500,
                ),
                BaseInput(
                  controller: locationController,
                  placeHolder: "Lokasi",
                  onChanged: (val) => model.changeLocation(val),
                ),
                SizedBox(height: Gap.m),
                Row(
                  children: <Widget>[
                    Text(
                      "Kategori",
                      style: TypoStyle.paragraph500,
                    ),
                    SizedBox(width: Gap.s),
                    model.categories == null
                        ? Loading()
                        : GestureDetector(
                            onTap: () => model.showCategoriesDialog(),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Gap.s, vertical: Gap.xs),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(RadiusSize.s),
                                  border: Border.all(color: ProjectColor.main)),
                              child: Text(
                                  model.category?.name ?? "Pilih kategori"),
                            ),
                          )
                  ],
                ),
                SizedBox(height: Gap.m),
                Row(
                  children: <Widget>[
                    Text(
                      "Link",
                      style: TypoStyle.paragraph500,
                    ),
                    SizedBox(width: Gap.s),
                    GestureDetector(
                      onTap: () => model.showLinkDialog(),
                      child: Container(
                        padding: EdgeInsets.all(Gap.xxs),
                        decoration: BoxDecoration(
                            border: Border.all(color: ProjectColor.main),
                            borderRadius: BorderRadius.circular(RadiusSize.s)),
                        child: Icon(
                          Icons.add,
                          color: ProjectColor.main,
                        ),
                      ),
                    )
                  ],
                ),
                if (model.links != null && model.links.length > 0)
                  SizedBox(height: Gap.s),
                if (model.links != null && model.links.length > 0)
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
                  onPressed:
                      model.isDataValid() ? () => model.createPost() : null,
                  title: model.editType
                      ? "Perbarui Postingan"
                      : "Tambah Postingan",
                  isLoading: model.tryingToPost,
                ),
                SizedBox(height: Gap.m),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
