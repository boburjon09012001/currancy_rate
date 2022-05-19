import 'dart:convert';

import 'package:currancy_rate_uz/currancy_rate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<CurrancyRate> currancyList = [];
  @override
  void initState(){
    super.initState();
    getCurrancyRate();
  }

  Future<List<CurrancyRate>> getCurrancyRate() async {
    String url = "https://nbu.uz/uz/exchange-rates/json/";

    Uri myURL = Uri.parse(url);

    var response = await http.get(myURL);
    List<dynamic> data = jsonDecode(response.body);
    currancyList.clear();
    data.forEach((element) {
      currancyList.add(CurrancyRate.fromJson(element));
    });

    return currancyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFDFDFDC),
      appBar: AppBar(
        backgroundColor:const Color(0xFFDFDFDC),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){}, icon:const Icon(Icons.search, size: 26,color: Colors.grey,)),
          ),
        ],
        elevation: 0,
        title:const Text("Valyuta kursi", style: TextStyle(color: Color(0xFF373737), fontWeight: FontWeight.w600, fontSize: 21),),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: FutureBuilder(
            future: getCurrancyRate(),
            builder: (BuildContext context , AsyncSnapshot<List<CurrancyRate>>snapshot){
          return  ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder:(BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.19,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 10,
                      child: Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               Row(
                                 children: [
                                   Image.asset("assets/images/${snapshot.data?[index].code}.png", width: 30,height: 30,),
                                 const  SizedBox(width: 10,),
                                   Text(snapshot.data?[index].code ?? "...",
                                     style:const TextStyle(fontSize: 21.0, fontWeight: FontWeight.w600),),
                                 ],
                               ),
                                Column(
                                  children: [
                                    IconButton(onPressed: (){}, icon:const Icon(Icons.notifications_active_outlined,
                                      color: Colors.grey,size: 29,))
                                  ],
                                ),
                              ],
                            ),
                          const  SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                 const   Text("MB kursi", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFB2B3B5), fontSize:17),),
                                 const   SizedBox(height: 4.0,),
                                    Text(snapshot.data?[index].cb_price ?? "...",
                                        style:const TextStyle(fontWeight: FontWeight.w600, fontSize:17)),
                                  ],
                                ),
                                Column(
                                  children: [
                                  const  Text("Sotib olish", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFB2B3B5), fontSize:17),),
                                   const SizedBox(height: 4.0,),
                                    Text(snapshot.data?[index].nbu_buy_price ?? "...",
                                        style:const TextStyle(fontWeight: FontWeight.w600, fontSize:17)),
                                  ],
                                ),
                                Column(
                                  children: [
                                  const  Text("Sotish", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFB2B3B5), fontSize:17),),
                                   const SizedBox(height: 4.0,),
                                    Text(snapshot.data?[index].nbu_cell_price ?? "...",
                                        style:const TextStyle(fontWeight: FontWeight.w600, fontSize:17)),
                                  ],
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } );
        })
      ),
    );
  }
}
