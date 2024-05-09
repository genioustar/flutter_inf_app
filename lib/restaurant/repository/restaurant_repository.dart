import 'package:dio/dio.dart'
    hide Headers; // Headers가 retrofit에서 이미 사용되고 있어서 충돌을 방지하기 위해 hide 사용
import 'package:flutter_inf_app/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // @GET('/')
  // paginate();

  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail(
      {@Path('id') required String sid});
}
