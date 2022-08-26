import 'package:app/pages/cart_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/tmp_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../helpers/colors.dart';

class MyMain extends StatefulWidget {
  const MyMain({Key? key}) : super(key: key);

  @override
  State<MyMain> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyMain> {
  List pages = [
    const MyHomePage(),
    const MyCart()
  ];
  int navIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: pages[navIndex],
      body: MyTMP(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15), 
          ),
          color: AppColors.secondaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            backgroundColor: AppColors.secondaryColor,
            color: AppColors.fillColor,
            activeColor: AppColors.fillColor,
            tabBackgroundColor: AppColors.secondaryColor,
            gap: 8,
            iconSize: 24,
            duration: const Duration(milliseconds: 900),
            padding: const EdgeInsets.all(15),
            tabs: const [
              GButton(
                icon: Icons.brightness_1,
                iconSize: 15,
                text: 'Explorer',
              ),
              GButton(
                icon: Icons.shopping_bag_outlined,
                text: 'Cart',
                active: false,
              ),
              GButton(
                icon: Icons.favorite_outline,
                text: 'Favorites',
              ),
              GButton(
                icon: Icons.person,
                text: 'Account',
              ),
            ],
            selectedIndex: navIndex,
            onTabChange: (index) {
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyCart()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}