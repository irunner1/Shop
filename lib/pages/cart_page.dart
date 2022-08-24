import 'dart:developer';

import 'package:flutter/material.dart';
import '../helpers/colors.dart';
import '../helpers/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
List<Cart> cartData = [];
  
  Future fetchCartData() async {
    var response = await http.get(Uri.https('run.mocky.io', '/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149'));
    List<Cart> products = [];
    if (response.statusCode == 200) {
      var notes = json.decode(response.body);
      products.add(Cart.fromJson(notes));
      log(products.length.toString());
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  Navigator.pop(context, 0);
                },
              ),
              const Spacer(flex: 3),
              const Text(
                'Add address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor
                ),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
              // const Spacer(flex: 2),
              const SizedBox(width: 10,),
              InkWell(
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.contrastColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.location_on_outlined, color: AppColors.fillColor),
                ),
                onTap: () {},
              ),
              const Spacer(),
            ],
          ),
          // const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.only(top: 50, left: 45),
            child: const Text(
              'My Cart',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: fetchCartData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (cartData.isEmpty) {
                cartData.addAll(snapshot.data);
              }
              if (cartData.isNotEmpty) {
                return Container(
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
                    color: AppColors.secondaryColor,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 380,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 8, left: 0, right: 8, bottom: 8),
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.only(bottom: 45, left: 20, right: 10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      cartData[0].products[index].image,
                                      fit: BoxFit.fitHeight,
                                      width: 105,
                                      height: 105,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 180,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartData[0].products[index].title,
                                          style: const TextStyle(
                                            color: AppColors.fillColor,  
                                            fontSize: 20,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          softWrap: false
                                        ),
                                        // const Spacer(),
                                        Text(
                                          '\$${cartData[0].products[index].price}.00',
                                          style: const TextStyle(
                                            color: AppColors.contrastColor,
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: AppColors.cartColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      children: const [
                                        Icon(
                                          Icons.remove, 
                                          color: AppColors.fillColor
                                        ),
                                        Text(
                                          '1',
                                          style: TextStyle(
                                            color: AppColors.fillColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Icon(
                                          Icons.add,
                                          color: AppColors.fillColor,
                                        )
                                      ]
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Icon(Icons.delete, color: AppColors.fillColor)
                                  ),
                                ],
                              ),
                            );
                          }
                        )
                      ),
                      const Divider(
                        height: 1,
                        thickness: 2,
                        indent: 2,
                        endIndent: 2,
                        color: AppColors.dividerColor,  
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      color: AppColors.fillColor,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Delivery',
                                    style: TextStyle(
                                      color: AppColors.fillColor,
                                      fontSize: 15
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.only(right: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$${cartData[0].totalPrice} us',
                                    style: const TextStyle(
                                      color: AppColors.fillColor,
                                      fontSize: 20
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    cartData[0].delivery,
                                    style: const TextStyle(
                                      color: AppColors.fillColor,
                                      fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 2,
                        endIndent: 2,
                        color: AppColors.dividerColor,  
                      ),
                      Container(
                        height: 80,
                        width: 500,
                        padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 20),
                        child: TextButton(
                          style: TextButton.styleFrom(                    
                            backgroundColor: AppColors.contrastColor,
                            padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
                          ),
                          onPressed: null,
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                              color: AppColors.fillColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                );
              }
              return const Center(child: Text("no info"));
            },
          )
        ]
      ),
    );
  }
}