import 'package:json_annotation/json_annotation.dart';

// part 키워드를 사용하여 생성된 코드 파일을 포함
part 'pagination_params.g.dart';

// PaginationParams 클래스 정의 - 페이지네이션 요청 파라미터를 나타내는 모델
@JsonSerializable()
class PaginationParams {
  final String? after; // 이전 페이지의 마지막 항목의 ID 또는 포인터
  final int? count; // 요청할 항목의 수

  // 생성자 - after와 count를 선택적 매개변수로 받음
  const PaginationParams({
    this.after,
    this.count,
  });

  PaginationParams copyWith({
    String? after,
    int? count,
  }) {
    return PaginationParams(
      after: after ?? this.after,
      count: count ?? this.count,
    );
  }

  // JSON 데이터를 PaginationParams 인스턴스로 변환하는 팩토리 생성자
  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  // PaginationParams 인스턴스를 JSON 데이터로 변환하는 메서드
  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
