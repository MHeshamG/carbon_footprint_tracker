import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStoreInstance {
  static getInstance() {
    return FirebaseFirestore.instance;
  }
}
