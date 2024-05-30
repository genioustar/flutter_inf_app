import 'package:collection/collection.dart';
import 'package:flutter_inf_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_inf_app/common/provider/pagination_provider.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_inf_app/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

// restaurantProvider 정의 - RestaurantStateNotifier를 제공하는 StateNotifierProvider
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  // restaurantRepositoryProvider의 상태를 구독하여 repository 인스턴스를 가져옴
  final repository = ref.watch(restaurantRepositoryProvider);
  // RestaurantStateNotifier 인스턴스를 생성하여 반환
  return RestaurantStateNotifier(repository: repository);
});

// RestaurantStateNotifier 클래스 정의 - StateNotifier를 상속받아 상태 관리
class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  // 생성자 - repository를 인자로 받고, 초기 상태를 빈 리스트로 설정
  RestaurantStateNotifier({
    required super.repository,
  });

  void getDetail({
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면(CursorPagination이 아니라면) 데이터를 가져옴
    if (state is! CursorPagination) {
      await pagination();
    }
    // 서버가 문제여서 데이터를 가져오지 못했을때
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;
    final resp = await repository.getRestaurantDetail(sid: id);

    // 20개의 restaurnt 데이터만 가져왔어서 21번째 restaurant의 상품 데이터가 없다면 추가 요청해서 state에 추가하고, 있다면 기존 데이터를 업데이트
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <RestaurantModel>[...pState.data, resp],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? resp : e)
            .toList(),
      );
    }
  }
}
