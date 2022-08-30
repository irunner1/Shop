// import 'dart:developer';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:app/pages/item_page.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import '../helpers/colors.dart';
// import '../helpers/item.dart';
// import '../helpers/data.dart';
// import 'dart:convert';
// import 'package:app/pages/cart_page.dart';


// class MyHome extends StatefulWidget {
//   final String? selectedTitle;

//   const MyHome({Key? key, required this.selectedTitle}) : super(key: key);

//   @override
//   State<MyHome> createState() => _MyHomeState();
// }

// class _MyHomeState extends State<MyHome> {
//   List<HomeStore> hotSales = [];
//   List<BestSeller> bestSales = [];
//   List<Cart> cartData = [];
//   List<BestSeller> bs = [];
//   late int selectedIndex;
//   late FocusNode node;

//   Future fetchHotSales() async {
//     var response = await http.get(Uri.https('run.mocky.io', '/v3/654bd15e-b121-49ba-a588-960956b15175'));
//     List<HomeStore> homeStore = [];
//     homeStore.clear();
//     if (response.statusCode == 200) {
//       var notes = json.decode(response.body);
//       for (var noteJson in notes['home_store']) {
//         homeStore.add(HomeStore.fromJson(noteJson));
//       }
//     }
//     return homeStore;
//   }
  
//   Future fetchBestSales() async {
//     var response = await http.get(Uri.https('run.mocky.io', '/v3/654bd15e-b121-49ba-a588-960956b15175'));
//     List<BestSeller> bestSale = [];
//     bestSale.clear();
//     if (response.statusCode == 200) {
//       var notes = json.decode(response.body);
//       for (var dataJson in notes['best_seller']) {
//         bestSale.add(BestSeller.fromJson(dataJson));
//       }
//     }
//     return bestSale;
//   }

//   Future fetchCartData() async {
//     var response = await http.get(Uri.https('run.mocky.io', '/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149'));
//     List<Cart> products = [];
//     cartData.clear();
//     if (response.statusCode == 200) {
//       var notes = json.decode(response.body);
//       products.add(Cart.fromJson(notes));
//     }
//     return products;
//   }
  
//   @override
//   void initState() {
//     super.initState();
//     selectedIndex = 0;    

//     fetchBestSales().then((value) {
//       bestSales.clear();
//       bestSales.addAll(value);
//     });
//     fetchHotSales().then((value) {
//       hotSales.clear();
//       hotSales.addAll(value);
//     });
//     fetchCartData().then((value) {
//       cartData.clear();
//       cartData.addAll(value);
//     });
//     node = FocusNode();
//   }

//   @override
//   void dispose() {
//     node.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//     Widget buildImage(String urlImage, int index) => ClipRRect(
//       borderRadius: BorderRadius.circular(15),
//       // child: Image(image: NetworkImage(urlImage),fit: BoxFit.cover)
//       child: Stack(
//         alignment: Alignment.topLeft,
        
//         children: <Widget>[
//           Container(
//             alignment: Alignment.center,
//             child: Image.network(
//               urlImage,
//               height: 250,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           (hotSales[index].isNew == true)
//             ? Container(
//               padding: const EdgeInsets.all(20),
//               child: const CircleAvatar(
//                 backgroundColor: AppColors.contrastColor,
//                 child: Text(
//                   'New',
//                   style: TextStyle(
//                     color: AppColors.fillColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12
//                   ),
//                 ),
//               ),
//             )
//             : const Icon(
//                 Icons.favorite_outline,
//                 color: Colors.transparent,
//               ),
//           Container(
//             padding: const EdgeInsets.only(left: 20, top: 70),
//             alignment: Alignment.centerLeft,
//             child: Column(
//               children: [
//                 Text(
//                   hotSales[index].title,
//                   style: const TextStyle(
//                     color: AppColors.fillColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25
//                   ),
//                 ),
//                 Text(
//                   hotSales[index].subtitle,
//                   style: const TextStyle(
//                     color: AppColors.fillColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 11
//                   ),
//                 ),
//                 const Spacer(),
//                 TextButton(
//                   style: TextButton.styleFrom(                    
//                     backgroundColor: AppColors.fillColor,
//                     padding: const EdgeInsets.only(left: 40, right: 40),
//                   ),
//                   onPressed: null,
//                   child: const Text(
//                     'Buy now!',
//                     style: TextStyle(
//                       color: AppColors.secondaryColor,
//                       fontSize: 11,
//                       fontWeight: FontWeight.bold
//                     ),
//                   ),
//                 ),
//                 const Spacer(),
//               ],
//             )
//           ),
//         ],
//       ),
//     );
    
