import 'package:dio/dio.dart'
    hide Headers; // Headers가 retrofit에서 이미 사용되고 있어서 충돌을 방지하기 위해 hide 사용
import 'package:flutter_inf_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

// API요청을 보내고 받은다음에 <>안에 있는 모델로 변환해서 반환하는 클래스
@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RestaurantModel>> paginate();

  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail(
      {@Path('id') required String sid});
}
