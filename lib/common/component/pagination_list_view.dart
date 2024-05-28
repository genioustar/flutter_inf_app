import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_inf_app/common/model/model_with_id.dart';
import 'package:flutter_inf_app/common/provider/pagination_provider.dart';
import 'package:flutter_inf_app/common/utils/pagination_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
  BuildContext context,
  int index,
  T model,
);

class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;
  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({
    super.key,
    required this.provider,
    required this.itemBuilder,
  });

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollerListener);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(scrollerListener);
    scrollController.dispose();
  }

  void scrollerListener() {
    PaginationUtils.paginate(
      scrollController: scrollController,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(forceRefetch: true);
            },
            child: const Text('다시 시도'),
          ),
        ],
      );
    }

    //데이터를 받아왔을때
    final cp = state as CursorPagination<T>;
    // scaffold가 없어도 되는 이유는 DefaultLayout에서 scaffold를 사용했기 때문
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: scrollController,
        itemCount: cp.meta.count + 1, // 추가 데이터를 가져오는 중에 로딩을 표시하기 위해 +1
        itemBuilder: (context, index) {
          // 추가 데이터를 가져오는 중에 로딩을 표시 데이터가 없으면 없다고 text 표시
          if (index == cp.meta.count) {
            return Center(
              child: cp is CursorPaginationFetchingMore
                  ? const CircularProgressIndicator()
                  : const Text('데이터가 없습니다.'),
            );
          }

          final pItem = cp.data[index];
          return widget.itemBuilder(context, index, pItem);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
