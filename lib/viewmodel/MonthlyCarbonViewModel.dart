import 'package:carbon_footprint_tracker/Locator.dart';
import 'package:carbon_footprint_tracker/core/BaseViewModel.dart';
import 'package:carbon_footprint_tracker/model/ElementCarbonFootPrint.dart';
import 'package:carbon_footprint_tracker/model/TotalElementsCarbonEmission.dart';
import 'package:carbon_footprint_tracker/repository/CarbonRepository.dart';

class MonthlyCarbonEmissionViewModel extends BaseViewModel
{
  CarbonRepository carbonRepository = getIt<CarbonRepository>();
  List<TotalElementsCarbonEmission> elements = [];

  void getElementsEmittingCarbonMonthly() async {
    setState(ViewState.BUSY);
    elements = await carbonRepository.getMonthlyElements();
    setState(ViewState.IDLE);
  }

}