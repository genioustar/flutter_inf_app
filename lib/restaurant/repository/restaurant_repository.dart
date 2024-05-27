import 'package:dio/dio.dart'
    hide Headers; // Headers가 retrofit에서 이미 사용되고 있어서 충돌을 방지하기 위해 hide 사용
import 'package:flutter_inf_app/common/const/data.dart';
import 'package:flutter_inf_app/common/dio/dio.dart';
import 'package:flutter_inf_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_inf_app/common/model/pagination_params.dart';
import 'package:flutter_inf_app/common/repository/base_pagination_repository.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

// restaurantRepositoryProvider 정의 - RestaurantRepository를 제공하는 Provider
final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  // dioProvider의 상태를 구독하여 dio 인스턴스를 가져옴
  final dio = ref.watch(dioProvider);
  // RestaurantRepository 인스턴스를 생성하여 반환
  final repository =
      RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
  return repository;
});

// API 요청을 보내고 받은 데이터를 <> 안에 있는 모델로 변환하여 반환하는 클래스
@RestApi()
abstract class RestaurantRepository
    implements IBasePaginationRepository<RestaurantModel> {
  // 팩토리 생성자 - Retrofit이 생성한 _RestaurantRepository 인스턴스를 반환
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // 모든 레스토랑의 목록을 페이지네이션하여 가져오는 메서드
  @override
  @GET('/')
  @Headers({'accessToken': 'true'}) // 요청 헤더에 accessToken을 포함
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries()
    PaginationParams? params = const PaginationParams(), // 페이지네이션 파라미터
  });

  // 특정 레스토랑의 상세 정보를 가져오는 메서드
  @GET('/{id}')
  @Headers({'accessToken': 'true'}) // 요청 헤더에 accessToken을 포함
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path('id') required String sid, // URL 경로 파라미터로 레스토랑 ID를 받음
  });
}
