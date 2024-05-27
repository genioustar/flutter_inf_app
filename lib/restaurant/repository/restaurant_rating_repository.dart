import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_inf_app/common/const/data.dart';
import 'package:flutter_inf_app/common/dio/dio.dart';
import 'package:flutter_inf_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_inf_app/common/model/pagination_params.dart';
import 'package:flutter_inf_app/common/repository/base_pagination_repository.dart';
import 'package:flutter_inf_app/rating/model/rating_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>((ref, rid) {
  final dio = ref.watch(dioProvider);
  return RestaurantRatingRepository(dio,
      baseUrl: 'http://$ip/restaurant/$rid/rating');
});

// baseUrl : http://$ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'}) // 요청 헤더에 accessToken을 포함
  Future<CursorPagination<RatingModel>> paginate({
    @Queries()
    PaginationParams? params = const PaginationParams(), // 페이지네이션 파라미터
  });
}
