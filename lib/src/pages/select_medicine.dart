import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';
import 'package:medi_tech/src/pages/order_page.dart';

import 'package:medi_tech/src/widgets/medicine_card.dart';
import 'package:medi_tech/src/widgets/select_quantity_dialoge.dart';

class SelectMedicine extends StatefulWidget {
  final storeName;
  final date;
  final address;

  SelectMedicine({this.storeName, this.date, this.address});
  @override
  _SelectMedicineState createState() => _SelectMedicineState();
}

class _SelectMedicineState extends State<SelectMedicine> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.storeName}"),
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Get.to(OrderPage());
              })
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("Today Date"),
              //       IconButton(
              //           icon: Icon(Icons.calendar_today), onPressed: () {})
              //     ],
              //   ),
              // ),
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
                      itemCount: _.medicineList.length,
                      itemBuilder: (context, index) {
                        if (_.medicineList[index].name
                            .toLowerCase()
                            .contains(searchText.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              searchController.text = "";
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AddQuantityDialog(
                                        date: widget.date,
                                        storeName: widget.storeName,
                                        medicineName:
                                            _.medicineList[index].name,
                                        medicinePrice:
                                            _.medicineList[index].price);
                                  });
                            },
                            child: medicineCard(
                                _.medicineList[index].type,
                                _.medicineList[index].name,
                                _.medicineList[index].price),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                  //     child: ListView.builder(
                  //       itemBuilder: (_){
                  //         return
                  //       },
                  //   children: [
                  //     for (var data in _.medicalStoreList)
                  //       data.name.contains(searchText)
                  //           ? medicalStoreCard(

                  //               data.name, data.address, data.status)
                  //           : SizedBox()
                  //   ],
                  // )
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
