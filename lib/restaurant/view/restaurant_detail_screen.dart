import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/layout/default_layout.dart';
import 'package:flutter_inf_app/restaurant/component/restaurant_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡복이',
      widget: Column(
        children: [
          RestaurantCard(
            image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
            name: '불타는 떡복이',
            tags: const ['한식', '분식', '야식'],
            ratingsCount: 100,
            deliveryTime: 30,
            deliveryFee: 3000,
            ratings: 4.76,
            isDetail: true,
            detail: '불타는 떡볶이는 매운맛을 좋아하는 사람들에게 추천합니다.',
          )
        ],
      ),
    );
  }
}
