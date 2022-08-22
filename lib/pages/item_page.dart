import 'package:flutter/material.dart';
import '../helpers/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';


class MyItemPage extends StatelessWidget {
  const MyItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabController _tabController;
    
    Widget buildImage(String urlImage, int index) => ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          Container(
            color: Colors.grey,
          )
          // Image.network(
          //   urlImage,
          //   fit: BoxFit.cover,
          // ),
          // Positioned(
          //   bottom: 100.0,
          //   left: 10.0,
          //   child: Container(
          //     child: Text('a', style: TextStyle(color: Colors.white),),
          //   )
          // )
        ],
      ),     
    );

    return Scaffold(
      body: ListView(
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
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.arrow_back_ios, color: AppColors.fillColor),
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
            height: 290,
            child: Stack(
              children: <Widget>[
                CarouselSlider.builder(
                  itemCount: 3,
                  itemBuilder: ((context, index, realIndex) {
                    final urlImage = 'hotSales[index].picture';
                    return buildImage(urlImage, index);
                  }),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    // aspectRatio: 2.0,
                    // autoPlay: true,
                    viewportFraction: 0.7
                  )
                )
              ]
            )
          ),
          Container(
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
                    const Spacer(flex: 2,),
                    Text(
                      'Galaxy Note 20 Ultra',
                      style: TextStyle(color: AppColors.secondaryColor, fontSize: 20),
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
                const SizedBox(height: 30),
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
                              ListView.builder(
                                padding: const EdgeInsets.only(top: 10, left: 0, right: 8, bottom: 0),
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 75,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      children: const <Widget>[
                                        Icon(
                                          Icons.camera,
                                          color: AppColors.iconColor,
                                          size: 30,
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 5)),

                                        Text(
                                          'a',
                                          style: TextStyle(fontSize: 12, color: AppColors.iconColor),
                                        ),
                                      ],
                                    )
                                  );
                                },
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
                    const Spacer(),
                    Text(
                      'Select color and capacity',
                      style: TextStyle(color: AppColors.secondaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(flex: 3)
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: const [
                    Spacer(),
                    CircleAvatar(backgroundColor: AppColors.contrastColor,),
                    Spacer(),
                    CircleAvatar(backgroundColor: AppColors.contrastColor,),
                    Spacer(flex: 2,),
                    Text('data'),
                    Spacer(),
                    Text('data'),
                    Spacer(flex: 2,),
                  ],
                ),
                SizedBox(height: 10,),
                TextButton(
                  style: TextButton.styleFrom(                    
                    backgroundColor: AppColors.contrastColor,
                    padding: EdgeInsets.all(10),
                    
                  ),
                  onPressed: null,
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: AppColors.fillColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}