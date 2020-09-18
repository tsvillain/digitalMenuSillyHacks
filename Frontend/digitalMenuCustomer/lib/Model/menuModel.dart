class Menu {
  String id;
  String category;
  String name;
  double price;

  Menu({
    this.id,
    this.category,
    this.name,
    this.price,
  });

  Menu.fromMap(Map<String, dynamic> map) {
    this.id = map["_id"];
    this.category = map["category"];
    this.name = map["name"];
    this.price = map["price"];
  }
}
