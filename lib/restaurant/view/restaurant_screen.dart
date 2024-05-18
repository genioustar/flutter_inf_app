import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/const/data.dart';
import 'package:flutter_inf_app/common/dio/dio.dart';
import 'package:flutter_inf_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_inf_app/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_inf_app/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginationRestaurant() async {
    final dio = Dio();
    // api 호출전에 뭘해야 될지를 정의한 interceptor를 dio에 추가
    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );

    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    return repository.paginate().then((value) => value.data);
  }

  @override
  Widget build(BuildContext context) {
    // scaffold가 없어도 되는 이유는 DefaultLayout에서 scaffold를 사용했기 때문
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FutureBuilder<List<RestaurantModel>>(
        future: paginationRestaurant(),
        builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('로딩 중...!'),
            );
          }

          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final pItem = snapshot.data![index];
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
