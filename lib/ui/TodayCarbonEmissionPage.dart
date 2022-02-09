import 'package:carbon_footprint_tracker/core/BaseView.dart';
import 'package:carbon_footprint_tracker/model/ElementCarbonFootPrint.dart';
import 'package:carbon_footprint_tracker/ui/AppColors.dart';
import 'package:carbon_footprint_tracker/ui/CarbonEmissionPage.dart';
import 'package:carbon_footprint_tracker/viewmodel/TodayCarbonEmissionViewModel.dart';

import 'package:flutter/material.dart';

import 'CarbonEmittingElementUiMapper.dart';

class TodayCarbonEmissionPage extends CarbonEmissionPage {
  @override
  Widget build(BuildContext context) {
    return BaseView<TodayCarbonEmissionViewModel>(
        builder: (BuildContext context, TodayCarbonEmissionViewModel viewModel,
            Widget? child) =>
            buildTodayLayout(viewModel.elements,context),
        onModelReady: (carbonEmissionViewModel) {
          carbonEmissionViewModel.getElementsEmittingCarbonToday();
        });
  }

  Widget buildTodayLayout(List<ElementCarbonFootPrint> elements, BuildContext context) {
    double total = elements.isNotEmpty
        ? elements
        .map((element) => element.carbonQuantity)
        .reduce((sum, value) => sum + value)
        : 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTotalDataCard(total.toString()),
        buildRedeemCard(context),
        Expanded(child: buildTodayListView(elements))
      ],
    );
  }

  Widget buildTodayListView(List<ElementCarbonFootPrint> elements) {
    return ListView.builder(
      itemCount: elements.length,
      itemBuilder: (buildContext, index) => buildTodayListItem(elements[index]),
    );
  }

  Widget buildTodayListItem(ElementCarbonFootPrint element) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CarbonEmittingElementUiMapper.getIcon(element),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          element.name,
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Quantity",
                              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300,color: Colors.yellow[700]),
                            ),
                            Row(
                              children: [
                                Text(
                                  element.elementQuantity.toString(),
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  " "+element.elementUnit,
                                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Carbon",
                              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300,color: AppColors.red),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  element.carbonQuantity.toString(),
                                  style: TextStyle(
                                      fontSize: 24.0, fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  " kg",
                                  style:
                                  TextStyle(fontSize: 18.0, fontWeight: FontWeight.w200),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: AppColors.jungle_green,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        CarbonEmittingElementUiMapper.getNote(element),
                        style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300,color: AppColors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
