import 'dart:async';
import 'dart:developer';

import 'package:carbon_footprint_tracker/core/AuthenticationService.dart';
import 'package:carbon_footprint_tracker/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService extends AuthenticationService {
  late CUser currentAuthorizedUser;
  late FirebaseFirestore _firestore;

  FirebaseAuthenticationService() {
    _firestore = FirebaseFirestore.instance;
  }

  @override
  Future<CUser> login(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
    currentAuthorizedUser = CUser(userCredential.user?.email);
    await loadThisUserData(currentAuthorizedUser);
    log("Auth Service User Data: ${currentAuthorizedUser.phone}  ${currentAuthorizedUser.email}");
    return currentAuthorizedUser;
  }

  @override
  Future<bool> register(CUser user, String password) async{
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: user.email!, password: password);

     _firestore.collection("Users").add(user.toJsonFormat());
    currentAuthorizedUser = CUser(userCredential.user?.email);
    await loadThisUserData(currentAuthorizedUser);
    log("User Id: ${userCredential.user?.uid}");
    return userCredential.user?.uid != null;
  }

  Future<void> loadThisUserData(CUser currentUser) async {
    try {
      await _firestore.collection("Users").where(
          "email", isEqualTo: currentUser.email).get().then((users) =>
          currentUser.loadData(users.docs.first.data()));
    }
    catch(e){
      log(e.toString());
    }
  }

  @override
  CUser getCurrentAuthorizedUser() {
    return currentAuthorizedUser;
  }
}
