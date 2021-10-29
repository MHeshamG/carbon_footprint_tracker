enum ElementType { Fuel, Electricity, Water, Food, Unkown }

class ElementCarbonFootPrint {
  ElementType type;
  String name;
  String elementUnit;
  double elementQuantity;
  double carbonQuantity;
  DateTime datetime;

  ElementCarbonFootPrint(this.type, this.name, this.elementQuantity,
      this.elementUnit, this.carbonQuantity, this.datetime);

  static ElementCarbonFootPrint fromJson(Map<String, dynamic> data) {
    return ElementCarbonFootPrint(
      toElementType(data["type"]),
      data["element_name"],
      double.parse(data["element_quantity"]),
      data["element_unit"],
      double.parse(data["carbon_quantity"]),
      data["date_time"].toDate(),
    );
  }

  static ElementType toElementType(int type){
    switch (type){
      case 0:
        return ElementType.Fuel;
      case 1:
        return ElementType.Electricity;
      case 2:
        return ElementType.Water;
      case 3:
        return ElementType.Food;
    }
    return ElementType.Unkown;
  }
}
