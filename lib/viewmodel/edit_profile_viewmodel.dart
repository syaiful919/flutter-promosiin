import 'dart:async';
import 'dart:io';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/repository/post_repository.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/connectivity/connectivity_status.dart';
import 'package:base_project/service/firebase_storage/firebase_storage_service.dart';
import 'package:base_project/service/image_picker/image_picker_service.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EditProfileViewModel extends StreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _connectivityService = locator<ConnectivityService>();
  final _memberRepository = locator<MemberRepository>();
  final _imagePicker = locator<ImagePickerService>();
  final _firebaseStorage = locator<FirebaseStorageService>();
  final _postRepository = locator<PostRepository>();

  BuildContext pageContext;

  UserModel currentUser;
  String currentUserId;

  String username;
  File imageToUpload;

  bool tryingToEdit = false;
  String errorMessage;

  Future<void> firstLoad({
    BuildContext context,
    UserModel user,
    String userId,
  }) async {
    if (pageContext == null && context != null) pageContext = context;
    currentUser = user;
    currentUserId = userId;
    notifyListeners();
  }

  void changeUsername(String val) {
    username = val;
    removeErrorMessage();
  }

  void removeErrorMessage() {
    if (errorMessage != null) errorMessage = null;
    notifyListeners();
  }

  void openCamera() async {
    try {
      imageToUpload = await _imagePicker.getImageFromCamera();
      notifyListeners();
    } catch (e) {
      print(">>> error $e");
    }
  }

  void openGallery() async {
    try {
      imageToUpload = await _imagePicker.getImageFromGallery();
      notifyListeners();
    } catch (e) {
      print(">>> error $e");
    }
  }

  Future<void> updateUserPosts(UserModel user) async {
    try {
      List<PostModel> posts =
          await _postRepository.getPostByUserId(currentUserId);
      if (posts != null && posts.length > 0) {
        for (int i = 0; i < posts.length; i++) {
          PostModel newPost = posts[i];
          newPost.user = user;
          updatePost(newPost);
        }
      }
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> updatePost(PostModel post) async {
    try {
      _postRepository.createPost(post);
    } catch (e) {
      print(">>> error $e");
    }
  }

  Future<void> editAction() async {
    try {
      tryingToEdit = true;
      notifyListeners();

      String imagePath;
      if (imageToUpload != null)
        imagePath = await _firebaseStorage.uploadFile(imageToUpload);

      UserModel newUser = UserModel(
        email: currentUser.email,
        username: username ?? currentUser.username,
        profilePicture: imagePath ?? currentUser.profilePicture,
      );
      await _memberRepository.editUser(currentUserId, newUser);

      UserModel result =
          await _memberRepository.getUserDataRemote(currentUserId);
      _memberRepository.saveUserData(result);

      await updateUserPosts(result);

      _memberRepository.setDataStream(result);
      _postRepository.setPostAdded(true);
      _navigationService.pushNamedAndRemoveUntil(Routes.mainPage);
    } catch (e) {
      print(">>> error $e");
      errorMessage = "Something error, please try again later";
    } finally {
      tryingToEdit = false;
      notifyListeners();
    }
  }

  void goBack() => _navigationService.pop();

  @override
  Stream get stream => _connectivityService.status;

  @override
  void onData(data) {
    super.onData(data);
    if (data == ConnectivityStatus.Offline) {}
  }
}
