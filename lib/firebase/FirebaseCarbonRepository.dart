import 'dart:async';
import 'dart:developer';

import 'package:carbon_footprint_tracker/Locator.dart';
import 'package:carbon_footprint_tracker/core/AuthenticationService.dart';
import 'package:carbon_footprint_tracker/firebase/FirebaseStoreInstance.dart';
import 'package:carbon_footprint_tracker/model/ElementCarbonFootPrint.dart';
import 'package:carbon_footprint_tracker/model/Points.dart';
import 'package:carbon_footprint_tracker/model/TotalElementsCarbonEmission.dart';
import 'package:carbon_footprint_tracker/repository/CarbonRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCarbonRepository extends CarbonRepository {
  late FirebaseFirestore firestore;
  List<ElementCarbonFootPrint> elementsEmittingCarbon = [];

  FirebaseCarbonRepository() {
    log("Constructor Firebase");
    firestore = FirebaseStoreInstance.getInstance();
  }

  Future<List<ElementCarbonFootPrint>> getTodayElements() async{
    Completer<List<ElementCarbonFootPrint>> completer = Completer();
    var datetime = DateTime.now();

    if(elementsEmittingCarbon.isEmpty)
      elementsEmittingCarbon = await _loadData();
    List<ElementCarbonFootPrint> todayEmittingCarbonElements = [];
    elementsEmittingCarbon.forEach((element) {
      if (datetime.difference(element.datetime) < Duration(hours: Duration.hoursPerDay))
        todayEmittingCarbonElements.add(element);
    });
    log("elementsEmittingCarbon: ${elementsEmittingCarbon.length}");
    completer.complete(todayEmittingCarbonElements);
    return completer.future;
  }

  Future<List<TotalElementsCarbonEmission>> getMonthlyElements() async {
    Completer<List<TotalElementsCarbonEmission>> completer = Completer();

    Map<int, TotalElementsCarbonEmission> monthTotalElementsMap = Map<int, TotalElementsCarbonEmission>();
    if(elementsEmittingCarbon.isEmpty)
      elementsEmittingCarbon = await _loadData();

    for (var e in elementsEmittingCarbon) {
        var dateTime = e.datetime;
        var key = dateTime.month + dateTime.year;
        if (monthTotalElementsMap.containsKey(key)) {
          monthTotalElementsMap[key]!.carbonQuantity += e.carbonQuantity;
        }
        monthTotalElementsMap.putIfAbsent(
            key,
            () => TotalElementsCarbonEmission(
                e.carbonQuantity, "${dateTime.year}-${dateTime.month}"));
      }
    List<TotalElementsCarbonEmission> totalElementsCarbonEmissionList = [];
    monthTotalElementsMap.forEach((key, value) {
      totalElementsCarbonEmissionList.add(value);
    });
    completer.complete(totalElementsCarbonEmissionList);
    return completer.future;
  }

  Future<List<ElementCarbonFootPrint>> _loadData() async {
    CollectionReference carbonCollection = firestore.collection('Carbon');
    log("User Phone: ${getIt<AuthenticationService>().getCurrentAuthorizedUser().phone}");
    return await carbonCollection
        .where("user_id", isEqualTo: getIt<AuthenticationService>().getCurrentAuthorizedUser().phone)
        .get()
        .then((snapshot) => snapshot.docs.map((e) => ElementCarbonFootPrint.fromJson(
         e.data() as Map<String, dynamic>)).toList());
  }

}