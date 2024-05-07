import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inf_app/common/const/colors.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_detail_model.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String detail;
  final int price;
  final String imgUrl;

  const ProductCard({
    super.key,
    required this.name,
    required this.detail,
    required this.price,
    required this.imgUrl,
  });

  factory ProductCard.fromModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
      name: model.name,
      detail: model.detail,
      price: model.price,
      imgUrl: model.imgUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Row 안에 위젯들은 각자의 높이가 따로 설정되기 때문에
    // Row 안에 Column을 넣어서 높이를 맞추기 위해 IntrinsicHeight를 사용합니다.
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/id$imgUrl/200/300',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  detail,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    color: BODY_TEXT_COLOR,
                  ),
                ),
                Text(
                  '$price원',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      fontSize: 12,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
