import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';
import 'package:medi_tech/src/pages/select_medicine.dart';
import 'package:medi_tech/src/widgets/medical_store_card.dart';

class SelectMedicalStore extends StatefulWidget {
  @override
  _SelectMedicalStoreState createState() => _SelectMedicalStoreState();
}

class _SelectMedicalStoreState extends State<SelectMedicalStore> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  String selectedDate = "12-9-2020";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take Order"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today Date"),
                    IconButton(
                        icon: Icon(Icons.calendar_today), onPressed: () {})
                  ],
                ),
              ),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.highlight_remove),
                    onPressed: () {
                      setState(() {
                        searchText = "";
                        searchController.text = "";
                      });
                    },
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Search here',
                ),
                onChanged: (val) {
                  setState(() {
                    {
                      searchText = val;
                    }
                  });
                },
              ),
              GetBuilder<DbController>(builder: (_) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: _.medicalStoreList.length,
                      itemBuilder: (context, index) {
                        if (_.medicalStoreList[index].name
                            .contains(searchText)) {
                          return InkWell(
                            onTap: () {
                              Get.to(SelectMedicine(
                                storeName: _.medicalStoreList[index].name,
                                date: selectedDate,
                              ));
                            },
                            child: medicalStoreCard(
                                _.medicalStoreList[index].name,
                                _.medicalStoreList[index].address,
                                _.medicalStoreList[index].status),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
