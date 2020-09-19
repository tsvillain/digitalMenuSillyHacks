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

class GetStoreByToken extends StoreEvent {}
