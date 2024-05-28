import 'package:flutter_inf_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_inf_app/common/provider/pagination_provider.dart';
import 'package:flutter_inf_app/product/model/product_model.dart';
import 'package:flutter_inf_app/product/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ProductStateNotifier를 제공하는 StateNotifierProvider 정의
final productProvider =
    StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref) {
  // productRepositoryProvider를 사용하여 ProductRepository 인스턴스를 가져옴
  final repository = ref.watch(productRepositoryProvier);
  // ProductStateNotifier 인스턴스를 생성하여 반환
  return ProductStateNotifier(repository: repository);
});

// 이렇게만해도 paginate함수가 자동으로 호출이 됨! 왜냐? 그렇게 짜놨으니까!
// ProductStateNotifier 클래스 정의
// PaginationProvider<ProductModel, ProductRepository>를 상속받음
// ProductModel과 ProductRepository를 사용하여 상태를 관리하는 기능을 상속받음
class ProductStateNotifier
    extends PaginationProvider<ProductModel, ProductRepository> {
  // ProductStateNotifier 생성자 정의
  // PaginationProvider의 생성자를 호출하여 repository를 초기화
  ProductStateNotifier({
    required super.repository,
  });
}
