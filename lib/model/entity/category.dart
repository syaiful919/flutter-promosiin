class Category {
  String name;
  String code;
  String type;
  String key;
  String imageUrl;
  int total;
  bool selected;

  Category({
    this.name,
    this.code,
    this.type,
    this.key,
    this.imageUrl,
    this.total,
    this.selected = false,
  });

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    type = json['type'];
    key = json['key'];
    imageUrl = json['imageUrl'];
    total = json['total'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['type'] = this.type;
    data['key'] = this.key;
    data['imageUrl'] = this.imageUrl;
    data['total'] = this.total;
    return data;
  }
}