//     Widget customRadioButton(int index) {
//       return GestureDetector(
//         onTap: (() {
//           setState(() {
//             selectedIndex = index;
//           });
//         }),
//         child: Container(
//           width: 75,
//           margin: const EdgeInsets.only(left: 20),
//           child: Column(
//             children: <Widget>[
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(100),
//                 child: Container(
//                   width: 71,
//                   height: 71,
//                   color: (selectedIndex == index) ? AppColors.contrastColor : AppColors.fillColor,
//                   child: Icon(
//                     category[index].icon,
//                     color: (selectedIndex == index) ? AppColors.fillColor : AppColors.subColor
//                   ),
//                 ),
//               ),
//               const Padding(padding: EdgeInsets.only(top: 10)),
//               Text(
//                 category[index].name,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: (selectedIndex == index) ? AppColors.contrastColor : AppColors.secondaryColor
//                 ),
//                 overflow: TextOverflow.fade,
//                 maxLines: 1,
//                 softWrap: false
//               )
//             ],
//           ),
//         )
//       );
//     }
    
//     return GestureDetector(
//       onTap: (() {
//         node.unfocus();
//       }),
//       child: Scaffold(
//         body: ListView(
//           children: [
//             Row(
//               children: [
//                 const Spacer(flex: 2),
//                 const Icon(
//                   Icons.location_on_outlined,
//                   color: AppColors.contrastColor,
//                   size: 20,
//                 ),
//                 const Text(
//                   'Zihuatanejo, Gro',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: AppColors.secondaryColor
//                   ),
//                   overflow: TextOverflow.fade,
//                   maxLines: 1,
//                   softWrap: false,
//                 ),
//                 const Icon(
//                   Icons.keyboard_arrow_down_outlined,
//                   color: AppColors.subColor
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   icon: const Icon(Icons.filter_alt_outlined, color: AppColors.secondaryColor),
//                     iconSize: 25,
//                     splashRadius: 25,
//                     onPressed: (){
//                       log('filter');
//                     },
//                 )
//               ],
//             ),
//             Row(
//               children: const [
//                 Spacer(),
//                 Text(
//                   'Select Category',
//                   style: TextStyle(
//                     fontSize: 25,
//                     color:AppColors.secondaryColor,
//                     fontWeight: FontWeight.bold
//                   ),
//                   overflow: TextOverflow.fade,
//                   maxLines: 1,
//                   softWrap: false,
//                 ),
//                 Spacer(
//                   flex: 6,
//                 ),
//                 Text(
//                   'view all',
//                   style: TextStyle(fontSize: 15, color: AppColors.contrastColor),
//                   overflow: TextOverflow.fade,
//                   maxLines: 1,
//                   softWrap: false,
//                 ),
//                 Spacer(),
//               ],
//             ),
//             SizedBox(
//               height: 150,
//               child: ListView(
//                 padding: const EdgeInsets.only(top: 20, left: 0, right: 8, bottom: 0),
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   customRadioButton(0),
//                   customRadioButton(1),
//                   customRadioButton(2),
//                   customRadioButton(3),
//                   customRadioButton(4)
//                 ],
//               )
//             ),
//             Row(
//               children: [
//                 const Spacer(flex: 3),
//                 SizedBox(
//                   width: 300,
//                   height: 45,
//                   child: TextField(
//                     focusNode: node,
//                     decoration: InputDecoration(
//                       labelText: "Search",
//                       labelStyle: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: 'Mark Pro',
//                       ),
//                       prefixIcon: const Icon(
//                         Icons.search,
//                         color: AppColors.contrastColor
//                       ),
//                       filled: true,
//                       fillColor: AppColors.fillColor,
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: const BorderSide(color: AppColors.contrastColor, width: 1.0),
//                       ),
//                       enabledBorder: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(100)),
//                         borderSide: BorderSide(color: AppColors.fillColor, width: 1.0),
//                       ),
                      
