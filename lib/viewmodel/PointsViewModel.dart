import 'package:carbon_footprint_tracker/core/BaseViewModel.dart';
import 'package:carbon_footprint_tracker/model/Points.dart';
import 'package:carbon_footprint_tracker/model/RedemptionVouchers.dart';
import 'package:carbon_footprint_tracker/repository/PointsRepository.dart';
import '../Locator.dart';

class PointsViewModel extends BaseViewModel
{
  PointsRepository pointsRepository = getIt<PointsRepository>();
  Points points = Points(0);
  List<RedemptionVoucher> redemptionVouchers = [];


  void getPoints() async {
    setState(ViewState.BUSY);
    points = await pointsRepository.getPoints();
    setState(ViewState.IDLE);
  }

  void getRedemptionVouchers() async{

    redemptionVouchers = await pointsRepository.getRedemptionVouchers();
  }

  void setPoints(int redemptionPoints){
    if(redemptionPoints<0) redemptionPoints=0;
    points.redemptionPoints = redemptionPoints;
  }
}