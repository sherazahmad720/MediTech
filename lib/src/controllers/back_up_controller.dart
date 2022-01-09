import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:intl/intl.dart';
import 'package:medi_tech/Models/MedicalStoreModel.dart';
import 'package:medi_tech/Models/MedicineModel.dart';
import 'package:medi_tech/Models/OrderList.dart';
import 'package:medi_tech/Models/backup_model.dart';
import 'package:medi_tech/Models/ordersModel.dart';

import 'package:medi_tech/src/controllers/db_controller.dart';

class BackUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DbController dbController = Get.put(DbController());
  bool isLoading = false;
  List<BackupModel> backupList = [];

  backUpData() async {
    isLoading = true;
    update();
    await dbController.getMedicalStoreList();
    await dbController.getMedicineList();
    await dbController.getOrderList();
    await dbController.getOrder();
    print(dbController.medicalStoreList);
    // isLoading = false;
    // update();
    // return;
    DocumentReference ref = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
        .collection('backup')
        .add(BackupModel(
          date: DateFormat('yyyy-MM-dd KK:mm').format(DateTime.now()),
          title: 'medi_tech_backup-${DateTime.now().millisecondsSinceEpoch}',
        ).toMap());
    for (var data in dbController.medicalStoreList) {
      await ref.collection('medicalStores').add(data.toMap());
    }
    for (var data in dbController.medicineList) {
      await ref.collection('medicines').add(data.toMap());
    }
    for (var data in dbController.savedOrder) {
      await ref.collection('orders').add(data.toMap());
    }
    for (var data in dbController.orderList) {
      await ref.collection('ordersList').add(data.toMap());
    }
    getBackUpList();
    Get.snackbar('Success', 'Backup Successful');
    isLoading = false;
    update();
  }

  getBackUpList() async {
    if (FirebaseAuth.instance.currentUser != null) {
      backupList.clear();
      QuerySnapshot snaps = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
          .collection('backup')
          .orderBy('Date', descending: true)
          .get();
      snaps.docs.forEach((doc) {
        backupList.add(BackupModel.fromDocumentSnapshot(doc));
      });
      update();
    }
  }

  restoreData(BackupModel backupModel) async {
    isLoading = true;
    update();
    await dbController.cleanDatabase();
    QuerySnapshot storesSnaps =
        await backupModel.reference!.collection('medicalStores').get();
    storesSnaps.docs.forEach((doc) {
      dbController.saveMedicalStore(MedicalStore.fromDocumentSnapshot(doc));
    });
    /* -------------------------------------------------------------------------- */
    QuerySnapshot medicineSnaps =
        await backupModel.reference!.collection('medicines').get();
    medicineSnaps.docs.forEach((doc) {
      dbController.saveMedicine(Medicine.fromDocumentSnapshot(doc));
    });
    /* -------------------------------------------------------------------------- */
    QuerySnapshot orderSnaps =
        await backupModel.reference!.collection('orders').get();
    orderSnaps.docs.forEach((doc) {
      dbController.saveOrder(Orders.fromDocumentSnapshot(doc));
    });
    /* -------------------------------------------------------------------------- */
    QuerySnapshot orderListSnap =
        await backupModel.reference!.collection('ordersList').get();
    orderListSnap.docs.forEach((doc) {
      dbController.saveOrderList(OrdersListModel.fromDocumentSnapshot(doc));
    });
    Get.snackbar('Success', 'Restore Successful');
    dbController.allFunctions();
    isLoading = false;
    update();
  }

  logout() {
    _auth.signOut();
    _googleSignIn.signOut();
    update();
  }

  loginWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await _auth.signInWithCredential(credential);
    FirebaseFirestore.instance
        .collection('users')
        .doc(authResult.user?.uid)
        .set(
      {
        'email': authResult.user?.email,
        'displayName': authResult.user?.displayName,
      },
    );
    update();
  }

  void deleteData(BackupModel data) {}
}
