import 'package:flutter_inf_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_inf_app/common/model/model_with_id.dart';
import 'package:flutter_inf_app/common/model/pagination_params.dart';
import 'package:flutter_inf_app/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class PaginationProvider extends StateNotifier<CursorPaginationBase> {
//   final IBasePaginationRepository repository;
// 위의 코드를 좀 더 일반화하여 U라는 타입으로 받아올 수 있도록 수정
class PaginationProvider<
        T extends IModelWithId, // T, U는 인자값으로 받아서 PaginationProvider 클래스에서 사용하는 것
        U extends IBasePaginationRepository<T>>
    //IBasePaginationRepository는 T타입(IModelWithId)을 받는 부모 클래스로 paginate 메서드를 가지고 있음
    extends StateNotifier<CursorPaginationBase> {
  final U repository;
  PaginationProvider({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    // StateNotifier가 생성될 때 pagination() 함수를 실행하여 초기 데이터를 로드
    pagination();
  }

  // pagination 메서드 - 비동기 방식으로 데이터를 로드하고 상태를 업데이트
  Future<void> pagination({
    int fetchCount = 20,
    // true로 설정하면 기존 데이터를 유지하나, 추가 데이터를 가져옴, false면 데이터는 유지한 상태에서 새로고침
    bool fetchMore = false,
    // true로 설정하면 기존 데이터를 날리고 새로 데이터 받아오기를 실행하여 CursorPaginationLoading 상태로 변경
    bool forceRefetch = false,
  }) async {
    try {
      // 5가지의 State 의 상태
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationLoading - 데이터를 받아오는 중인 상태(현재 캐시 없음)
      // 3) CursorPaginationError - 에러가 발생한 상태
      // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올때
      // 5) CursorPaginationRetchMore - 추가 데이터를 paginate 해오라는 요청을 받을때

      // 바로 반환해야하는 상황(데이터를 요청안해도 되는 상황)
      // 1) hasMore = false 기존 상태에서 이미 다음 데이터가 없음
      // 2) 로딩중 - fetchMore = true 일때(사용자가 추가데이터를 요청했을때)
      //         - fetchMore = false 일때(사용자가 데이터를 가져오는 중에 새로고침을 할때)

      // 데이터는 받아왔고 강제 새로고침을 하고 있는중이 아님.
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      // 3가지의 로딩 상태
      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      // 로딩중이거나 새로고침중이거나 추가 데이터를 가져오는 중이면 바로 반환
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }
      // PaginationParams 인스턴스 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore true
      // 데이터를 추가로 더 요청해와야 할때
      if (fetchMore) {
        final pState = state as CursorPagination<T>;
        // 지금부터 데이터를 더 가져와야 됨으로 state를 데이터를 더 가져오고 있는 중인 클래스로 바꿔준다.
        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
          count: fetchCount,
        );
      } else {
        // 데이터가 있다면 데이터를 보존한채로 fetch를 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;
          state = CursorPaginationRefetching(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          // 데이터를 처음부터 가져오는 상황
          state = CursorPaginationLoading();
        }
      }

      // 데이터를 추가 요청하는 부분
      final resp = await repository.paginate(
        params: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;
        // 새로운 데이터를 추가해서 새로운 상태를 만듬
        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: e.toString());
    }
  }

  void paginate({required bool forceRefetch}) {}
}
