import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/const/colors.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  // 이미지
  final Widget image;
  // 가게 이름
  final String name;
  // 가게 태그
  final List<String> tags;
  // 평점 갯수
  final int ratingsCount;
  // 배송 시간
  final int deliveryTime;
  // 배송비
  final int deliveryFee;
  // 가게 평점
  final double ratings;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
  });

  factory RestaurantCard.fromModel({required RestaurantModel model}) {
    return RestaurantCard(
      image: Image.network(
        'https://picsum.photos/id${model.thumbUrl}/200/300',
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: image,
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tags.join(' · '),
              style: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _IconText(icon: Icons.star_outlined, lable: '평점 $ratings'),
                const SizedBox(width: 8),
                _IconText(
                    icon: Icons.receipt_outlined, lable: '리뷰 $ratingsCount'),
                const SizedBox(width: 8),
                _IconText(
                    icon: Icons.timelapse_outlined,
                    lable: '배달시간 $deliveryTime분'),
                const SizedBox(width: 8),
                _IconText(
                    icon: Icons.monetization_on_outlined,
                    lable: deliveryFee == 0 ? '무료' : '배달비 $deliveryFee원'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String lable;
  const _IconText({
    required this.icon,
    required this.lable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(lable,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
