import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true, // generic을 쓰기 위해 추가
)
class CursorPagination<T> {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

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

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}
