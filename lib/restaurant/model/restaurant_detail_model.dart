import 'package:flutter_inf_app/restaurant/model/restaurant_model.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  //factory constructor를 사용한 RestaurantDetail정보 api로 수신한 데이터를 변환
  factory RestaurantDetailModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: json['thumbUrl'],
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values
          .firstWhere((element) => element.name == json['priceRange']),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      products: //json['product'] 로 못쓰고 RestaurantProductModel.fromJson으로 사용
          List<RestaurantProductModel>.from(
        json['products'].map(
          (e) => RestaurantProductModel.fromJson(json: e),
        ),
      ),
    );
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final int price;
  final String detail;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.detail,
  });

  factory RestaurantProductModel.fromJson(
      {required Map<String, dynamic> json}) {
    return RestaurantProductModel(
      id: json['id'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      price: json['price'],
      detail: json['detail'],
    );
  }
}
