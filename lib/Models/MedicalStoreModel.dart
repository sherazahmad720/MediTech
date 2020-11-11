class MedicalStore {
  int id;
  String name;
  String address;
  String status;

  MedicalStore({this.address, this.id, this.name, this.status});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'bussinessId': status,
    };
    return map;
  }

  MedicalStore.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];

    address = map['address'];
    status = map['status'];
  }
}
