import 'package:get/get.dart';
import 'package:medi_tech/Models/MedicineModel.dart';
import 'package:medi_tech/Models/OrderList.dart';
import 'package:medi_tech/Models/ordersModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';

import '../../Models/MedicalStoreModel.dart';

class DbController extends GetxController {
//Data base name variable
  static Database _db;
  //database name
  static const String DB_NAME = 'meditech.db';
//Table varible
  static const String TABLEMedicalStore = 'MedicalStore';
  static const String TABLEMedicine = 'Medicine';
  static const String TABLEOrders = 'Orders';
  static const String TABLEOrderList = 'OrderList';
  //medicin field variable
  static const String MedId = 'medId';
  static const String MedName = 'medName';
  static const String MedPrice = 'medPrice';
  static const String MedType = 'medType';
  //Medical store field variable
  static const String StoreId = 'StoreId';
  static const String StoreName = 'StoreName';
  static const String StoreAddress = 'StoreAddress';
  static const String StoreStatus = 'StoreStatus';
  // order field variables
  static const String OrderId = 'OrderId';
  static const String Date = 'Date';
  // order List field variables
  static const String ListId = 'ListId';
  static const String Quantity = 'Quantity';
  static const String SPrice = 'SPrice';
//Functions
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLEMedicine($MedId INTEGER PRIMARY KEY AUTOINCREMENT,$MedName TEXT,$MedPrice TEXT,$MedType  Text)");
    await db.execute(
        "CREATE TABLE $TABLEMedicalStore($StoreId INTEGER PRIMARY KEY AUTOINCREMENT,$StoreName TEXT,$StoreAddress TEXT,$StoreStatus Text)");
    await db.execute(
        "CREATE TABLE $TABLEOrderList($ListId INTEGER PRIMARY KEY AUTOINCREMENT,$StoreName TEXT,$StoreAddress TEXT,$Date Text)");
    await db.execute(
        "CREATE TABLE $TABLEOrders($OrderId INTEGER PRIMARY KEY AUTOINCREMENT,$StoreName TEXT,$MedName TEXT,$Quantity TEXT,$SPrice Text,$Date Text)");
  }

////
  ///
  ///Variables
  String totalMedicalstores = "0";
  String totalMedicines = "0";
  String totalOrders = "0";

  ///
  ///LIsts
  List<Medicine> medicineList = [];
  List<MedicalStore> medicalStoreList = [];
  List<Orders> order = [];
  List<Orders> savedOrder = [];
  List<OrdersList> orderList = [];
  String address = "";
  //
  // call All functions
  Future allFunctions() async {
    getMedicineList();
    getMedicalStoreList();
    getOrder();
    getOrderList();
    count();
    update();
  }

  //add Medicine function
  Future saveMedicine(Medicine data) async {
    var dbCon = await db;
    await dbCon.insert(TABLEMedicine, data.toMap());
    update();
    getMedicineList();
  }

// save Order

//Get medicine from data base
  Future getMedicineList() async {
    var dbCon = await db;
    List<Map> maps = await dbCon.rawQuery('Select * from $TABLEMedicine');
    medicineList.clear();
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        medicineList.add(Medicine.fromMap(maps[i]));
      }
    }
    count();
    update();
  }

  // save medical store in data base
  Future saveMedicalStore(MedicalStore data) async {
    var dbCon = await db;
    await dbCon.insert(TABLEMedicalStore, data.toMap());
    update();
    getMedicalStoreList();
  }

//Get Medical Stores List from data base
  Future getMedicalStoreList() async {
    var dbCon = await db;
    List<Map> maps = await dbCon.rawQuery('Select * from $TABLEMedicalStore');
    medicalStoreList.clear();
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        medicalStoreList.add(MedicalStore.fromMap(maps[i]));
      }
      count();
      update();
    }
  }

//add Medicine function
  Future saveOrder(Orders data) async {
    var dbCon = await db;
    await dbCon.insert(TABLEOrders, data.toMap());
    update();
    getOrder();
  }

//Get Orders
  Future getOrder() async {
    var dbCon = await db;
    List<Map> maps = await dbCon.rawQuery('Select * from $TABLEOrders');
    savedOrder.clear();
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        savedOrder.add(Orders.fromMap(maps[i]));
      }
    }
    count();
    update();
  }

//sorted order
  Future getSortedOrder(String store, String date) async {
    var dbCon = await db;
    List<Map> maps = await dbCon
        .rawQuery('Select * from $TABLEOrders Where $StoreName=? ', ['$store']);
    List<Orders> sortedOrder = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        if (maps[i]['Date'] == date) {
          sortedOrder.add(Orders.fromMap(maps[i]));
        }
      }
    }
    return sortedOrder;
  }

//add orderlists
  Future saveOrderList(OrdersList data) async {
    var dbCon = await db;
    await dbCon.insert(TABLEOrderList, data.toMap());
    update();
    count();
    getOrderList();
  }

//Get Orders Lists
  Future getOrderList() async {
    var dbCon = await db;
    List<Map> maps = await dbCon
        .rawQuery('Select * from $TABLEOrderList ORDER BY date($Date) DESC');
    orderList.clear();
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        orderList.add(OrdersList.fromMap(maps[i]));
      }
    }
    count();
    update();
  }

  //count medical store
  Future count() async {
    var dbCon = await db;
    int countStores = Sqflite.firstIntValue(
        await dbCon.rawQuery('SELECT COUNT(*) FROM $TABLEMedicalStore'));
    totalMedicalstores = countStores.toString();
    int countMedicines = Sqflite.firstIntValue(
        await dbCon.rawQuery('SELECT COUNT(*) FROM $TABLEMedicine'));
    totalMedicines = countMedicines.toString();
    int countorders = Sqflite.firstIntValue(
        await dbCon.rawQuery('SELECT COUNT(*) FROM $TABLEOrderList'));
    totalOrders = countorders.toString();
    update();
  }
}
