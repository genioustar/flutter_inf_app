import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/layout/default_layout.dart';
import 'package:flutter_inf_app/product/component/product_card.dart';
import 'package:flutter_inf_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_detail_model.dart';

import '../../common/const/data.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({
    required this.id,
    super.key,
  });

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKE_KEY);
    return dio
        .get('http://$ip/restaurant/$id',
            options: Options(headers: {
              HttpHeaders.authorizationHeader: 'Bearer $accessToken'
            }))
        .then(
      (resp) {
        // print(resp);
        return resp.data;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡복이',
      widget: FutureBuilder<Map<String, dynamic>>(
        future: getRestaurantDetail(),
        builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final item = RestaurantDetailModel.fromJson(json: snapshot.data!);
          return CustomScrollView(
            slivers: [
              randerTop(item: item),
              renderLable(),
              renderProducts(products: item.products),
            ],
          );
        },
      ),
    );
  }

  SliverPadding renderLable() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          final model = products[index];
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ProductCard.fromModel(model: model),
          );
        },
        childCount: products.length,
      )),
    );
  }

  SliverToBoxAdapter randerTop({required RestaurantDetailModel item}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(model: item, isDetail: true),
    );
  }
}
