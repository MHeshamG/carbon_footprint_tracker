enum RedemptionPoint{ TRANSPORTATION_TICKET, PLANT_A_TREE , HEALTHY_MEAL , CHARITY}

class RedemptionVoucher{
  RedemptionPoint type;
  String image;
  int pointsToRedeem;

  RedemptionVoucher(this.type,this.image, this.pointsToRedeem);
}