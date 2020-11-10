import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';

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
  static const String MedId = 'medicineId';
  static const String MedName = 'MedName';
  static const String MedPrice = 'MedPrice';
  static const String MedType = 'MedType';
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
        "CREATE TABLE $TABLEMedicalStore($MedId INTEGER PRIMARY KEY AUTOINCREMENT,$MedName TEXT,$MedPrice TEXT,$MedType  Text)");
    await db.execute(
        "CREATE TABLE $TABLEMedicine($StoreId INTEGER PRIMARY KEY AUTOINCREMENT,$StoreName TEXT,$StoreAddress TEXT,$StoreStatus Text)");
    await db.execute(
        "CREATE TABLE $TABLEOrders($OrderId INTEGER PRIMARY KEY AUTOINCREMENT,$StoreId TEXT,$Date Text)");
    await db.execute(
        "CREATE TABLE $TABLEOrderList($ListId INTEGER PRIMARY KEY AUTOINCREMENT,$OrderId TEXT,$MedId TEXT,$Quantity TEXT,$SPrice Text)");
  }
}
