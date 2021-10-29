import 'package:carbon_footprint_tracker/Locator.dart';
import 'package:carbon_footprint_tracker/core/BaseViewModel.dart';
import 'package:carbon_footprint_tracker/repository/CarbonRepository.dart';
import 'package:carbon_footprint_tracker/model/ElementCarbonFootPrint.dart';

class TodayCarbonEmissionViewModel extends BaseViewModel
{
  CarbonRepository carbonRepository = getIt<CarbonRepository>();
  List<ElementCarbonFootPrint> elements = [];

  void getElementsEmittingCarbonToday() async {
    setState(ViewState.BUSY);
    elements = await carbonRepository.getTodayElements();
    setState(ViewState.IDLE);
  }

}