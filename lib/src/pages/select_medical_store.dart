import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';
import 'package:medi_tech/src/pages/select_medicine.dart';
import 'package:medi_tech/src/widgets/medical_store_card.dart';

class SelectMedicalStore extends StatefulWidget {
  @override
  _SelectMedicalStoreState createState() => _SelectMedicalStoreState();
}

String selectedDate = "";
DateTime now = DateTime.now();

class _SelectMedicalStoreState extends State<SelectMedicalStore> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";

  // String selectedDate = "12-9-2020";
  @override
  Widget build(BuildContext context) {
    selectedDate = DateFormat('yyyy-MM-dd').format(now);
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
                    Text("Selected Date  $selectedDate"),
                    IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          selectDate();
                        })
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
                        if ((_.medicalStoreList[index].name)
                            .toLowerCase()
                            .contains(searchText.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              _.address = _.medicalStoreList[index].address;
                              _.order.clear();

                              Get.to(() => SelectMedicine(
                                    storeName: _.medicalStoreList[index].name,
                                    date: selectedDate,
                                    address: _.medicalStoreList[index].address,
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

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != selectedDate) {
      setState(() {
        now = picked;
      });
    }
  }
}
