import 'package:carbon_footprint_tracker/core/AuthenticationService.dart';
import 'package:carbon_footprint_tracker/core/BaseViewModel.dart';
import 'package:carbon_footprint_tracker/model/User.dart';

import '../Locator.dart';

class LoginViewModel extends BaseViewModel{

  AuthenticationService _authenticationService;
  late CUser user;

  LoginViewModel():
    _authenticationService = getIt<AuthenticationService>();

  Future<CUser> login(String email, String password) async{
    setState(ViewState.BUSY);
    user = await _authenticationService.login(email, password);
    setState(ViewState.IDLE);
    return user;
  }


}