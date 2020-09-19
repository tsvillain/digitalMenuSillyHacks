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
