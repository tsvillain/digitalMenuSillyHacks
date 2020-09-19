class ShopModel {
  String name;
  String userID;
  String email;
  String shopType;
  List<String> category;
  String shopName;
  List<Menu> menuList;

  ShopModel({
    this.name,
    this.userID,
    this.email,
    this.shopType,
    this.category,
    this.shopName,
    this.menuList,
  });

  ShopModel.fromMap(Map<String, dynamic> map) {
    this.name = map["userData"]["name"];
    this.userID = map["shopData"]["userID"];
    this.email = map["userData"]["email"];
    this.shopType = map["shopData"]["shopType"];
    this.category = List<String>();
    for (var i = 0; i < map["shopData"]["category"].length; i++) {
      this.category.add(map["shopData"]["category"][i]);
    }
    this.shopName = map["shopData"]["shopName"];
    this.menuList = List<Menu>();
    for (var i = 0; i < map["shopData"]["menu"].length; i++) {
      this.menuList.add(Menu.fromMap(map["shopData"]["shopName"][i]));
    }
  }
}

class Menu {
  String cateogry;
  String name;
  int price;

  Menu({
    this.cateogry,
    this.name,
    this.price,
  });

  toJson() {
    return {
      "category": this.cateogry,
      "name": this.name,
      "price": this.price,
    };
  }

  Menu.fromMap(Map<String, dynamic> map) {
    this.cateogry = map["category"];
    this.name = map["name"];
    this.price = map["price"];
  }
}
