import 'dart:async';

import 'package:carbon_footprint_tracker/model/User.dart';

abstract class AuthenticationService{
  Future<CUser> login(String email, String password);
  Future<bool> register(CUser user, String password);
  CUser getCurrentAuthorizedUser();
}