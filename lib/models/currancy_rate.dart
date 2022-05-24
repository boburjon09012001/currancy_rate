class CurrancyRate{
  String? title;
  String? code;
  String? cb_price;
  String? nbu_buy_price;
  String? nbu_cell_price;
  String? date;


  CurrancyRate(
      this.title,
      this.code,
      this.cb_price,
      this.nbu_buy_price,
      this.nbu_cell_price,
      this.date
      );

  CurrancyRate.fromJson(Map<String, dynamic> json){
    title = json['title'];
    code = json['code'];
    cb_price = json['cb_price'];
    nbu_buy_price = json['nbu_buy_price'];
    nbu_cell_price = json['nbu_cell_price'];
    date = json['date'];



  }
}