import 'package:flutter/material.dart';
import '../helpers/colors.dart';
import '../helpers/data.dart';


class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

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
                  Navigator.pop(context);
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
                        padding: const EdgeInsets.only(bottom: 45, left: 20, right: 20),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                'https://sun9-65.userapi.com/impg/oKSeIVJyG9edHHpm1NKAt8KQPjynG8qSODdA0g/RWHQVLXd1Gc.jpg?size=187x168&quality=96&sign=6d8474ff24eb042d21d69bdf5b32dfa9&type=album',
                                fit: BoxFit.cover,
                                width: 105,
                                height: 105,
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: const [
                                Text(
                                  'data',
                                  style: TextStyle(
                                    color: AppColors.fillColor,
                                    fontSize: 20
                                  ),
                                ),
                                Text(
                                  '\$data.00',
                                  style: TextStyle(
                                    color: AppColors.contrastColor,
                                    fontSize: 20,
                                  )
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: 30,
                              decoration: BoxDecoration(
                                color: AppColors.cartColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.remove, 
                                    color: AppColors.fillColor
                                  ),
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      color: AppColors.fillColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.add,
                                    color: AppColors.fillColor,
                                  )
                                ]
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: const Icon(Icons.delete, color: AppColors.fillColor,)
                            ),
                          ],
                        ),
                      );
                    }
                  )
                ),
                const Divider(
                  height: 2,
                  thickness: 1,
                  indent: 2,
                  endIndent: 2,
                  color: Colors.white,
                ),
                Container(
                  // height: 200,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
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
                      Column(
                        children: [
                          Text(
                            'data',
                            style: TextStyle(
                              color: AppColors.fillColor,
                              fontSize: 20
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'data',
                            style: TextStyle(
                              color: AppColors.fillColor,
                              fontSize: 20
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                 const Divider(
                  height: 3,
                  thickness: 1,
                  indent: 2,
                  endIndent: 2,
                  color: Colors.white,
                ),
                Container(
                  height: 80,
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
          )
        ]
      ),
    );
  }
}