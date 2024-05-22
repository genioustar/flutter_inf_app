import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_inf_app/restaurant/%08provider/restaurant_provider.dart';
import 'package:flutter_inf_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_inf_app/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollerListener);
  }

  void scrollerListener() {
    if (scrollController.offset >
        scrollController.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).pagination(fetchMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (data is CursorPagination) {
      // scaffold가 없어도 되는 이유는 DefaultLayout에서 scaffold를 사용했기 때문
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          controller: scrollController,
          itemCount: data.meta.count + 1, // 추가 데이터를 가져오는 중에 로딩을 표시하기 위해 +1
          itemBuilder: (context, index) {
            // 추가 데이터를 가져오는 중에 로딩을 표시 데이터가 없으면 없다고 text 표시
            if (index == data.meta.count) {
              return Center(
                child: data is CursorPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text('데이터가 없습니다.'),
              );
            }

            final pItem = data.data[index];
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
        ),
      );
    } else {
      return Center(
        child: Text((data as CursorPaginationError).message),
      );
    }
  }
}
