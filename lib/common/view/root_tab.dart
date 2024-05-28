import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/layout/default_layout.dart';
import 'package:flutter_inf_app/common/const/colors.dart';
import 'package:flutter_inf_app/product/view/product_screen.dart';
import 'package:flutter_inf_app/restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  // TabController는 탭 간의 전환 애니메이션을 관리하는 컨트롤러
  late TabController _tabController;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 현재 위젯의 BuildContext 를 기반으로 TickerProvider 생성
    // TickerProvider는 애니메이션을 제공하는 클래스
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      tabListener();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  void tabListener() {
    setState(() {
      index = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      widget: TabBarView(
        // 좌우 스크롤을 막기 위해 NeverScrollableScrollPhysics() 사용
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          const RestaurantScreen(),
          const ProductScreen(),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.yellow,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        // 중요 기본 쉬프팅! - 선택하면 좀 더 크게 표시
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _tabController.animateTo(index);
        },
        currentIndex: index,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: '음식'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: '주문'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: '프로필'),
        ],
      ),
    );
  }
}