//                     ),
//                   ),
//                 ),
//                 const Spacer(),
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundColor: AppColors.contrastColor,
//                   child: IconButton(
//                     icon: const Icon(Icons.qr_code, color: AppColors.fillColor),
//                       iconSize: 25,
//                       splashRadius: 25,
//                       onPressed: (){
//                         log('qr');
//                       },
//                   ),
//                 ),
//                 const Spacer(flex: 3),
//               ],
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Row(
//               children: const [
//                 Spacer(),
//                 Text(
//                   'Hot Sales',
//                   style: TextStyle(
//                     fontSize: 25,
//                     color:AppColors.secondaryColor,
//                     fontWeight: FontWeight.bold
//                   ),
//                   overflow: TextOverflow.fade,
//                   maxLines: 1,
//                   softWrap: false,
//                 ),
//                 Spacer(
//                   flex: 6,
//                 ),
//                 Text(
//                   'see more',
//                   style: TextStyle(fontSize: 15, color: AppColors.contrastColor),
//                   overflow: TextOverflow.fade,
//                   maxLines: 1,
//                   softWrap: false,
//                 ),
//                 Spacer(),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             FutureBuilder(
//               future: fetchHotSales(),
//               builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (hotSales.isEmpty) {
//                   hotSales.addAll(snapshot.data);
//                 }
//                 if (cartData.isEmpty) {
//                   cartData.addAll(snapshot.data);
//                 }
//                 if (snapshot.hasData) {
//                   return SizedBox(
//                     height: 210,
//                     child: Stack(
//                       children: <Widget>[
//                         CarouselSlider.builder(
//                           itemCount: hotSales.length,
//                           itemBuilder: ((context, index, realIndex) {
//                             final urlImage = hotSales[index].picture;
//                             return buildImage(urlImage, index);
//                           }),
//                           options: CarouselOptions(
//                             enlargeCenterPage: true,
//                             aspectRatio: 2.0,
//                             viewportFraction: 0.9,
//                             height: 200,
//                           )
//                         ),
//                       ]
//                     )
//                   );
//                 }
//                 return const Center(child: Text("no info"));
//               },
//             ),
//             Row(
//               children: const [
//                 Spacer(),
//                 Text(
//                   'Best seller',
//                   style: TextStyle(
//                     fontSize: 25,
//                     color:AppColors.secondaryColor,
//                     fontWeight: FontWeight.bold
//                   ),
//                   overflow: TextOverflow.fade,
//                   maxLines: 1,
//                   softWrap: false,
//                 ),
//                 Spacer(
//                   flex: 6,
//                 ),
//                 Text(
//                   'see more',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontFamily: 'Mark Pro',
//                     color: AppColors.contrastColor
//                   ),
//                   overflow: TextOverflow.fade,
//                   maxLines: 1,
//                   softWrap: false,
//                 ),
//                 Spacer(),
//               ],
//             ),
//             FutureBuilder(
//               future: fetchBestSales(),
//               builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (bestSales.isEmpty) {
//                   bestSales.addAll(snapshot.data);
//                 }
//                 if (snapshot.hasData) {
//                   bs.add(bestSales[0]);
//                   bs.add(bestSales[2]);
//                   return GestureDetector(
//                     child: SizedBox(
//                       child: GridView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 5.0,
//                           mainAxisSpacing: 5.0,
//                         ),
//                         padding: const EdgeInsets.only(top: 10, right: 10, bottom: 8),
//                         itemCount: bs.length,
//                         itemBuilder: (BuildContext context, int index) {
//                             return ClipRRect(
//                               child: Container(
//                                 width: 170,
//                                 margin: const EdgeInsets.only(left: 20, right: 10),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: AppColors.fillColor,
//                                 ),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Stack(
//                                       alignment: Alignment.topRight,
//                                       children: <Widget>[
//                                         // Image(
//                                         //     fit: BoxFit.fitHeight,
//                                         //     height: 150,
//                                         //     width: 150,
//                                         //     image: NetworkImage(bestSales[index].picture),
//                                         //   ),
//                                         CachedNetworkImage(
//                                           imageUrl: bs[index].picture,
//                                           height: MediaQuery.of(context).size.height * 0.18,
//                                           width: 150,
//                                           fit: BoxFit.fitHeight,
//                                         ),
//                                         CircleAvatar(
//                                           radius: 15,
//                                           backgroundColor: AppColors.fillColor,
//                                           child: IconButton(
//                                             iconSize: 15,
//                                             splashRadius: 15,
//                                             icon: (bs[index].isFavorites == true)
//                                             ? const Icon(
//                                                 Icons.favorite_outlined,
//                                                 color: AppColors.contrastColor,
//                                               )
//                                             : const Icon(
//                                                 Icons.favorite_outline,
//                                                 color: AppColors.contrastColor,
//                                               ),
//                                             onPressed: () {
//                                               if (bs[index].isFavorites == false) {
//                                                 setState(() {
//                                                   bs[index].isFavorites = true;
//                                                 });
//                                               } else {
//                                                 setState(() {
//                                                   bs[index].isFavorites = false;
//                                                 });
//                                               }
//                                               log(bs[index].isFavorites.toString());
//                                             },
//                                           ),
//                                         ),
//                                       ]
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Spacer(
//                                           flex: 2,
//                                         ),
//                                         Text('\$${bs[index].discountPrice}',
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             color: AppColors.secondaryColor
//                                           ),
//                                           overflow: TextOverflow.fade,
//                                           maxLines: 1,
//                                           softWrap: false,
//                                           textAlign: TextAlign.left,
//                                         ),
//                                         const Spacer(),
//                                         Text('\$${bs[index].priceWithoutDiscount}',
//                                           style: const TextStyle(
//                                             fontSize: 11,
//                                             color: AppColors.priceColor,
//                                             decoration: TextDecoration.lineThrough
//                                           ),
//                                           overflow: TextOverflow.fade,
//                                           maxLines: 1,
//                                           softWrap: false,
//                                           textAlign: TextAlign.left,
//                                         ),
//                                         const Spacer(
//                                           flex: 4,
//                                         ),
//                                       ],
//                                     ),
//                                     Text(
//                                       bs[index].title,
//                                       style: const TextStyle(
//                                         fontSize: 10,
//                                         color: AppColors.secondaryColor
//                                       ),
//                                       overflow: TextOverflow.fade,
//                                       maxLines: 1,
//                                       softWrap: false,
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
                          
//                         }
//                       )
                      
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const MyItemPage()),
//                       );
//                     },
//                   );
//                 }
//                 return const Center(child: Text("no info"));
//               },
//             )
//           ]
//         ),
//         bottomNavigationBar: Container(
//           height: 70,
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(15),
//               topLeft: Radius.circular(15), 
//             ),
//             color: AppColors.secondaryColor,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(5),
//             child: BottomNavigationBar(
//               backgroundColor: AppColors.secondaryColor,
//               iconSize: 24,
//               items: [
//                 BottomNavigationBarItem(
//                   backgroundColor: AppColors.secondaryColor,
//                   label: '',
//                   icon: Stack(
//                     children:  <Widget>[
//                       Container(
//                         width: 75,
//                         margin: const EdgeInsets.only(top: 10),
//                         child: Row(children: const [
//                           Icon(Icons.brightness_1, size: 11,),
//                           Spacer(),
//                           Text('Explorer', style: TextStyle(color: AppColors.fillColor, fontWeight: FontWeight.bold),)
//                         ],),
//                       ),
                        
//                     ]
//                   )
//                 ),
//                 BottomNavigationBarItem(
//                   label: 'Cart',
//                   icon: Stack(
//                     children: <Widget>[
//                       const SizedBox(
//                         width: 50,
//                         height: 25,
//                         // color: Colors.red,
//                         child: Icon(Icons.shopping_bag_outlined, size: 25,)),
//                       (cartData.isEmpty == true)
//                         ? Positioned(  // draw a red marble
//                           top: 0.0,
//                           right: 5.0,
//                           child: Container(
//                             height: 15,
//                             width: 15,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: AppColors.contrastColor,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 '2',
//                                 style: const TextStyle(
//                                   color: AppColors.fillColor,
//                                   fontSize: 13,
//                                 ),
//                               )
//                             )
//                           )
//                           // Icon(Icons.brightness_1,
//                           //   size: 8.0, 
//                           //   color: Colors.redAccent
//                           // ),
//                         )
//                         : const Text('')
//                     ]
//                   ),
//                 ),
//                 const BottomNavigationBarItem(
//                   label: 'Favorites',
//                   icon: Icon(Icons.favorite_outline, size: 25,)
//                 ),
//                 const BottomNavigationBarItem(
//                   label: 'Account',
//                   icon: Icon(Icons.person, size: 25,)
//                 ),
//               ],
//               onTap: ((value) {
//                 if (value == 1) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const MyCart()),
//                   );
//                 }
//               }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }