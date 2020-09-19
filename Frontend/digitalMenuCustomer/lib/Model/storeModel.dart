import 'menuModel.dart';

class Store {
  String shopType;
  bool public;
  String shopName;
  String userId;
  String storeId;
  List<Menu> menuList;

  Store({
    this.shopType,
    this.public,
    this.shopName,
    this.userId,
    this.storeId,
    this.menuList,
  });

  Store.fromMap(Map<String, dynamic> map) {
    this.shopName = map["shopName"];
    this.public = map["public"];
    this.shopType = map["shopType"];
    this.userId = map["userId"];
    this.storeId = map["storeId"];
    this.menuList = List<Menu>();
    for (var i = 0; i < map["menu"].length; i++) {
      this.menuList.add(Menu.fromMap(map["menu"][i]));
    }
  }
}
