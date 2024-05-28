import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

// 이 클래스를 활용해서, 실제 api통신을 할때 로딩중, 에러, 데이터를 받아올때에 사용하는 class를 나눠서 사용할 수 있음.
// class를 나누는 이유는 restaurant_provider.dart에서 사용할때, 데이터를 받아올때에 로딩중, 에러, 데이터를 받아올때에 각각 다른 class를 사용해서 구분하려고 사용함.
// 처음일때는 meta, data가 없으니 ?로 처리할 수 있으나, 그렇게 되면 서버에서는 무슨일이 있어도 meta, data는 주게 되는데 null있다고 처리하기에는 무리가 있음.
abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

// data가 CurosrPaginationLoading의 클래스인지를 확인해서 true가 되면 로딩중임을 알 수 있음. 따라서 class안에 아무값도 없어도 됨.
class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true, // generic을 쓰기 위해 추가
)
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  CursorPagination<T> copyWith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagination(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

//retrofit을 사용하면서 json_serializable을 사용해 List<T>의 T를 어떤 타입으로 사용할지 모르기 때문에
// T Function(Object? json) fromJsonT를 사용해서 json으로 받은 데이터를 어떤 모델의 타입으로 변환할지를 알려주는 역할
  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  CursorPaginationMeta copywith({
    int? count,
    bool? hasMore,
  }) {
    return CursorPaginationMeta(
      count: count ?? this.count,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

// 앱에서 새로고침해서 처음부터 데이터를 다시 받아올때 사용하는 class
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

// 앱에서 맨 마지막으로 가서 데이터를 더 받아올때 사용하는 class
// loading class를 사용하지 못하는 이유는 loading class는 데이터가 없는 상태에서 사용하는 것이기 때문에
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}
