import 'package:carbon_footprint_tracker/core/BaseView.dart';
import 'package:carbon_footprint_tracker/core/BaseViewModel.dart';
import 'package:carbon_footprint_tracker/model/User.dart';
import 'package:carbon_footprint_tracker/navigation/Routes.dart';
import 'package:carbon_footprint_tracker/ui/widgets/TextInputWidget.dart';
import 'package:carbon_footprint_tracker/validators/UserCredentialsValidator.dart';
import 'package:carbon_footprint_tracker/viewmodel/SignUpPageViewModel.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';
class SignUpPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>SignUpPageState();

}
class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  static final _signUpformKey = GlobalKey<FormState>();
  bool isSignUpButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      builder:
          (BuildContext context, SignUpPageViewModel viewModel, Widget? child) =>
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.jungle_green,
                            AppColors.beautyblue
                          ])),
                ),
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          height: 590.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 32.0, bottom: 4.0),
                                child: Text(
                                  "SIGNUP",
                                  style: TextStyle(
                                      color: AppColors.appThemeColor,
                                      fontSize: 24.0),
                                ),
                              ),
                              Container(
                                height: 1,
                                width: 100,
                                color: AppColors.appThemeColor,
                                child: Divider(),
                              ),
                              buildSignupForm(context, viewModel),
                              viewModel.state == ViewState.BUSY ?
                              CircularProgressIndicator() : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ), onModelReady: (SignUpPageViewModel viewModel) {  },
    );
  }

  Widget buildSignupForm(BuildContext context, SignUpPageViewModel viewModel) {
    return Form(
      key: _signUpformKey,
      child: Column(
        children: <Widget>[
          TextInputWidget(
              _emailController,
              "Email",
              Icons.email,
                  (emailString) =>
                  UserCredentialsValidator.isNotValidEmailFormat(emailString),
              false),
        TextInputWidget(
            _nameController,
            "Name",
            Icons.account_circle,
                (nameString) =>
                UserCredentialsValidator.isNotValidNameFormat(nameString),
            false),
          TextInputWidget(
              _passwordController,
              "Password",
              Icons.lock,
                  (passwordString) =>
                  UserCredentialsValidator.isNotValidPasswordFormat(
                      passwordString),
              true),
          TextInputWidget(
              _phoneController,
              "Phone",
              Icons.phone_android,
                  (phoneString) =>
                  UserCredentialsValidator.isNotValidPhoneFormat(phoneString),
              false),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: RaisedButton(
              onPressed: () async {
                if (_signUpformKey.currentState!.validate()) {
                  isSignUpButtonPressed = true;
                  CUser newUser = CUser.createUserWithWholeData(
                      _emailController.text,
                      _nameController.text,
                      _phoneController.text);
                  bool success = await viewModel.signup(newUser, _passwordController.text);
                  if(success)
                    Navigator.pushNamed(context, Routes.CARBON_EMISSION_PAGE);
                }
              },
              color: AppColors.appThemeColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Container(
                width: 120,
                height: 40,
                child: Center(
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
