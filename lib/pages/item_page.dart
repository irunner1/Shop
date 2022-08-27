import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../helpers/colors.dart';
import '../helpers/data.dart';
import 'dart:convert';
import 'package:app/assets/MyIcons.dart';


class MyItemPage extends StatefulWidget {
  const MyItemPage({Key? key}) : super(key: key);

  @override
  State<MyItemPage> createState() => _MyItemPageState();
}

class _MyItemPageState extends State<MyItemPage> {
  late int selectedIndex;
  late int selectedTextIndex;

  List<ProductDetails> productDetails = [];
  
  Future fetchProductDetails() async {
    var response = await http.get(Uri.https('run.mocky.io', '/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5'));
    List<ProductDetails> products = [];
    if (response.statusCode == 200) {
      var notes = json.decode(response.body);
      products.add(ProductDetails.fromJson(notes));
    }
    return products;
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;  
    selectedTextIndex = 0;  
  }

  @override
  Widget build(BuildContext context) {  
    Widget buildImage(String urlImage, int index) => ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );

    Widget colorRadioButton(int index) {
      return GestureDetector(
        onTap: (() {
          setState(() {
            selectedIndex = index;
          });
        }),
        child: CircleAvatar(
          backgroundColor: hexToColor(productDetails[0].color[index]),
          child: (selectedIndex == index) ? const Icon(Icons.check, color: AppColors.fillColor,) : const Text(''),
        ),
      );
    }

    Widget textRadioButton(int index, String text) {
      return GestureDetector(
        onTap: (() {
          setState(() {
            selectedTextIndex = index;
          });
        }),
        child: Container(
          width: 70,
          height: 30,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: (selectedTextIndex == index) ? AppColors.contrastColor : AppColors.fillColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Text(
              '$text gb',
              style: TextStyle(
                color: (selectedTextIndex == index) ? AppColors.fillColor : AppColors.subColor,
                fontWeight: FontWeight.bold,
              ),
              )
            )
        ),
      );
    }

    return Scaffold(
      body: FutureBuilder(
        future: fetchProductDetails(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (productDetails.isEmpty) {
            productDetails.addAll(snapshot.data);
          }
          if (productDetails.isNotEmpty) {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      child: Container(
                        height: 35,
                        width: 35,
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back_ios, color: AppColors.fillColor),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(flex: 2),
                    const Text(
                      'Product Details',
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
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.contrastColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.shopping_bag_outlined, color: AppColors.fillColor),
                      ),
                      onTap: () {},
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 250,
                  child: Stack(
                    children: <Widget>[
                      CarouselSlider.builder(
                        itemCount: 2,
                        itemBuilder: ((context, index, realIndex) {
                          final urlImage = productDetails[0].images[index];
                          return buildImage(urlImage, index);
                        }),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          // aspectRatio: 2.0,
                          // autoPlay: true,
                          viewportFraction: 0.7,
                          height: 300
                        )
                      )
                    ]
                  )
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(top: 15),
                  margin: const EdgeInsets.only(top: 15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15), 
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                    color: AppColors.fillColor,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          const Spacer(flex: 2),
                          Text(
                            productDetails[0].title, 
                            style: const TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const Spacer(flex: 4),
                          InkWell(
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.favorite_outline, color: AppColors.fillColor, size: 18,),
                            ),
                            onTap: () {},
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                        child: Row(
                          children: [
                            const Spacer(),
                            RatingBar.builder(
                              itemSize: 20,
                              initialRating: productDetails[0].rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                // print(rating);
                              },
                            ),
                            const Spacer(flex: 6,),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 140,
                        child: DefaultTabController(
                          length: 3,
                          child: Column(
                            children: [
                              TabBar(
                                labelColor: AppColors.secondaryColor,
                                indicatorPadding: const EdgeInsets.all(10),
                                indicatorWeight: 5,
                                indicator: MaterialIndicator(
                                  height: 5,
                                  topLeftRadius: 8,
                                  bottomLeftRadius: 8,
                                  topRightRadius: 8,
                                  bottomRightRadius: 8,
                                  horizontalPadding: 10,
                                  color: AppColors.contrastColor,
                                  tabPosition: TabPosition.bottom,
                                ),
                                tabs: const [
                                  Tab(
                                    child: Text(
                                      'Shop',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Text('Details', style: TextStyle(fontSize: 18),),
                                  ),
                                  Tab(
                                    child: Text('Features', style: TextStyle(fontSize: 18),),
                                  )
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    ListView(
                                      padding: const EdgeInsets.only(top: 10, left: 0, right: 8, bottom: 0),
                                      scrollDirection: Axis.horizontal,
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: [
                                        Container(
                                          width: 75,
                                          margin: const EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: <Widget>[
                                              const Icon(
                                                Icons.memory,
                                                color: AppColors.iconColor,
                                                size: 30,
                                              ),
                                              const Padding(padding: EdgeInsets.only(top: 5)),
                                              Text(
                                                productDetails[0].cpu,
                                                style: const TextStyle(fontSize: 12, color: AppColors.iconColor),
                                              ),
                                            ],
                                          )
                                        ),
                                        Container(
                                          width: 75,
                                          margin: const EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: <Widget>[
                                              const Icon(
                                                Icons.camera_alt_outlined,
                                                color: AppColors.iconColor,
                                                size: 30,
                                              ),
                                              const Padding(padding: EdgeInsets.only(top: 5)),
                                              Text(
                                                productDetails[0].camera,
                                                style: const TextStyle(fontSize: 12, color: AppColors.iconColor),
                                              ),
                                            ],
                                          )
                                        ),
                                        Container(
                                          width: 75,
                                          margin: const EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: <Widget>[
                                              const Icon(
                                                MyIcons.memory,
                                                color: AppColors.iconColor,
                                                size: 30,
                                              ),
                                              const Padding(padding: EdgeInsets.only(top: 5)),
                                              Text(
                                                productDetails[0].ssd,
                                                style: const TextStyle(fontSize: 12, color: AppColors.iconColor),
                                              ),
                                            ],
                                          )
                                        ),
                                        Container(
                                          width: 75,
                                          margin: const EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: <Widget>[
                                              const Icon(
                                                Icons.sd_card_outlined,
                                                color: AppColors.iconColor,
                                                size: 30,
                                              ),
                                              const Padding(padding: EdgeInsets.only(top: 5)),
                                              Text(
                                                productDetails[0].sd,
                                                style: const TextStyle(fontSize: 12, color: AppColors.iconColor),
                                              ),
                                            ],
                                          )
                                        ),
                                      ],
                                    ),
                                    Container(color: Colors.white),
                                    Container(color: Colors.white),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(height: 30,),
                      Row(
                        children: const [
                          Spacer(),
                          Text(
                            'Select color and capacity',
                            style: TextStyle(color: AppColors.secondaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Spacer(flex: 3)
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Spacer(flex: 2),
                          colorRadioButton(0),
                          const Spacer(),
                          colorRadioButton(1),
                          const Spacer(flex: 2),
                          textRadioButton(0, productDetails[0].capacity[0]),
                          const Spacer(),
                          textRadioButton(1, productDetails[0].capacity[1]),
                          const Spacer(flex: 2),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: AppColors.contrastColor
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(                    
                            backgroundColor: AppColors.contrastColor,
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: null,
                          child: Text(
                            'Add to Cart \$${productDetails[0].price}',
                            style: const TextStyle(
                              color: AppColors.fillColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text("no info"));
        },
      )
    );
  }
}