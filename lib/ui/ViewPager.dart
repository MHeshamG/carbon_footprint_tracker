import 'package:carbon_footprint_tracker/ui/AppColors.dart';
import 'package:carbon_footprint_tracker/ui/MonthlyCarbonEmissionPage.dart';
import 'package:carbon_footprint_tracker/ui/TodayCarbonEmissionPage.dart';
import 'package:flutter/material.dart';

class ViewPager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            elevation: 0.0,

            backgroundColor: AppColors.appThemeColor,
            iconTheme: IconThemeData(color: Colors.pink),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: AppColors.white.withOpacity(0.4),
              tabs: [
                Tab(text: "Today"),
                Tab(text: "Monthly")
              ],
            ),),

        ),
        body:  buildLayout(context),
      ),
    );
  }

  Widget buildLayout(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 180,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.jungle_green, AppColors.beautyblue])),
      ),
      TabBarView(
        children: [
          TodayCarbonEmissionPage(),
          MonthlyCarbonEmissionPage()
        ],
      ),
    ]);
  }
}