import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/pagination_list_view.dart';
import 'package:flutter_inf_app/restaurant/%08provider/restaurant_provider.dart';
import 'package:flutter_inf_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_inf_app/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(
                    id: model.id,
                  ),
                ),
              );
            },
            child: RestaurantCard.fromModel(model: model));
      },
    );
  }
}
