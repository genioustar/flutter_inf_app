import 'package:flutter/material.dart';
import 'package:flutter_inf_app/restaurant/%08provider/restaurant_provider.dart';
import 'package:flutter_inf_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_inf_app/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    // scaffold가 없어도 되는 이유는 DefaultLayout에서 scaffold를 사용했기 때문
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final pItem = data[index];
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RestaurantDetailScreen(
                      id: pItem.id,
                    ),
                  ),
                );
              },
              child: RestaurantCard.fromModel(model: pItem));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
