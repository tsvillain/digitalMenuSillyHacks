import 'package:flutter/material.dart';

abstract class StoreEvent {}

class RegisterUser extends StoreEvent {
  final String name;
  final String email;
  final String password;
  RegisterUser({
    @required this.email,
    @required this.name,
    @required this.password,
  });
}
