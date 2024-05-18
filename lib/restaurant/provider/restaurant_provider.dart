import 'package:flutter_inf_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_inf_app/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// restaurantProvider 정의 - RestaurantStateNotifier를 제공하는 StateNotifierProvider
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
        (ref) {
  // restaurantRepositoryProvider의 상태를 구독하여 repository 인스턴스를 가져옴
  final repository = ref.watch(restaurantRepositoryProvider);
  // RestaurantStateNotifier 인스턴스를 생성하여 반환
  return RestaurantStateNotifier(repository: repository);
});

// RestaurantStateNotifier 클래스 정의 - StateNotifier를 상속받아 상태 관리
class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>> {
  // RestaurantRepository 인스턴스
  final RestaurantRepository repository;

  // 생성자 - repository를 인자로 받고, 초기 상태를 빈 리스트로 설정
  RestaurantStateNotifier({
    required this.repository,
  }) : super([]) {
    // StateNotifier가 생성될 때 pagination() 함수를 실행하여 초기 데이터를 로드
    pagination();
  }

  // pagination 메서드 - 비동기 방식으로 데이터를 로드하고 상태를 업데이트
  pagination() async {
    // repository에서 paginate 메서드를 호출하여 결과를 가져옴
    final result = await repository.paginate();
    // state를 결과의 데이터로 업데이트
    state = result.data;
  }
}
