import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_utils.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange { sale, normal, expensive }

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  // JSON에서 RestaurantModel 객체로 변환하는 팩토리 생성자
  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  // RestaurantModel 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
//factory constructor를 사용한 restaurant정보 api로 수신한 데이터를 변환
  // factory RestaurantModel.fromJson({required Map<String, dynamic> json}) {
  //   //암기!!! json 데이터를 처리할 경우 데이터 형식은 Map<String, dynamic>으로 처리
  //   return RestaurantModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: json['thumbUrl'],
  //     tags: List<String>.from(json['tags']),
  //     priceRange: RestaurantPriceRange.values
  //         .firstWhere((element) => element.name == json['priceRange']),
  //     ratings: json['ratings'],
  //     ratingsCount: json['ratingsCount'],
  //     deliveryTime: json['deliveryTime'],
  //     deliveryFee: json['deliveryFee'],
  //   );
  // }
}
