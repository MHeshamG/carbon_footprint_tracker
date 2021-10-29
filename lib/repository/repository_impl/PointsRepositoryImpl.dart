import 'dart:async';

import 'package:carbon_footprint_tracker/core/AuthenticationService.dart';
import 'package:carbon_footprint_tracker/firebase/FirebaseStoreInstance.dart';
import 'package:carbon_footprint_tracker/model/Points.dart';
import 'package:carbon_footprint_tracker/model/RedemptionVouchers.dart';
import 'package:carbon_footprint_tracker/repository/PointsRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Locator.dart';

class PointsRepositoryImpl extends PointsRepository {

  late FirebaseFirestore firestore;
  Points? points;

  PointsRepositoryImpl() {
    firestore = FirebaseStoreInstance.getInstance();
  }

  @override
  Future<Points> getPoints() async {
    Completer<Points> completer = Completer();
    CollectionReference rewardPoints = firestore.collection('reward_points');
    points = await rewardPoints
        .where("user_id",
            isEqualTo:
                getIt<AuthenticationService>().getCurrentAuthorizedUser().phone)
        .get()
        .then((value) =>
            Points.fromJson(value.docs.first.data() as Map<String, dynamic>));

    completer.complete(points);
    return completer.future;

  }

  @override
  Future<List<RedemptionVoucher>> getRedemptionVouchers() {
    Completer<List<RedemptionVoucher>> completer = new Completer();
    List<RedemptionVoucher> list = [];
    list.add(RedemptionVoucher(RedemptionPoint.TRANSPORTATION_TICKET, 'lib/assets/transportation.png', 300));
    list.add(RedemptionVoucher(RedemptionPoint.PLANT_A_TREE, 'lib/assets/tree.png', 400));
    list.add(RedemptionVoucher(RedemptionPoint.CHARITY, 'lib/assets/charity.png', 200));
    list.add(RedemptionVoucher(RedemptionPoint.HEALTHY_MEAL, 'lib/assets/meal.png', 100));
    completer.complete(list);
    return completer.future;
  }


}
