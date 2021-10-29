import 'package:carbon_footprint_tracker/core/BaseView.dart';
import 'package:carbon_footprint_tracker/model/TotalElementsCarbonEmission.dart';
import 'package:carbon_footprint_tracker/ui/AppColors.dart';
import 'package:carbon_footprint_tracker/ui/CarbonEmissionPage.dart';
import 'package:carbon_footprint_tracker/viewmodel/MonthlyCarbonViewModel.dart';
import 'package:flutter/material.dart';

class MonthlyCarbonEmissionPage extends CarbonEmissionPage {
  @override
  Widget build(BuildContext context) {
    return BaseView<MonthlyCarbonEmissionViewModel>(
        builder: (BuildContext context, MonthlyCarbonEmissionViewModel viewModel,
            Widget? child) =>
             buildTotalMonthlyLayout(viewModel.elements,context),
        onModelReady: (carbonEmissionViewModel) {
          carbonEmissionViewModel.getElementsEmittingCarbonMonthly();
        });
  }

  Widget buildTotalMonthlyLayout(List<TotalElementsCarbonEmission> elements, BuildContext context) {
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
        Expanded(child: buildMonthlyListView(elements))
      ],
    );
  }

  Widget buildMonthlyListView(List<TotalElementsCarbonEmission> elements) {
    return ListView.builder(
      itemCount: elements.length,
      itemBuilder: (buildContext, index) =>
          buildMonthlyListItem(elements[index]),
    );
  }

  Widget buildMonthlyListItem(TotalElementsCarbonEmission element) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.date_range, color: AppColors.beautyblue, size: 32),
            ),
            Text(
              element.datetime,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      element.carbonQuantity.toString(),
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Text(
                    "Kg",
                    style:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.w200),
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