import 'package:flutter/material.dart';
import 'package:flutter_inf_app/restaurant/component/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // scaffold가 없어도 되는 이유는 DefaultLayout에서 scaffold를 사용했기 때문
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RestaurantCard(
        image: Image.asset(
          'asset/img/food/ddeok_bok_gi.jpg',
          fit: BoxFit.cover,
        ),
        name: '불타는 떡볶이',
        tags: const ['떡볶이', '치즈', '매운맛'],
        ratingCount: 100,
        deliveryTime: 15,
        deliveryFee: 2000,
        rating: 4.52,
      ),
    );
  }
}
