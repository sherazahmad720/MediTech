import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';
import 'package:medi_tech/src/widgets/add_medical_store_dialoge.dart';

class MedicalStoreList extends StatefulWidget {
  @override
  _MedicalStoreListState createState() => _MedicalStoreListState();
}

class _MedicalStoreListState extends State<MedicalStoreList> {
  DbController dbController = Get.put(DbController());

  String seachText = "";
  TextEditingController editingController = TextEditingController();
  Icon searchIcon = Icon(Icons.search, color: Colors.white);
  bool _isSearch = false;

  Widget appBar() {
    return Text("Medicines", style: TextStyle(fontSize: 14));
  }

  Widget searchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          seachText = value;
        });
      },
      controller: editingController,
      decoration: InputDecoration(
          hintText: "Search here",
          hintStyle: TextStyle(color: Colors.grey[300])),
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_isSearch ? appBar() : searchBar(),
        actions: [
          IconButton(
              icon: searchIcon,
              onPressed: () {
                setState(() {
                  if (searchIcon.icon == Icons.search) {
                    searchIcon = Icon(Icons.cancel, color: Colors.white);
                    _isSearch = true;
                  } else {
                    searchIcon = Icon(Icons.search, color: Colors.white);
                    _isSearch = false;
                  }
                });
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return AddMedicalStoreDialog(
                  dialoagFor: "Medical Stores",
                );
              });
        },
        label: Text(
          'Add Medical Store',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
