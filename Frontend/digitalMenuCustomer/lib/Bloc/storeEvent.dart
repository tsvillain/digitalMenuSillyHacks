import 'package:flutter/material.dart';

abstract class StoreEvent {}

class GetStore extends StoreEvent {
  final String storeId;
  GetStore({@required this.storeId});
}
