import 'package:carbon_footprint_tracker/core/BaseView.dart';
import 'package:carbon_footprint_tracker/core/BaseViewModel.dart';
import 'package:carbon_footprint_tracker/mocks/VoucherTitleMapper.dart';
import 'package:carbon_footprint_tracker/viewmodel/PointsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'AppColors.dart';

class RedeemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RedeemPageScreen();
  }
}

class RedeemPageScreen extends State<RedeemPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PointsViewModel>(
        builder:
            (BuildContext context, PointsViewModel viewModel, Widget? child) =>
                buildLayout(viewModel, context),
        onModelReady: (pointsViewModel) {
          pointsViewModel.getPoints();
          pointsViewModel.getRedemptionVouchers();
        });
  }

  Widget buildLayout(PointsViewModel pointsViewModel, BuildContext context) {
    if (pointsViewModel.state == ViewState.BUSY)
      return showLoading();
    else
      return showPageContent(pointsViewModel, context);
  }

  Scaffold showPageContent(PointsViewModel pointsViewModel, BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.pink),
        centerTitle: true,
        title: Text(
          "Redeem Your Points",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              child: Container(
                width: Size.fromWidth(double.infinity).width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text("Total Points you have:",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              color: AppColors.appThemeColor)),
                      Text(pointsViewModel.points.redemptionPoints.toString(),
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w300,
                              color: AppColors.appThemeColor)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(pointsViewModel.redemptionVouchers.length, (index) {
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            child: Image(
                              image: AssetImage(pointsViewModel.redemptionVouchers[index].image),
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                        ),
                        Text(
                            '${VoucherTitleMapper.getTitle(pointsViewModel.redemptionVouchers[index].type)}',
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,)),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () => {
                                  // not enough points
                                  if (pointsViewModel.points.redemptionPoints < pointsViewModel.redemptionVouchers[index].pointsToRedeem)
                                    buildNotEnoughPointsDrawer(context)
                                  else
                                    buildSuccessfulPointsDrawer(context, pointsViewModel, index)
                                },
                            child: Text(
                                "${pointsViewModel.redemptionVouchers[index].pointsToRedeem} POINTS",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.jungle_green)),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    AppColors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: AppColors.jungle_green)))))
                      ],
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Center showLoading() {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.9),
        body: SpinKitDoubleBounce(
          color: Colors.blue,
        ),
      ),
    );
  }

  Future<dynamic> buildNotEnoughPointsDrawer(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text.rich(
                        new TextSpan(
                          children: <TextSpan>[
                            new TextSpan(
                                text: "You don't have enough points",
                                style: new TextStyle(
                                    color: AppColors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)),
                            new TextSpan(
                                text:
                                    "\n\nTry reducing carbon usage to gain more points")
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        child: ElevatedButton(
                            child: Text("OK"),
                            style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.green,
                                fixedSize: Size.fromWidth(200)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        alignment: Alignment.bottomCenter,
                      ),
                    )
                  ]),
            ),
          );
        });
  }

  Future<dynamic> buildSuccessfulPointsDrawer(
      BuildContext context, PointsViewModel pointsViewModel, int index) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text.rich(
                        new TextSpan(
                          children: <TextSpan>[
                            new TextSpan(
                                text: "Congratulations!",
                                style: new TextStyle(
                                    color: AppColors.appThemeColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)),
                            new TextSpan(
                                text:
                                    "\n\nYou have successfully redeemed your points. Keep on reducing carbon usage to save the world!")
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        child: ElevatedButton(
                            child: Text("OK"),
                            style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.green,
                                fixedSize: Size.fromWidth(200)),
                            onPressed: () {
                              setState(() {
                                pointsViewModel.setPoints(pointsViewModel
                                        .redemptionVouchers[index]
                                        .pointsToRedeem -
                                    pointsViewModel.points.redemptionPoints);
                              });
                              Navigator.of(context).pop();
                            }),
                        alignment: Alignment.bottomCenter,
                      ),
                    )
                  ]),
            ),
          );
        },
        isDismissible: false);
  }
}
