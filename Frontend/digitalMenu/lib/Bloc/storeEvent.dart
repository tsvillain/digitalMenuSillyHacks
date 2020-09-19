import 'package:digitalMenu/Model/menu.dart';
import 'package:flutter/material.dart';

abstract class StoreEvent {}

class AddCategory extends StoreEvent {
  final String category;
  AddCategory({@required this.category});
}

class RemoveCategory extends StoreEvent {
  final int index;
  RemoveCategory({@required this.index});
}

class AddMenuItem extends StoreEvent {
  final Menu menu;
  AddMenuItem({@required this.menu});
}

class RemoveMenuItem extends StoreEvent {
  final Menu menu;
  RemoveMenuItem({@required this.menu});
}

class GetStoreByToken extends StoreEvent {}

class SaveCategory extends StoreEvent {}

class SaveMenu extends StoreEvent {}
