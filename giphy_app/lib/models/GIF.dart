class GIF {
  String type;
  String id;
  String title;
  Map<String, Map<String, dynamic>> images;

  GIF({this.type, this.id, this.title, this.images});

  GIF.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    id = json["id"];
    title = json["title"];
    images = {
      "original": json["images"]["original"],
      "downsized": json["images"]["downsized"],
      "fixed_height": json["images"]["fixed_height"]
    };
  }

  Map<String, dynamic> getOriginal() {
    return this.images["original"];
  }

  Map<String, dynamic> getDownsize() {
    return this.images["downsized"];
  }

  Map<String, dynamic> getFixedHeight() {
    return this.images["fixed_height"];
  }
}
