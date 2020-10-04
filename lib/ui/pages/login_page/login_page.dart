import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/ui/components/atoms/base_input.dart';
import 'package:base_project/ui/components/atoms/transparent_icon_button.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => LoginViewModel(),
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
                          "Masuk dan\npromosiin usahamu",
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
                      controller: passwordController,
                      onChanged: (val) => model.changePassword(val),
                      placeHolder: "Password",
                      passwordType: true,
                    ),
                    SizedBox(height: Gap.xl),
                    BaseButton(
                      title: "Login",
                      isLoading: model.tryingToLogin,
                      disabled:
                          (model.username.isEmpty || model.password.isEmpty),
                      onPressed: () => model.loginAction(),
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
                          "Belum punya akun? ",
                          style: TypoStyle.caption,
                        ),
                        GestureDetector(
                          onTap: () => model.goToRegisterPage(),
                          child: Text(
                            "Daftar",
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
              child: TransparentIconButton(
                onTap: () => model.goBack(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
