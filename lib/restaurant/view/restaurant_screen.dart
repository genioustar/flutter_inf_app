import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/const/data.dart';
import 'package:flutter_inf_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_inf_app/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginationRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKE_KEY);
    print('read accessToken : $accessToken');
    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
      ),
    );
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    // scaffold가 없어도 되는 이유는 DefaultLayout에서 scaffold를 사용했기 때문
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FutureBuilder<List>(
        future: paginationRestaurant(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('로딩 중...'),
            );
          }

          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              final pItem = RestaurantModel.fromJson(json: item);
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
          );
        },
      ),
    );
  }
}
