import 'package:carbon_footprint_tracker/model/ElementCarbonFootPrint.dart';
import 'package:carbon_footprint_tracker/ui/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarbonEmittingElementUiMapper
{
  static Widget getIcon(ElementCarbonFootPrint element){
    double size = 48;
    switch(element.type) {
      case ElementType.Food:
        return Icon(Icons.fastfood_outlined,color: Colors.orange[700],size: size,);
      case ElementType.Fuel:
        return Icon(Icons.local_gas_station,color:Colors.red[600],size: size);
      case ElementType.Electricity:
        return Icon(Icons.electrical_services_rounded,color: Colors.blueGrey[700],size: size);
      case ElementType.Water:
        return Icon(Icons.water_damage_rounded,color: AppColors.beautyblue,size: size);
      default:
        return Icon(Icons.new_releases_outlined,color: Colors.cyanAccent[700],size: size);
    }
  }

  static String getNote(ElementCarbonFootPrint element){
    double size = 48;
    switch(element.type) {
      case ElementType.Food:
        return "You can go for vegetable alternatives.";
      case ElementType.Fuel:
        return "Take the bus or take a bike for short rides.";
      case ElementType.Electricity:
        return "You can turn off uneeded devices.";
      case ElementType.Water:
        return "Check on the valves regularly.";
      default:
        return "";
    }
  }
}