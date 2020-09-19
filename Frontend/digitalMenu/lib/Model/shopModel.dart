import 'package:digitalMenu/Model/shopData.dart';
import 'package:digitalMenu/Model/userData.dart';

class ShopModel {
  UserData userData;
  ShopData shopData;

  ShopModel({
    this.userData,
    this.shopData,
  });

  ShopModel.fromMap(Map<String, dynamic> map) {
    this.userData = UserData.fromMap(map["userData"]);
    this.shopData =
        map["shopData"] != null ? ShopData.fromMap(map["shopData"]) : null;
  }

  toJson() {
    return {
      "userData": this.userData.toJson(),
      "shopData": this.shopData.toJson(),
    };
  }
}
