import 'dart:math';

class TodoItem {
  int id = Random().nextInt(1000);
  String title;
  bool done;

  TodoItem({this.title, this.done});

  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        done = json["done"];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> item = new Map();

    item["title"] = this.title;
    item["done"] = this.done;

    return item;
  }
}
