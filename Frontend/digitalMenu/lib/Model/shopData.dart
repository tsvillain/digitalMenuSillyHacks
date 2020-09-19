import 'menu.dart';

class ShopData {
  String shopType;
  List<String> category;
  String shopName;
  String userID;
  List<Menu> menuList;

  ShopData({
    this.userID,
    this.shopType,
    this.category,
    this.shopName,
    this.menuList,
  });

  ShopData.fromMap(Map<String, dynamic> map) {
    this.userID = map["userID"];
    this.shopType = map["shopType"];
    this.category = List<String>();
    for (var i = 0; i < map["category"].length; i++) {
      this.category.add(map["category"][i]);
    }
    this.shopName = map["shopName"];
    this.menuList = List<Menu>();
    for (var i = 0; i < map["menu"].length; i++) {
      this.menuList.add(Menu.fromMap(map["menu"][i]));
    }
  }

  toJson() {
    return {
      "userID": this.userID,
      "shopType": this.shopType,
      "category": this.category,
      "shopName": this.shopName,
      "menuList": this.menuList.map((e) => e.toJson()),
    };
  }
}
