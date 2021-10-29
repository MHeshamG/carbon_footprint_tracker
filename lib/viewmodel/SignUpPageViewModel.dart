

import 'package:carbon_footprint_tracker/core/AuthenticationService.dart';
import 'package:carbon_footprint_tracker/core/BaseViewModel.dart';
import 'package:carbon_footprint_tracker/model/User.dart';

import '../Locator.dart';

class SignUpPageViewModel extends BaseViewModel{
  bool success = false;
  AuthenticationService _auth = getIt<AuthenticationService>();

  Future<bool> signup(CUser user,String password) async{
    setState(ViewState.BUSY);
    success = await _auth.register(user, password);
    setState(ViewState.IDLE);
    return success;
  }
}