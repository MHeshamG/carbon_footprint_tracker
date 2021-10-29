

class Points {
  int redemptionPoints;
  Points(this.redemptionPoints);

  static Points fromJson(Map<String, dynamic> data) {
    return Points(int.parse(data["points"]));
  }
}
