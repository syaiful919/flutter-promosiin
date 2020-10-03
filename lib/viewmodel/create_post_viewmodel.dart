import 'dart:io';
import 'package:base_project/model/entity/category_model.dart';
import 'package:base_project/service/firebase_storage/firebase_storage_service.dart';
import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/repository/post_repository.dart';
import 'package:base_project/service/image_picker/image_picker_service.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/uuid/uuid_service.dart';
import 'package:base_project/ui/components/molecules/dialog.dart';
import 'package:base_project/ui/pages/create_post_page/create_post_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreatePostViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _uuid = locator<UuidService>();
  final _postRepository = locator<PostRepository>();
  final _memberRepository = locator<MemberRepository>();
  final _imagePicker = locator<ImagePickerService>();
  final _firebaseStorage = locator<FirebaseStorageService>();

  BuildContext pageContext;

  String title;
  String description;
  CategoryModel category;
  List<ExternalLink> links = [];
  String userId;
  File image;
  String imagePath;

  List<CategoryModel> categories = [
    CategoryModel(
      categoryId: "c1",
      name: "makanan & minuman",
    ),
    CategoryModel(
      categoryId: "c2",
      name: "elektronik",
    ),
    CategoryModel(
      categoryId: "c3",
      name: "mainan & hobi",
    ),
  ];

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
    getUserId();
  }

  void getUserId() {
    userId = _memberRepository.getUserId();
  }

  void changeTitle(String val) {
    title = val;
    notifyListeners();
  }

  void changeDescription(String val) {
    description = val;
    notifyListeners();
  }

  void showImageDialog() {
    showDialog(
      context: pageContext,
      builder: (context) => ImageDialog(
        openCamera: () => openCamera(),
        openGallery: () => openGallery(),
      ),
      useRootNavigator: false,
    );
  }

  void showCategoriesDialog() {
    showDialog(
      context: pageContext,
      builder: (context) => CategoriesDialog(
        list: categories,
        selectedId: category?.categoryId,
        selectAction: (val) => selectCategories(val),
      ),
      useRootNavigator: false,
    );
  }

  void selectCategories(CategoryModel val) {
    category = val;
    notifyListeners();
  }

  void showLinkDialog({ExternalLink link, int index}) {
    showDialog(
      context: pageContext,
      builder: (context) => LinkDialog(
        index: index,
        link: link,
        saveLink: (val) => addLink(val),
        editLink: (link, index) => editLink(link, index),
      ),
      useRootNavigator: false,
    );
  }

  void editLink(ExternalLink link, int index) {
    links[index] = link;
    notifyListeners();
  }

  void showRemoveDialog(int index) async {
    var action = await Dialogs.yesNoDialog(
      context: pageContext,
      title: "Yakin akan menghapus link ini ?",
    );
    if (action == DialogAction.yes) {
      removeLink(index);
    }
  }

  void removeLink(int index) {
    links.removeAt(index);
    notifyListeners();
  }

  void addLink(ExternalLink val) {
    links.add(val);
    notifyListeners();
  }

  void openCamera() async {
    image = await _imagePicker.getImageFromCamera();
    if (image != null) imagePath = image.path;
    notifyListeners();
  }

  void openGallery() async {
    image = await _imagePicker.getImageFromGallery();
    if (image != null) imagePath = image.path;
    notifyListeners();
  }

  Future<void> createPost() async {
    try {
      imagePath = await _firebaseStorage.uploadFile(image);
      PostModel post = PostModel(
        postId: _uuid.generateId(),
        title: title,
        description: description,
        category: category,
        imagePath: imagePath,
        externalLink: links,
        userId: userId,
        dateCreated: DateTime.now(),
        isRecommended: false,
      );
      _postRepository.createPost(post);
    } catch (e) {
      print(">>> error $e");
    }
  }

  void goBack() => _navigationService.pop();
}
