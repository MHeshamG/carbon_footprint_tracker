import 'dart:developer';

import 'package:carbon_footprint_tracker/core/BaseView.dart';
import 'package:carbon_footprint_tracker/core/BaseViewModel.dart';
import 'package:carbon_footprint_tracker/model/User.dart';
import 'package:carbon_footprint_tracker/navigation/Routes.dart';
import 'package:carbon_footprint_tracker/ui/widgets/TextInputWidget.dart';
import 'package:carbon_footprint_tracker/validators/UserCredentialsValidator.dart';
import 'package:carbon_footprint_tracker/viewmodel/LoginViewModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'AppColors.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (BuildContext context, LoginViewModel viewModel, Widget? child) =>
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
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
                          height: 500.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 32.0, bottom: 4.0),
                                child: Text(
                                  "LOGIN",
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
                              buildLoginForm(context,viewModel),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.SIGNUP);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Don't have an Account? Sign up",
                                      style: TextStyle(
                                          color: AppColors.appThemeColor),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      onModelReady: (viewModel)=>{},
    );
  }

  Padding buildSignupOptionIcon(IconData icon, Color? color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(icon, color: color, size: 35),
    );
  }

  Widget buildLoginForm(BuildContext context, LoginViewModel viewModel) {
    return Form(
      key: _formKey,
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
              _passwordController,
              "Password",
              Icons.lock,
              (passwordString) =>
                  UserCredentialsValidator.isNotValidPasswordFormat(
                      passwordString),
              true),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: RaisedButton(
              onPressed: () async{
                if (_formKey.currentState!.validate()) {
                  CUser currentUser = await viewModel.login(_emailController.text, _passwordController.text);
                  log("User email: ${currentUser.email}");
                  if(currentUser.email!=null)
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
                    "Login",
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

  Widget showLoading(ViewState state){
    if(state == ViewState.BUSY)
      return CircularProgressIndicator(backgroundColor: AppColors.appThemeColor,);
    else
      return Container();
  }
}
