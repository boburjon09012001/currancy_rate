import 'package:currancy_rate_uz/screens/widgets/snacbar_widget.dart';
import 'package:currancy_rate_uz/viewmodels/api_response.dart';
import 'package:currancy_rate_uz/viewmodels/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

   MainViewModel? _mainVM;

   @override
   void initState(){
     super.initState();
     _mainVM = Provider.of<MainViewModel>(context ,listen:false);
   }



  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor:const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor:const Color(0xFFFFFFFF),

        elevation: 0,
        title:const Text("Valyuta kursi", style: TextStyle(color: Color(0xFF373737),
            fontWeight: FontWeight.w600, fontSize: 21),),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: FutureBuilder(
            future: _mainVM?.getCurrancyRate(),
            builder: (BuildContext context , AsyncSnapshot<ApiResponse>snapshot){
              if(snapshot.data?.status == Status.LOADING){
                return const Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.data?.status == Status.SUCCESS){
                return  RefreshIndicator(
                  strokeWidth: 3,
                  onRefresh: _pullRefresh,
                  child: ListView.builder(
                      itemCount: snapshot.data?.data.length ?? 0,
                      itemBuilder:(BuildContext context, int index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.19,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              child: Padding(
                                padding:const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset("assets/images/${snapshot.data?.data?[index].code}.png",
                                              width: 30,height: 30,),
                                            const  SizedBox(width: 6,),
                                            Text(snapshot.data?.data?[index].code ?? "...",
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
                                            Text(snapshot.data?.data?[index].cb_price ?? "...",
                                                style:const TextStyle(fontWeight: FontWeight.w600, fontSize:17)),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const  Text("Sotib olish", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFB2B3B5), fontSize:17),),
                                            const SizedBox(height: 4.0,),
                                            Text(snapshot.data?.data?[index].nbu_buy_price ?? "...",
                                                style:const TextStyle(fontWeight: FontWeight.w600, fontSize:17)),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const  Text("Sotish", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFB2B3B5), fontSize:17),),
                                            const SizedBox(height: 4.0,),
                                            Text(snapshot.data?.data?[index].nbu_cell_price ?? "...",
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
                      } ),
                );
              }
              if(snapshot.data?.status == Status.ERROR){
                return buildError(snapshot.data?.message);
              }
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Center(child: Text(snapshot.data?.message ?? "Initial",
                      style:const TextStyle(fontSize: 24.0),
                    ),),
                  ],
                ),
              );



        })
      ),
    );
  }


  Widget buildError(String? errorMsg){
     return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(errorMsg ?? "Error",
             style:const TextStyle(fontSize: 24.0),
           ),
           SizedBox(
             height: MediaQuery.of(context).size.height * 0.05,
           ),
          Image.asset("assets/images/zzz.png"),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
           buttonSign(),
         ],
       ),);
  }

  Widget buildRefresh(){
     return  IconButton(onPressed: (){
       setState((){
         _mainVM?.getCurrancyRate();
       });
     }, icon:const Icon(Icons.refresh_outlined, color: Colors.black87,size: 27,));
  }

  Widget buttonSign(){
     return SizedBox(
       width: 314.0,
       height: 50.0,
       child: ElevatedButton(
         onPressed: () {
           setState(() {
             _mainVM?.getCurrancyRate();
           });
         },
         style: ButtonStyle(
             padding: MaterialStateProperty.all<EdgeInsets>(
                 const EdgeInsets.all(12)),
             foregroundColor:
             MaterialStateProperty.all<Color>(Colors.black),
             backgroundColor:
             MaterialStateProperty.all<Color>(const Color(0xFF0083FF)),
             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                 RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10.0),
                   side: const BorderSide(
                     color: Color(0xFF0083FF),
                   ),
                 ))),
         child: const Text(
           "Takrorlash",
           style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20.0),
         ),
       ),
     );
  }

   Future<void> _pullRefresh() async {
      await _mainVM?.getCurrancyRate();
     setState(() {
       _mainVM?.getCurrancyRate();
     });

   }
}





