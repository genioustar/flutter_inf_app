import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/layout/default_layout.dart';
import 'package:flutter_inf_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_inf_app/common/utils/pagination_utils.dart';
import 'package:flutter_inf_app/product/component/product_card.dart';
import 'package:flutter_inf_app/rating/component/rating_card.dart';
import 'package:flutter_inf_app/rating/model/rating_model.dart';
import 'package:flutter_inf_app/restaurant/%08provider/restaurant_provider.dart';
import 'package:flutter_inf_app/restaurant/%08provider/restaurant_rating_provider.dart';
import 'package:flutter_inf_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_inf_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const RestaurantDetailScreen({
    required this.id,
    super.key,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    scrollController.addListener(scrollerListener);
  }

  void scrollerListener() {
    PaginationUtils.paginate(
      scrollController: scrollController,
      provider: ref.read(restaurantRatingProvider(widget.id).notifier),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingState = ref.watch(restaurantRatingProvider(widget.id));

    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return DefaultLayout(
      title: '불타는 떡복이',
      widget: CustomScrollView(
        controller: scrollController,
        slivers: [
          randerTop(item: state),
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) renderLable(),
          if (state is RestaurantDetailModel)
            renderProducts(products: state.products),
          if (ratingState is CursorPagination<RatingModel>)
            renderRatings(models: ratingState.data),
        ],
      ),
    );
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RatingCard.fromModel(model: models[index]),
                ),
            childCount: models.length),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Expanded(
                  child: SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 3,
                        spacing: 6,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                )),
          ),
        ),
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

  SliverToBoxAdapter randerTop({required RestaurantModel item}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(model: item, isDetail: true),
    );
  }
}
