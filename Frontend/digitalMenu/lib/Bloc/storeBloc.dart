import 'dart:async';
import 'dart:convert';
import 'package:digitalMenu/Model/userData.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:digitalMenu/Bloc/storeEvent.dart';
import 'package:digitalMenu/Model/shopData.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const.dart';

class StoreBloc extends Bloc {
  SharedPreferences sharedPreferences;
  ShopData _shop;
  List<String> _category;
  UserData _user;
  ShopData get getShop => _shop;
  UserData get getUser => _user;
  List<String> get getCategory => _category;

  StreamController<StoreEvent> _storeEventController =
      StreamController<StoreEvent>.broadcast();
  StreamSink<StoreEvent> get eventSink => _storeEventController.sink;
  Stream<StoreEvent> get _eventStream => _storeEventController.stream;

  StreamController<List<String>> _categoryController =
      StreamController<List<String>>.broadcast();
  StreamSink<List<String>> get _categorySink => _categoryController.sink;
  Stream<List<String>> get categoryStream => _categoryController.stream;

  StreamController<ShopData> _storeController =
      StreamController<ShopData>.broadcast();
  StreamSink<ShopData> get _storeSink => _storeController.sink;
  Stream<ShopData> get storeStream => _storeController.stream;

  StreamController<UserData> _userController =
      StreamController<UserData>.broadcast();
  StreamSink<UserData> get _userSink => _userController.sink;
  Stream<UserData> get userStream => _userController.stream;

  StoreBloc() {
    _eventStream.listen(_mapEventToState);
  }

  void _mapEventToState(StoreEvent event) async {
    if (event is GetStoreByToken) {
      print("in Token");
      sharedPreferences = await SharedPreferences.getInstance();
      String token = sharedPreferences.getString("token");
      String name = sharedPreferences.getString("userName");
      String email = sharedPreferences.getString("userEmail");
      _user = UserData(email: email, name: name);
      Map<String, String> headerWithToken = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      http.Response response =
          await http.get(storeByTokenEndPoint, headers: headerWithToken);
      if (response.statusCode == 200) {
        var map = jsonDecode(response.body)["data"];
        print(map.toString());
        _shop = ShopData.fromMap(map);
        _category = List<String>();
        for (var i = 0; i < _shop.category.length; i++) {
          _category.add(_shop.category[i]);
        }
        _categorySink.add(_category);
        _storeSink.add(_shop);
      } else {
        print(response.body);
      }
    } else if (event is AddCategory) {
      if (!_category.contains(event.category)) {
        _category.add(event.category);
        _categorySink.add(_category);
      }
    } else if (event is RemoveCategory) {
      _category.removeAt(event.index);
      _categorySink.add(_category);
    }
  }

  Future<bool> loginUser(String email, String password) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var data = jsonEncode({"email": "$email", "password": "$password"});
    http.Response response = await http.post(
      loginEndPoint,
      headers: header,
      body: data,
    );
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      _shop = map["data"]["shopDate"] != null
          ? ShopData.fromMap(map["data"]["shopData"])
          : null;
      _user = UserData.fromMap(map["data"]["userData"]);
      print("TOKEN:: " + map["token"].toString());
      sharedPreferences.setString("token", map["token"]);
      sharedPreferences.setString("userName", _user.name);
      sharedPreferences.setString("userEmail", _user.email);
      _category = List<String>();
      for (var i = 0; i < _shop.category.length; i++) {
        _category.add(_shop.category[i]);
      }
      _categorySink.add(_category);
      _storeSink.add(_shop);
      _userSink.add(_user);
      return true;
    } else {
      var error = jsonDecode(response.body)["message"];
      Fluttertoast.showToast(msg: "$error");
      print(response.body.toString());
      return false;
    }
  }

  Future<bool> registerUser(String name, String email, String password) async {
    var data = jsonEncode(
        {"name": "$name", "email": "$email", "password": "$password"});
    http.Response response = await http.post(
      registerEndPoint,
      body: data,
      headers: header,
    );
    if (response.statusCode == 201) {
      return loginUser(email, password);
    } else {
      print(response.body.toString());
      return false;
    }
  }

  @override
  void dispose() {
    _userController.close();
    _storeEventController.close();
    _storeController.close();
    _categoryController.close();
  }
}
