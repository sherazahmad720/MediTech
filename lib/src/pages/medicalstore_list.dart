import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';
import 'package:medi_tech/src/widgets/add_medical_store_dialoge.dart';

import 'package:medi_tech/src/widgets/medical_store_card.dart';

class MedicalStoreList extends StatefulWidget {
  @override
  _MedicalStoreListState createState() => _MedicalStoreListState();
}

class _MedicalStoreListState extends State<MedicalStoreList> {
  final DbController dbController = Get.put(DbController());
  String seachText = "";
  TextEditingController editingController = TextEditingController();
  Icon serachIcon = Icon(Icons.search, color: Colors.white);
  bool _isSearch = false;

  Widget appBar() {
    return Text("Medical Stores", style: TextStyle(fontSize: 14));
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
      appBar: AppBar(actions: [
        IconButton(
            icon: serachIcon,
            onPressed: () {
              setState(() {
                if (serachIcon.icon == Icons.search) {
                  serachIcon = Icon(Icons.cancel, color: Colors.white);
                  _isSearch = true;
                } else {
                  serachIcon = Icon(Icons.search, color: Colors.white);
                  _isSearch = false;
                }
              });
            })
      ], title: !_isSearch ? appBar() : searchBar()),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Store"),
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return AddMedicalStoreDialog(
                  dialoagFor: "Medical Store",
                );
              });
        },
        isExtended: true,
      ),
      body: Container(child: GetBuilder<DbController>(builder: (_) {
        return Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                for (var data in _.medicalStoreList)
                  data.name.toLowerCase().contains(seachText.toLowerCase())
                      ? GestureDetector(
                          onLongPress: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    content: Container(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "Are you want to Delete ${data.name}"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  dbController
                                                      .deleteMedicalStore(
                                                          data.id.toString());
                                                  Get.back();
                                                },
                                                child: Text("Yes"),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: medicalStoreCard(
                              data.name, data.address, data.status))
                      : SizedBox()
              ],
            ))
          ],
        );
      })),
    );
  }
}
