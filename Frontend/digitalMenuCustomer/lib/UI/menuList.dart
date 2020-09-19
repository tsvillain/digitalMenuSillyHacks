import 'package:digitalMenuCustomer/Model/menuModel.dart';
import 'package:flutter/material.dart';

import 'Widgets/listCard.dart';

class MenuList extends StatelessWidget {
  final List<Menu> menuList;
  MenuList({@required this.menuList});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menuList.length,
      itemBuilder: (context, i) {
        return ListCard(menu: menuList[i]);
      },
    );
  }
}
