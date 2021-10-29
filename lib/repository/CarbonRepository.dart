import 'package:carbon_footprint_tracker/model/Points.dart';
import 'package:carbon_footprint_tracker/model/TotalElementsCarbonEmission.dart';

import '../model/ElementCarbonFootPrint.dart';

abstract class CarbonRepository{
  Future<List<ElementCarbonFootPrint>> getTodayElements();
  Future<List<TotalElementsCarbonEmission>> getMonthlyElements();

}