import 'package:digitalMenu/Bloc/storeBloc.dart';
import 'package:digitalMenu/Model/menu.dart';
import 'package:digitalMenu/Model/shopData.dart';
import 'package:digitalMenu/UI/Widget/menuList.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';

class MenuScreen extends StatefulWidget {
  final StoreBloc storeBloc;
  MenuScreen({@required this.storeBloc});
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<String> _category = List<String>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<ShopData>(
            stream: widget.storeBloc.storeStream,
            initialData: widget.storeBloc.getShop,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something went wrong"),
                  );
                } else {
                  for (var menu in snapshot.data.menuList) {
                    if (!_category.contains(menu.cateogry)) {
                      _category.add(menu.cateogry);
                    }
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _category.length,
                    itemBuilder: (context, i) {
                      List<Menu> _menuList = List<Menu>();
                      for (var menu in snapshot.data.menuList) {
                        if (menu.cateogry == _category[i]) {
                          _menuList.add(menu);
                        }
                      }
                      return GFAccordion(
                        title: snapshot.data.menuList[i].cateogry,
                        contentChild: MenuList(
                          menuList: _menuList,
                        ),
                      );
                    },
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
