class Medicine {
  int medid;
  String name;
  String price;
  String type;

  Medicine({this.name, this.medid, this.type, this.price});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': medid,
      'name': name,
      'type': type,
      'pure': price,
    };
    return map;
  }

  Medicine.fromMap(Map<String, dynamic> map) {
    medid = map['id'];
    name = map['name'];

    price = map['pure'];
    type = map['type'];
  }
}
