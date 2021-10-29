import 'package:carbon_footprint_tracker/model/RedemptionVouchers.dart';

class VoucherTitleMapper {
  static String getTitle(RedemptionPoint point){
    switch(point) {
      case RedemptionPoint.TRANSPORTATION_TICKET:
        return 'Transportation Ticket';
      case RedemptionPoint.PLANT_A_TREE:
        return 'Plant a tree';
      case RedemptionPoint.CHARITY:
        return 'Support Charity';
      case RedemptionPoint.HEALTHY_MEAL:
        return 'Get Healthy Meal';
    }
  }
}