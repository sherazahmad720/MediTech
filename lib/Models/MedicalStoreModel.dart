class MedicalStore {
  int id;
  String name;
  String address;
  String status;

  MedicalStore({this.address, this.id, this.name, this.status});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'StoreId': id,
      'StoreName': name,
      'StoreAddress': address,
      'StoreStatus': status,
    };
    return map;
  }

  MedicalStore.fromMap(Map<String, dynamic> map) {
    id = map['StoreId'];
    name = map['StoreName'];
    address = map['StoreAddress'];
    status = map['StoreStatus'];
  }
}
