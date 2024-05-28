import 'package:flutter_inf_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_inf_app/common/provider/pagination_provider.dart';
import 'package:flutter_inf_app/rating/model/rating_model.dart';
import 'package:flutter_inf_app/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// restaurantRatingRepositoryProvider가 family로 정의되어 있으므로 family로 정의
// restaurantRatingProvider는 특정 레스토랑의(rid) 평점을 가져와야해서 rid를 인자로 받음
final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingStateNotifier, CursorPaginationBase, String>((ref, id) {
  final repository = ref.watch(restaurantRatingRepositoryProvider(id));

  return RestaurantRatingStateNotifier(repository: repository);
});

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  RestaurantRatingStateNotifier({
    required super.repository,
  });
}
