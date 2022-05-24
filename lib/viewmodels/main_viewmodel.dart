import 'dart:convert';
import 'dart:io';
import 'package:currancy_rate_uz/viewmodels/api'
    '_response.dart';
import 'package:flutter/material.dart';
import '../models/currancy_rate.dart';
import 'package:http/http.dart' as http;


class MainViewModel extends ChangeNotifier{
  ApiResponse _apiResponse = ApiResponse.initial("Empty");
  List<CurrancyRate>  _currencyList = [];

  ApiResponse get response{
    return _apiResponse;
  }

  List<CurrancyRate>  get currencies{
    return _currencyList;
  }


  Future<ApiResponse> getCurrancyRate() async {
    String url = "https://nbu.uz/uz/exchange-rates/json/";

    Uri myURL = Uri.parse(url);

    try {
      var response = await http.get(myURL);
      List data = jsonDecode(response.body);
      _currencyList.clear();
      data.forEach((element) {
        _currencyList.add(CurrancyRate.fromJson(element));
      });
      _apiResponse  = ApiResponse.success(_currencyList);
    }catch(exception){
           if(exception is SocketException){
             _apiResponse =
                 ApiResponse.error("Internet bilan muammo bor!");
           }
          else{
             _apiResponse = ApiResponse.error(exception.toString());
           }

    }


    return _apiResponse;
  }

}