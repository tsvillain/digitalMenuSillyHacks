import 'package:digitalMenu/Bloc/storeBloc.dart';
import 'package:digitalMenu/Bloc/storeEvent.dart';
import 'package:digitalMenu/Model/menu.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final StoreBloc storeBloc;
  final List<Menu> menuList;
  MenuList({
    @required this.menuList,
    @required this.storeBloc,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      shrinkWrap: true,
      itemCount: menuList.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(menuList[i].name),
          subtitle: Text("₹ ${menuList[i].price}"),
          trailing: IconButton(
            icon: Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
            ),
            onPressed: () {
              storeBloc.eventSink.add(RemoveMenuItem(menu: menuList[i]));
            },
          ),
        );
      },
    );
  }
}
