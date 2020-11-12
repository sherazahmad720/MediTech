import 'package:get/get.dart';
import 'package:medi_tech/Models/MedicineModel.dart';
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
        "CREATE TABLE $TABLEOrders($OrderId INTEGER PRIMARY KEY AUTOINCREMENT,$StoreId TEXT,$Date Text)");
    await db.execute(
        "CREATE TABLE $TABLEOrderList($ListId INTEGER PRIMARY KEY AUTOINCREMENT,$OrderId TEXT,$MedId TEXT,$Quantity TEXT,$SPrice Text)");
  }

////
  ///
  ///
  ///LIsts
  List<Medicine> medicineList = [];
  List<MedicalStore> medicalStoreList = [];
  //add Medicine function
  Future saveMedicine(Medicine data) async {
    var dbCon = await db;
    await dbCon.insert(TABLEMedicine, data.toMap());
    update();
    getMedicineList();
  }

//Get medicine from data base
  Future getMedicineList() async {
    var dbCon = await db;
    List<Map> maps = await dbCon.rawQuery('Select * from $TABLEMedicine');
    medicineList.clear();
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        medicineList.add(Medicine.fromMap(maps[i]));
      }
      update();
    }
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
      update();
    }
  }
}
