import 'package:flutter/material.dart';
import '../helpers/colors.dart';


class MySplash extends StatelessWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.contrastColor,
                ),
                height: 130,
                width: 130,
              ),
              Container(
                width: 180,
                margin: const EdgeInsets.only(left: 120),
                child: const Text(
                  'Ecommerce Concept',
                  style: TextStyle(
                    color: AppColors.fillColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              )
            ],
          )
        )
      )
    );
  }
}

