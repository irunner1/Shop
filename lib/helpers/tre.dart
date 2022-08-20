
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
    required this.isNew,
    required this.isBuy
  });

  factory HomeStore.fromJson(Map <String, dynamic> json) => HomeStore(
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    picture: json['picture'] as String,
    isBuy: json['is_buy'] as bool,
    isNew: json['is_new'] as bool,
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

