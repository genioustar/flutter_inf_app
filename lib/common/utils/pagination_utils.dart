import 'package:flutter/widgets.dart';
import 'package:flutter_inf_app/common/provider/pagination_provider.dart';

class PaginationUtils {
  static void paginate(
      {required ScrollController scrollController,
      required PaginationProvider provider}) {
    if (scrollController.offset >
        scrollController.position.maxScrollExtent - 300) {
      provider.pagination(fetchMore: true);
    }
  }
}
