
class HomeStore {
  String title;
  String subtitle;
  String picture;
  bool isBuy;
  // bool isNew = false;

  HomeStore({
    required this.title,
    required this.subtitle,
    required this.picture,
    // required this.isNew,
    required this.isBuy
  });

  factory HomeStore.fromJson(Map <String, dynamic> json) => HomeStore(
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    picture: json['picture'] as String,
    isBuy: json['is_buy'] as bool,
    // isNew: json['is_new'] as bool,
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
  List<int> capacity;
  List<String> color;
  List<String> images;
  bool isFavorites;
  int price;
  String rating;
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

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    cpu: json['CPU'] as String,
    camera: json['camera'] as String,
    capacity: json['capacity'] as List<int>,
    color: json['color'] as List<String>,
    images: json['images'] as List<String>,
    isFavorites: json['isFavorites'] as bool,
    price: json['price'] as int,
    rating: json['rating'] as String,
    sd: json['sd'] as String,
    ssd: json['ssd'] as String,
    title: json['title'] as String
  );
}
