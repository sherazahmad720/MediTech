class Medicine {
  int med_id;
  String name;
  String price;
  String type;

  Medicine({this.name, this.med_id, this.type, this.price});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': med_id,
      'name': name,
      'type': type,
      'pure': price,
    };
    return map;
  }

  Medicine.fromMap(Map<String, dynamic> map) {
    med_id = map['id'];
    name = map['name'];

    price = map['pure'];
    type = map['type'];
  }
}
