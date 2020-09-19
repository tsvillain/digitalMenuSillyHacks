import 'package:digitalMenu/Bloc/storeBloc.dart';
import 'package:digitalMenu/Bloc/storeEvent.dart';
import 'package:digitalMenu/Model/menu.dart';
import 'package:digitalMenu/UI/Widget/menuList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:getwidget/getwidget.dart';

class MenuScreen extends StatefulWidget {
  final StoreBloc storeBloc;
  MenuScreen({@required this.storeBloc});
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  List<String> _category = List<String>();
  String selectCategory;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Menu>>(
      stream: widget.storeBloc.menuStream,
      initialData: widget.storeBloc.getMenu,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Something went wrong"),
              ),
            );
          } else {
            for (var menu in snapshot.data) {
              if (!_category.contains(menu.cateogry)) {
                _category.add(menu.cateogry);
              }
            }
            return Scaffold(
              appBar: AppBar(
                title: Text("Menu"),
                centerTitle: true,
              ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    heroTag: 1,
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return Form(
                              key: _formKey,
                              child: SimpleDialog(
                                contentPadding: EdgeInsets.all(12),
                                title: Text("Add Menu Item"),
                                children: [
                                  StreamBuilder<List<String>>(
                                      stream: widget.storeBloc.categoryStream,
                                      initialData: widget.storeBloc.getCategory,
                                      builder: (context, category) {
                                        return DropdownButton(
                                          isExpanded: true,
                                          items: category.data
                                              .map(
                                                (e) => DropdownMenuItem(
                                                  child: Text(e),
                                                  value: e,
                                                ),
                                              )
                                              .toList(),
                                          hint: Text("Select Category"),
                                          value: selectCategory,
                                          onChanged: (val) {
                                            setState(() {
                                              selectCategory = val;
                                            });
                                          },
                                        );
                                      }),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: "Dish Name"),
                                    controller: _name,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: "Amount"),
                                    controller: _price,
                                    keyboardType: TextInputType.number,
                                  ),
                                  GFButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        Menu _menu = Menu(
                                          cateogry: selectCategory,
                                          name: _name.text,
                                          price: int.parse(_price.text),
                                        );
                                        widget.storeBloc.eventSink
                                            .add(AddMenuItem(menu: _menu));
                                        Navigator.pop(context);
                                      }
                                    },
                                    text: "Add Menu",
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    label: Text("Add"),
                    icon: Icon(Icons.add),
                  ),
                  SizedBox(width: 10),
                  FloatingActionButton.extended(
                    heroTag: 2,
                    onPressed: () {
                      widget.storeBloc.eventSink.add(SaveMenu());
                    },
                    label: Text("Save"),
                    icon: Icon(Icons.save),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _category.length,
                  itemBuilder: (context, i) {
                    List<Menu> _menuList = List<Menu>();
                    for (var menu in snapshot.data) {
                      if (menu.cateogry == _category[i]) {
                        _menuList.add(menu);
                      }
                    }
                    return snapshot.data.length == 0
                        ? Container()
                        : GFAccordion(
                            title: snapshot.data[i].cateogry,
                            contentChild: MenuList(
                              storeBloc: widget.storeBloc,
                              menuList: _menuList,
                            ),
                          );
                  },
                ),
              ),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
