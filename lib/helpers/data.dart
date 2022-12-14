import 'package:flutter/material.dart';

class HomeStore {
  String title;
  String subtitle;
  String picture;
  bool isBuy;
  bool? isNew;

  HomeStore({
    required this.title,
    required this.subtitle,
    required this.picture,
    this.isNew,
    required this.isBuy
  });

  factory HomeStore.fromJson(Map <String, dynamic> json) => HomeStore(
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    picture: json['picture'] as String,
    isBuy: json['is_buy'] as bool,
    isNew: json['is_new'] as bool?,
  );
}

class BestSeller {
  String title;
  int priceWithoutDiscount;
  int discountPrice;
  String picture;
  bool isFavorites;

  BestSeller({
    required this.title,
    required this.priceWithoutDiscount,
    required this.discountPrice,
    required this.picture,
    required this.isFavorites,
  });

  factory BestSeller.fromJson(Map <String, dynamic> json) => BestSeller(
    title: json['title'] as String,
    priceWithoutDiscount: json['price_without_discount'] as int,
    discountPrice: json['discount_price'] as int,
    picture: json['picture'] as String,
    isFavorites: json['is_favorites'] as bool,
  );
}

class ProductDetails {
  String cpu;
  String camera;
  List<String> capacity;
  List<String> color;
  List<String> images;
  bool isFavorites;
  int price;
  double rating;
  String sd;
  String ssd;
  String title;

  ProductDetails({
    required this.cpu,
    required this.camera,
    required this.capacity,
    required this.color,
    required this.images,
    required this.isFavorites,
    required this.price,
    required this.rating,
    required this.sd,
    required this.ssd,
    required this.title,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    var colorFromJson = json['color'];
    List<String> colorList = colorFromJson.cast<String>();

    var capacityFromJson = json['capacity'];
    List<String> capacityList = capacityFromJson.cast<String>();

    var imagesFromJson = json['images'];
    List<String> imagesList = imagesFromJson.cast<String>();

    return ProductDetails(
      cpu: json['CPU'] as String,
      camera: json['camera'] as String,
      capacity: capacityList,
      color: colorList,
      images: imagesList,
      isFavorites: json['isFavorites'] as bool,
      price: json['price'] as int,
      rating: json['rating'] as double,
      sd: json['sd'] as String,
      ssd: json['ssd'] as String,
      title: json['title'] as String
    );
  }
}

class Cart {
  List<Basket> products;
  String delivery;
  int totalPrice;

  Cart ({
    required this.products,
    required this.delivery,
    required this.totalPrice
  });

  factory Cart.fromJson(Map <String, dynamic> json) {
    var list = json['basket'] as List;
    List<Basket> data = list.map((i) => Basket.fromJson(i)).toList();

    return Cart(
      products: data,
      delivery: json['delivery'] as String,
      totalPrice: json['total'] as int
    );
  }
}

class Basket {
  String image;
  int price;
  String title;

  Basket({
    required this.image,
    required this.price,
    required this.title
  });

   factory Basket.fromJson(Map <String, dynamic> json) => Basket(
      image: json['images'] as String,
      price: json['price'] as int,
      title: json['title'] as String,
   );
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
