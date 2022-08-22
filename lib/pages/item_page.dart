import 'package:flutter/material.dart';
import '../helpers/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyItemPage extends StatelessWidget {
  const MyItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
            height: 300,
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
              boxShadow: [BoxShadow(
                color: Colors.black12,
                spreadRadius: 5,
                blurRadius: 7,
              ),],
              color: AppColors.fillColor,
            ),
            child: Column(
              children: <Widget>[

                Row(
                  children: [
                    Spacer(),
                    Text('Galaxy Note 20 Ultra'),
                    Spacer(),
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
                    Spacer(),
                  ],
                ),
                SizedBox(
                height: 150,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20, left: 0, right: 8, bottom: 0),
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        width: 75,
                        margin: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              // borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.abc,
                                  color: AppColors.iconColor,
                                ),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            const Text('sdf',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.iconColor,
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false
                            )
                          ],
                        ),
                      ),
                      onTap: () {}
                    );
                  }
                ),
              ),
                Text('Select color and capacity')
              ],
            ),
          )
        ],
      ),
    );
  }
}