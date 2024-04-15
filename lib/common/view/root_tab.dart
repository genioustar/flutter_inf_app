import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/layout/default_layout.dart';

class RootTab extends StatelessWidget {
  const RootTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      widget: Center(
        child: Text('Root Tab'),
      ),
    );
  }
}
