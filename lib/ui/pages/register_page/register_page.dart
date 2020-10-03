import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/ui/components/atoms/base_input.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/atoms/transparent_back_button.dart';
import 'package:base_project/ui/components/molecules/detail_appbar.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController;
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => RegisterViewModel(),
      builder: (_, model, __) => Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: Gap.m),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 100),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: Gap.xs),
                        child: Text(
                          "Daftar dan\npromosiin usahamu",
                          style: TypoStyle.head600,
                        ),
                      ),
                    ),
                    SizedBox(height: Gap.xl),
                    BaseInput(
                      controller: usernameController,
                      onChanged: (val) => model.changeUsername(val),
                      placeHolder: "Username",
                    ),
                    SizedBox(height: Gap.m),
                    BaseInput(
                      controller: emailController,
                      onChanged: (val) => model.changeEmail(val),
                      placeHolder: "Email",
                    ),
                    SizedBox(height: Gap.m),
                    BaseInput(
                      controller: passwordController,
                      onChanged: (val) => model.changePassword(val),
                      placeHolder: "Password",
                      passwordType: true,
                    ),
                    SizedBox(height: Gap.xl),
                    BaseButton(
                      title: "Register",
                      isLoading: model.tryingToRegister,
                      disabled: (model.username.isEmpty ||
                          model.password.isEmpty ||
                          model.email.isEmpty),
                      onPressed: () => model.registerValidation(),
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Sudah punya akun? ",
                          style: TypoStyle.caption,
                        ),
                        GestureDetector(
                          onTap: () => model.goToLoginPage(),
                          child: Text(
                            "Login",
                            style: TypoStyle.paragraphMain600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: MediaQuery.of(context).padding.top,
              child: TransparentBackButton(
                onTap: () => model.goBack(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
