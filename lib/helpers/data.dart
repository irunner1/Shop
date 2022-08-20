// import 'dart:convert';

// // import 'package:app/helpers/item.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http; 
// import '../helpers/tre.dart';


// class DataFromAPI extends StatefulWidget {
//   const DataFromAPI({Key? key}) : super(key: key);

//   @override
//   State<DataFromAPI> createState() => _DataFromAPIState();
// }

// class _DataFromAPIState extends State<DataFromAPI> {
//   // getUserData() async {
//   //   var response = await http.get(Uri.https('https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175', '654bd15e-b121-49ba-a588-960956b15175'));
//   //   var jsonData = jsonDecode(response.body);
//   //   List<HomeStore> homeStore = [];

//   //   List<BestSeller> bestSales = [];

//   //   for (var i in jsonData) {
//   //     BestSeller bestSeller = BestSeller(i["is_favorites"], i["title"], i["price_without_discount"], i["discount_price"], i["picture"]);
//   //     bestSales.add(bestSeller);
//   //     HomeStore homeStre = HomeStore(i["is_new"], i["title"], i["subtitle"], i["picture"], i["is_buy"]);
//   //     homeStore.add(homeStre);
//   //   }
//   // }
//   List<HomeStore> users = getUsers();
//   static List<HomeStore> getUsers() {
//   const data = [
//     {
//       {
//         "title": "Iphone 12",
//         "subtitle": "Súper. Mega. Rápido.",
//         "picture": "https://img.ibxk.com.br/2020/09/23/23104013057475.jpg?w=1120&h=420&mode=crop&scale=both",
//         "is_buy" : true
//       },
//       {
//         "title": "Samsung Galaxy A71",
//         "subtitle": "Súper. Mega. Rápido.",
//         "picture": "https://cdn-2.tstatic.net/kupang/foto/bank/images/pre-order-samsung-galaxy-a71-laris-manis-inilah-rekomendasi-ponsel-harga-rp-6-jutaan.jpg",
//         "is_buy" : true
//       },
//       {
//         "title": "Xiaomi Mi 11 ultra",
//         "subtitle": "Súper. Mega. Rápido.",
//         "picture": "https://static.digit.in/default/942998b8b4d3554a6259aeb1a0124384dbe0d4d5.jpeg",
//         "is_buy" : true
//       }
//     }
//   ];
//   // return data.map<HomeStore>(HomeStore.fromJson).toList();
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: ListView.builder(
//           itemCount: users.length,
//           itemBuilder: ((context, index) {
//             final user = users[index];
//             return ListTile(
//               title: Text(user.title),
//             );
//           })
//         ),
//         // child: FutureBuilder(
//         //   future: getUserData(),
//         //   builder: (context, snapshot) {
//         //     return ListView.builder(
//         //       itemCount: snapshot.data.length,
//         //       itemBuilder: (BuildContext context, int index) { 
//         //         return ListTile(
//         //           title: Text(bestSales[index].title),
//         //           subtitle: Text(bestSales[index].price_without_discount),
//         //         );
//         //       },
//         //     );
//         //   },
//         // ),
//       ),
//     );
//   }
// }