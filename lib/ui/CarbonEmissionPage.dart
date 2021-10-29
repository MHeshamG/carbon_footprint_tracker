import 'package:carbon_footprint_tracker/navigation/Routes.dart';
import 'package:carbon_footprint_tracker/ui/AppColors.dart';
import 'package:flutter/material.dart';

abstract class CarbonEmissionPage extends StatelessWidget {

  Widget buildTotalDataCard(String totalCarbonEmitted) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        margin: EdgeInsets.only(top: 40),
        height: 180,
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 4.0,
          color: AppColors.white.withOpacity(0.9),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      totalCarbonEmitted,
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w300,
                          color: AppColors.red),
                    ),
                    Text(
                      " /",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: AppColors.red),
                    ),
                    Text(
                      " xxxx ",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: AppColors.red),
                    ),
                    Text(
                      " Kg",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: AppColors.red),
                    ),
                  ],
                ),
                Text(
                  "Total Carbon Emission",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w200,
                      color: AppColors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRedeemCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("What about a treat?",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: AppColors.beautyblue)),
                  Text("Reedem your points",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                          color: AppColors.beautyblue)),
                ],
              ),
              ElevatedButton(
                  onPressed: () =>
                      {Navigator.pushNamed(context, Routes.REEDEMING_PAGE)},
                  child: Text("REEDEM",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: AppColors.jungle_green)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  BorderSide(color: AppColors.jungle_green)))))
            ],
          ),
        ),
      ),
    );
  }
}
