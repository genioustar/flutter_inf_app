import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/layout/default_layout.dart';
import 'package:flutter_inf_app/common/dio/dio.dart';
import 'package:flutter_inf_app/product/component/product_card.dart';
import 'package:flutter_inf_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_inf_app/restaurant/repository/restaurant_repository.dart';

import '../../common/const/data.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({
    required this.id,
    super.key,
  });

  Future<RestaurantDetailModel> getRestaurantDetail() async {
    final dio = Dio();
    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );
    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    return repository.getRestaurantDetail(sid: id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡복이',
      widget: FutureBuilder<RestaurantDetailModel>(
        future: getRestaurantDetail(),
        builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
            slivers: [
              randerTop(item: snapshot.data!),
              renderLable(),
              renderProducts(products: snapshot.data!.products),
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
