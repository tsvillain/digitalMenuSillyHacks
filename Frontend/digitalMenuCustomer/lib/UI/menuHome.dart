import 'package:digitalMenuCustomer/Bloc/storeBloc.dart';
import 'package:digitalMenuCustomer/Bloc/storeEvent.dart';
import 'package:digitalMenuCustomer/Model/menuModel.dart';
import 'package:digitalMenuCustomer/Model/storeModel.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'menuList.dart';

class MenuHome extends StatefulWidget {
  final String storeId;
  MenuHome({@required this.storeId});
  @override
  _MenuHomeState createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome>
    with SingleTickerProviderStateMixin {
  StoreBloc _storeBloc;
  List<String> category = [];
  int _selectedIndex = 0;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    _storeBloc = BlocProvider.of<StoreBloc>(context);
    _storeBloc.eventSink.add(GetStore(storeId: widget.storeId));
    _pageController = PageController(
        keepPage: true, initialPage: _selectedIndex, viewportFraction: 1);
    return StreamBuilder<Store>(
      stream: _storeBloc.storeStream,
      initialData: _storeBloc.getStore,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          } else {
            for (var menu in snapshot.data.menuList) {
              if (!category.contains(menu.category)) {
                category.add(menu.category);
              }
            }
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  snapshot.data.shopName,
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                children: [
                  Wrap(
                    children: List.generate(
                      category.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ChoiceChip(
                            selected: _selectedIndex == index,
                            label: Text(category[index]),
                            selectedColor: Color(0xff7aa57f),
                            labelStyle: TextStyle(
                                color: _selectedIndex == index
                                    ? Colors.white
                                    : Colors.black),
                            pressElevation: 1,
                            backgroundColor: Colors.transparent,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: category.length,
                      onPageChanged: (val) {
                        setState(() {
                          _selectedIndex = val;
                        });
                      },
                      itemBuilder: (context, i) {
                        List<Menu> _menuList = List<Menu>();
                        for (var menu in snapshot.data.menuList) {
                          if (menu.category == category[i]) {
                            _menuList.add(menu);
                          }
                        }
                        return MenuList(
                          menuList: _menuList,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
