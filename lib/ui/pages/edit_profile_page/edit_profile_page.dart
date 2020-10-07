import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/ui/components/atoms/base_input.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/atoms/transparent_icon_button.dart';
import 'package:base_project/ui/pages/create_post_page/components/image_picker_sheet.dart';
import 'package:base_project/utils/project_images.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/edit_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';

class EditProfilePage extends HookWidget {
  final UserModel user;
  final String userId;

  const EditProfilePage({
    Key key,
    @required this.user,
    @required this.userId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(">>> username ${user.username}");

    var emailController = useTextEditingController(text: user.email);
    var usernameController = useTextEditingController(text: user.username);

    return ViewModelBuilder<EditProfileViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(
        context: context,
        user: user,
        userId: userId,
      ),
      viewModelBuilder: () => EditProfileViewModel(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: Gap.m),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 100),
                    Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Stack(
                        children: <Widget>[
                          ClipOval(
                            child: (model.imageToUpload != null)
                                ? Image.file(
                                    model.imageToUpload,
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  )
                                : (model.currentUser?.profilePicture == null)
                                    ? Image.asset(ProjectImages.avatar)
                                    : Image.network(
                                        model.currentUser.profilePicture,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
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
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ProjectColor.accent,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(Gap.xs),
                                child: Icon(
                                  Icons.edit,
                                  size: IconSize.s,
                                  color: ProjectColor.white1,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: Gap.l),
                    BaseInput(
                      controller: emailController,
                      onChanged: (val) {},
                      placeHolder: "Email",
                      disabled: true,
                    ),
                    SizedBox(height: Gap.m),
                    BaseInput(
                      controller: usernameController,
                      onChanged: (val) => model.changeUsername(val),
                      placeHolder: "Username",
                    ),
                    SizedBox(height: Gap.xl),
                    BaseButton(
                      title: "Edit Profile",
                      isLoading: model.tryingToEdit,
                      disabled:
                          (model.username != null && model.username.isEmpty),
                      onPressed:
                          (model.username != null && model.username.isEmpty)
                              ? null
                              : () => model.editAction(),
                    ),
                    Container(
                      height: 100,
                      padding: EdgeInsets.only(top: Gap.s),
                      child: (model.errorMessage == null)
                          ? null
                          : Text(
                              model.errorMessage,
                            ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: TransparentIconButton(
                  onTap: () => model.goBack(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
