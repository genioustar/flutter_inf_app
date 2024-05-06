import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inf_app/common/const/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Row 안에 위젯들은 각자의 높이가 따로 설정되기 때문에
    // Row 안에 Column을 넣어서 높이를 맞추기 위해 IntrinsicHeight를 사용합니다.
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '떡볶이',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '전통 떡볶이의 정석\n매콤한 맛이 일품입니다.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12,
                    color: BODY_TEXT_COLOR,
                  ),
                ),
                Text(
                  '4,500원',
                  textAlign: TextAlign.end,
                  style: TextStyle(
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
