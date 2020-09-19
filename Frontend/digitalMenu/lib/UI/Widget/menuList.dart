import 'package:digitalMenu/Model/menu.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final List<Menu> menuList;
  MenuList({@required this.menuList});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: menuList.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(menuList[i].name),
          subtitle: Text("₹ ${menuList[i].price}"),
        );
      },
    );
  }
}
