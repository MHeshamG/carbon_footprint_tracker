
import 'package:carbon_footprint_tracker/model/ElementCarbonFootPrint.dart';
import 'package:carbon_footprint_tracker/model/TotalElementsCarbonEmission.dart';
import 'package:carbon_footprint_tracker/repository/CarbonRepository.dart';
//
// class CarbonRepositoryMock extends CarbonRepository{
//   @override
//   List<ElementCarbonFootPrint> getTodayElements() {
//     List<ElementCarbonFootPrint> elements = [
//       ElementCarbonFootPrint(ElementType.Fuel, "Gas", 1.0, "Liter", 3, DateTime.now()),
//       ElementCarbonFootPrint(ElementType.Food, "Meat", 1.0, "Kg", 0.5, DateTime.now()),
//       ElementCarbonFootPrint(ElementType.Water, "Water", 1.0, "Liter", 1, DateTime.now())
//     ];
//     return elements;
//   }
//
//   @override
//   List<TotalElementsCarbonEmission> getMonthlyElements() {
//     List<ElementCarbonFootPrint> elements = [
//       ElementCarbonFootPrint(ElementType.Fuel, "Gas", 1.0, "Liter", 4, DateTime.now()),
//       ElementCarbonFootPrint(ElementType.Fuel, "Gas", 1.0, "Liter", 4, DateTime.now()),
//       ElementCarbonFootPrint(ElementType.Food, "Meat", 1.0, "Kg", 0.5, DateTime.now()),
//       ElementCarbonFootPrint(ElementType.Water, "Water", 1.0, "Liter", 1, DateTime.now())
//     ];
//     Map<int, TotalElementsCarbonEmission> monthTotalElementsMap = Map<int, TotalElementsCarbonEmission>();
//     for(var e in elements){
//       var key = e.datetime.month + e.datetime.year;
//       if(monthTotalElementsMap.containsKey(key)) {
//         monthTotalElementsMap[key]!.carbonQuantity += e.carbonQuantity;
//       }
//       monthTotalElementsMap.putIfAbsent(key, () =>
//           TotalElementsCarbonEmission(
//               e.carbonQuantity, "${e.datetime.year}-${e.datetime.month}"));
//     }
//     List<TotalElementsCarbonEmission> totalElementsCarbonEmissionList = [];
//     monthTotalElementsMap.forEach((key, value) { totalElementsCarbonEmissionList.add(value);});
//     return totalElementsCarbonEmissionList;
//   }
// }