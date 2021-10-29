import 'package:carbon_footprint_tracker/model/Points.dart';
import 'package:carbon_footprint_tracker/model/RedemptionVouchers.dart';

abstract class PointsRepository {
  Future<Points> getPoints();
  Future<List<RedemptionVoucher>> getRedemptionVouchers();

}