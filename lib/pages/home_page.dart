import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/pages/item_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../helpers/colors.dart';
import '../helpers/item.dart';
import '../helpers/data.dart';
import 'dart:convert';
import 'package:app/pages/splash_screen.dart';
import 'package:app/pages/cart_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FocusNode node;
  late int selectedIndex;

  String? selectedBrandValue;
  String? selectedPriceValue;
  String? selectedSizeValue;

  final List<String> filterItems = [
    'Samsung',
    'Xiaomi',
    'Motorolla',
    'Iphone'
  ];
  final List<String> filterPrice = [
    '300\$',
    '500\$',
    '1000\$',
    '10000\$'
  ];
  final List<String> filterSize = [
    '4 inches',
    '5 inches',
    '6 inches',
  ];

  List<HomeStore> hotSales = [];
  List<BestSeller> bestSales = [];
  List<Cart> cartData = [];

  Future fetchHotSales() async {
    var response = await http.get(Uri.https('run.mocky.io', '/v3/654bd15e-b121-49ba-a588-960956b15175'));
    List<HomeStore> homeStore = [];
    homeStore.clear();
    if (response.statusCode == 200) {
      var notes = json.decode(response.body);
      for (var noteJson in notes['home_store']) {
        homeStore.add(HomeStore.fromJson(noteJson));
      }
    }
    return homeStore;
  }
  Future fetchBestSales() async {
    var response = await http.get(Uri.https('run.mocky.io', '/v3/654bd15e-b121-49ba-a588-960956b15175'));
    List<BestSeller> bestSale = [];
    bestSale.clear();
    if (response.statusCode == 200) {
      var notes = json.decode(response.body);
      for (var dataJson in notes['best_seller']) {
        bestSale.add(BestSeller.fromJson(dataJson));
      }
    }
    return bestSale;
  }
  Future fetchCartData() async {
    var response = await http.get(Uri.https('run.mocky.io', '/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149'));
    List<Cart> products = [];
    if (response.statusCode == 200) {
      var notes = json.decode(response.body);
      products.add(Cart.fromJson(notes));
    }
    return products;
  }

  @override
  void initState() {
    super.initState();
    node = FocusNode();
    selectedIndex = 0;    
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget buildImage(String urlImage, int index) => ClipRRect(
      borderRadius: BorderRadius.circular(15),
      // child: Image(image: NetworkImage(urlImage),fit: BoxFit.cover)
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.network(
              urlImage,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          (hotSales[index].isNew == true)
            ? Container(
              padding: const EdgeInsets.all(20),
              child: const CircleAvatar(
                backgroundColor: AppColors.contrastColor,
                child: Text(
                  'New',
                  style: TextStyle(
                    color: AppColors.fillColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                  ),
                ),
              ),
            )
            : const Icon(
                Icons.favorite_outline,
                color: Colors.transparent,
              ),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 70),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Text(
                  hotSales[index].title,
                  style: const TextStyle(
                    color: AppColors.fillColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
                ),
                Text(
                  hotSales[index].subtitle,
                  style: const TextStyle(
                    color: AppColors.fillColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(                    
                    backgroundColor: AppColors.fillColor,
                    padding: const EdgeInsets.only(left: 40, right: 40),
                  ),
                  onPressed: null,
                  child: const Text(
                    'Buy now!',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const Spacer(),
              ],
            )
          ),
        ],
      ),
    );

    Widget customRadioButton(int index) {
      return GestureDetector(
        onTap: (() {
          setState(() {
            selectedIndex = index;
          });
        }),
        child: Container(
          width: 75,
          margin: const EdgeInsets.only(left: 20),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 71,
                  height: 71,
                  color: (selectedIndex == index) ? AppColors.contrastColor : AppColors.fillColor,
                  child: Icon(
                    category[index].icon,
                    color: (selectedIndex == index) ? AppColors.fillColor : AppColors.subColor
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                category[index].name,
                style: TextStyle(
                  fontSize: 12,
                  color: (selectedIndex == index) ? AppColors.contrastColor : AppColors.secondaryColor
                ),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false
              )
            ],
          ),
        )
      );
    }

    Widget customDropDown(List<String> items, String? selval, String title) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items.map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )).toList(),
            value: selval,
            onChanged: (value) {
              setState(() {
                selval = value as String;
              });
            },
            icon: const Icon(
              Icons.keyboard_arrow_down
            ),
            iconOnClick: const Icon(
              Icons.keyboard_arrow_up
            ),
            iconSize: 30,
            iconEnabledColor: AppColors.filterColor,
            iconDisabledColor: AppColors.filterColor,
            buttonHeight: 35,
            buttonWidth: 300,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: AppColors.filterColor,
              ),
              color: AppColors.fillColor,
            ),
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownWidth: 300,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.fillColor,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
          ),
        );
        }
      );
    }
    
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        fetchBestSales(),
        fetchHotSales(),
        fetchCartData(),
      ]),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
          // return const Center(child: CircularProgressIndicator());
          return const MySplash();
        }
        if (bestSales.isEmpty) {
          bestSales.addAll(snapshot.data[0]);
        }
        if (hotSales.isEmpty) {
          hotSales.addAll(snapshot.data[1]);
        }
        if (cartData.isEmpty) {
          cartData.addAll(snapshot.data[2]);
        }
        if (bestSales.isNotEmpty) {
          return GestureDetector(
            onTap: (() {
              node.unfocus();
            }),
            child: Scaffold(
              body: ListView(
                children: [
                  Row(
                    children: [
                      const Spacer(flex: 2),
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.contrastColor,
                        size: 20,
                      ),
                      const Text(
                        'Zihuatanejo, Gro',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.secondaryColor
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.subColor
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.filter_alt_outlined, color: AppColors.secondaryColor),
                        iconSize: 25,
                        splashRadius: 25,
                        onPressed: (){
                          showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 300,
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        const Spacer(flex: 3,),
                                        InkWell(
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: AppColors.secondaryColor,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Icon(Icons.close, color: AppColors.fillColor),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        const Spacer(flex: 2),
                                        const Text(
                                          'Filter options',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.secondaryColor
                                          ),
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                        ),
                                        const Spacer(flex: 2),
                                        InkWell(
                                          child: Container(
                                            height: 35,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: AppColors.contrastColor,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Done',
                                                style: TextStyle(
                                                  color: AppColors.fillColor,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            )
                                          ),
                                          onTap: () {
                                            // setState(() {
                                              
                                            // });
                                            Navigator.pop(context);
                                          },
                                        ),
                                        const Spacer(flex: 3,),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.only(left: 50, top: 10, bottom: 5),
                                      child: const Text(
                                        'Brand',
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    customDropDown(filterItems, selectedBrandValue, 'Choose brand'),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.only(left: 50, top: 10, bottom: 5),
                                      child: const Text(
                                        'Price',
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    customDropDown(filterPrice, selectedPriceValue, 'Choose price'),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.only(left: 50, top: 10, bottom: 5),
                                      child: const Text(
                                        'Size',
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    customDropDown(filterSize, selectedSizeValue, '4.5 to 5.5 inches')
                                  ],
                                ),
                              );
                            }
                          );
                        },
                      )
                    ],
                  ),
                  Row(
                    children: const [
                      Spacer(),
                      Text(
                        'Select Category',
                        style: TextStyle(
                          fontSize: 25,
                          color:AppColors.secondaryColor,
                          fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      Spacer(
                        flex: 6,
                      ),
                      Text(
                        'view all',
                        style: TextStyle(fontSize: 15, color: AppColors.contrastColor),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      padding: const EdgeInsets.only(top: 20, left: 0, right: 8, bottom: 0),
                      scrollDirection: Axis.horizontal,
                      children: [
                        customRadioButton(0),
                        customRadioButton(1),
                        customRadioButton(2),
                        customRadioButton(3),
                        customRadioButton(4)
                      ],
                    )
                  ),
                  Row(
                    children: [
                      const Spacer(flex: 3),
                      SizedBox(
                        width: 300,
                        height: 45,
                        child: TextField(
                          focusNode: node,
                          decoration: InputDecoration(
                            labelText: "Search",
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Mark Pro',
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.contrastColor
                            ),
                            filled: true,
                            fillColor: AppColors.fillColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: AppColors.contrastColor, width: 1.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(color: AppColors.fillColor, width: 1.0),
                            ),
                            
                          ),
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.contrastColor,
                        child: IconButton(
                          icon: const Icon(Icons.qr_code, color: AppColors.fillColor),
                            iconSize: 25,
                            splashRadius: 25,
                            onPressed: (){
                              log('qr');
                            },
                        ),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: const [
                      Spacer(),
                      Text(
                        'Hot Sales',
                        style: TextStyle(
                          fontSize: 25,
                          color:AppColors.secondaryColor,
                          fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      Spacer(
                        flex: 6,
                      ),
                      Text(
                        'see more',
                        style: TextStyle(fontSize: 15, color: AppColors.contrastColor),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 210,
                    child: Stack(
                      children: <Widget>[
                        CarouselSlider.builder(
                          itemCount: hotSales.length,
                          itemBuilder: ((context, index, realIndex) {
                            final urlImage = hotSales[index].picture;
                            return buildImage(urlImage, index);
                          }),
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            viewportFraction: 0.9,
                            height: 200,
                          )
                        ),
                      ]
                    )
                  ),
                  Row(
                    children: const [
                      Spacer(),
                      Text(
                        'Best seller',
                        style: TextStyle(
                          fontSize: 25,
                          color:AppColors.secondaryColor,
                          fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      Spacer(
                        flex: 6,
                      ),
                      Text(
                        'see more',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Mark Pro',
                          color: AppColors.contrastColor
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      Spacer(),
                    ],
                  ),
                  GestureDetector(
                    child: SizedBox(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        padding: const EdgeInsets.only(top: 10, right: 10, bottom: 8),
                        itemCount: bestSales.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ClipRRect(
                            child: Container(
                              width: 170,
                              margin: const EdgeInsets.only(left: 20, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.fillColor,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: <Widget>[
                                      // Image(
                                      //   fit: BoxFit.fitHeight,
                                      //   height: 150,
                                      //   width: 150,
                                      //   image: NetworkImage(bestSales[index].picture),
                                      // ),
                                      CachedNetworkImage(
                                        imageUrl: bestSales[index].picture,
                                        height: MediaQuery.of(context).size.height * 0.18,
                                        width: 150,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.priceColor,
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: AppColors.fillColor,
                                          child: IconButton(
                                            iconSize: 15,
                                            splashRadius: 15,
                                            icon: (bestSales[index].isFavorites == true)
                                            ? const Icon(
                                                Icons.favorite_outlined,
                                                color: AppColors.contrastColor,
                                              )
                                            : const Icon(
                                                Icons.favorite_outline,
                                                color: AppColors.contrastColor,
                                              ),
                                            onPressed: () {
                                              if (bestSales[index].isFavorites == false) {
                                                setState(() {
                                                  bestSales[index].isFavorites = true;
                                                });
                                              } 
                                              else {
                                                setState(() {
                                                  bestSales[index].isFavorites = false;
                                                });
                                              }
                                              log(bestSales[index].isFavorites.toString());
                                            },
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(
                                        flex: 2,
                                      ),
                                      Text('\$${bestSales[index].discountPrice}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.secondaryColor
                                        ),
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        textAlign: TextAlign.left,
                                      ),
                                      const Spacer(),
                                      Text('\$${bestSales[index].priceWithoutDiscount}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.priceColor,
                                          decoration: TextDecoration.lineThrough
                                        ),
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        textAlign: TextAlign.left,
                                      ),
                                      const Spacer(
                                        flex: 4,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    bestSales[index].title,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: AppColors.secondaryColor
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      )
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyItemPage()),
                      );
                    },
                  ),
                ]
              ),
              bottomNavigationBar: Container(
                height: 70,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15), 
                  ),
                  color: AppColors.secondaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: BottomNavigationBar(
                    backgroundColor: AppColors.secondaryColor,
                    iconSize: 24,
                    items: [
                      BottomNavigationBarItem(
                        backgroundColor: AppColors.secondaryColor,
                        label: '',
                        icon: Stack(
                          children:  <Widget>[
                            Container(
                              width: 75,
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(children: const [
                                Icon(Icons.brightness_1, size: 11,),
                                Spacer(),
                                Text('Explorer', style: TextStyle(color: AppColors.fillColor, fontWeight: FontWeight.bold),)
                              ],),
                            ),
                             
                          ]
                        )
                      ),
                      BottomNavigationBarItem(
                        label: 'Cart',
                        icon: Stack(
                          children: <Widget>[
                            const SizedBox(
                              width: 50,
                              height: 25,
                              // color: Colors.red,
                              child: Icon(Icons.shopping_bag_outlined, size: 25,)),
                            (cartData.isNotEmpty == true)
                              ? Positioned(  // draw a red marble
                                top: 0.0,
                                right: 5.0,
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.contrastColor,

                                  ),
                                  child: Center(
                                    child: Text(
                                      cartData[0].products.length.toString(),
                                      style: const TextStyle(
                                        color: AppColors.fillColor,
                                        fontSize: 13,
                                      ),
                                    )
                                  )
                                )
                                // Icon(Icons.brightness_1,
                                //   size: 8.0, 
                                //   color: Colors.redAccent
                                // ),
                              )
                              : const Text('')
                          ]
                        ),
                      ),
                      const BottomNavigationBarItem(
                        label: 'Favorites',
                        icon: Icon(Icons.favorite_outline, size: 25,)
                      ),
                      const BottomNavigationBarItem(
                        label: 'Account',
                        icon: Icon(Icons.person, size: 25,)
                      ),
                    ],
                    onTap: ((value) {
                      if (value == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyCart()),
                        );
                      }
                    }),
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(child: Text("no info"));
      },
    );
  }
}