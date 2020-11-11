class Medicine {
  int medId;
  String name;
  String price;
  String type;

  Medicine({this.name, this.medId, this.type, this.price});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'medId': medId,
      'medName': name,
      'medType': type,
      'medPrice': price,
    };
    return map;
  }

  Medicine.fromMap(Map<String, dynamic> map) {
    medId = map['medId'];
    name = map['medName'];

    price = map['medPrice'];
    type = map['medType'];
  }
}
