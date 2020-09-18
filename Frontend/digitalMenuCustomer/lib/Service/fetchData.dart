import 'dart:convert';

import 'package:digitalMenuCustomer/Model/storeModel.dart';
import 'package:http/http.dart' as http;

import '../consts.dart';

class FetchData {
  getStore(String storeId) async {
    Store store;
    http.Response response = await http.get(getStoreEndPoint + storeId);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body)["data"];
      store = Store.fromMap(map);
    } else {
      print(response.body.toString());
    }
    return store;
  }
}
