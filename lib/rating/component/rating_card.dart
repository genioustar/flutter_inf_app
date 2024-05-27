import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/const/colors.dart';

class RatingCard extends StatelessWidget {
  //NetworkImage or AssetImage

  // CircleAvatar
  final ImageProvider avatarImage;
  // list로 위젯 이미지를 보여줄때
  final List<Image> images;
  // 별점
  final int rating;
  // 이메일
  final String email;
  // 리뷰내용
  final String content;
  const RatingCard(
      {super.key,
      required this.avatarImage,
      required this.images,
      required this.rating,
      required this.email,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          rating: rating,
          email: email,
        ),
        const SizedBox(height: 8),
        _Body(content: content),
        if (images.isNotEmpty)
          SizedBox(height: 100, child: _Images(images: images)),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final int rating;
  final String email;

  const _Header({
    required this.avatarImage,
    required this.rating,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: avatarImage,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // ...연산자를 활용하여 리스트를 하나하나 풀어서 개별 위젯으로 추가
        // ...이 없으면 List<Icon> 타입이 되어 widget에 추가할 수 없음
        // 채운별 안채운별 만들기
        ...List.generate(
          5,
          (index) => Icon(
              index < rating ? Icons.star : Icons.star_border_outlined,
              color: PRIMARY_COLOR),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;
  const _Body({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            // 안에 text를 넣으면 다음줄로 알아서 줄바꿈이 됨
            child: Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: BODY_TEXT_COLOR,
            fontWeight: FontWeight.w400,
          ),
        )),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;
  const _Images({
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: images
            .mapIndexed(
              // collection pakage를 이용해서 index를 사용할 수 있음
              (index, image) => Padding(
                padding:
                    EdgeInsets.only(right: index == images.length ? 0 : 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: image,
                ),
              ),
            )
            .toList());
  }
}
