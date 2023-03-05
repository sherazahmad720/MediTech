import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';
import 'package:medi_tech/src/pages/order_details.dart';
// import 'package:medi_tech/src/widgets/add_medical_store_dialoge.dart';
import 'package:medi_tech/src/widgets/medical_store_card.dart';

class OrdersListPage extends StatefulWidget {
  @override
  _OrdersListPageState createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage> {
  DbController dbController = Get.put(DbController());

  String seachText = "";
  TextEditingController searchController = TextEditingController();

  Widget appBar() {
    return Text("Orders List", style: TextStyle(fontSize: 14));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(),
      ),
      body: Container(child: GetBuilder<DbController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.highlight_remove),
                    onPressed: () {
                      setState(() {
                        seachText = "";
                        searchController.text = "";
                      });
                    },
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Search here Medical Store or Date',
                ),
                onChanged: (val) {
                  setState(() {
                    {
                      seachText = val;
                    }
                  });
                },
              ),
              Expanded(
                  child: ListView(
                children: [
                  for (var data in _.orderList)
                    data.storeName
                                .toLowerCase()
                                .contains(seachText.toLowerCase()) ||
                            data.date.contains(seachText)
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
                                                "Are you want to Delete ${data.storeName} Orders on ${data.date}"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        .deleteOrderList(data
                                                            .listId
                                                            .toString());
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
                            onTap: () {
                              _.getSortedOrder(data.storeName, data.date).then(
                                  (value) => Get.to(() =>
                                      OrderDetails(value, data.storeAddress)));
                            },
                            child: medicalStoreCard(
                              data.storeName,
                              data.date,
                              "${data.storeAddress}",
                            ))
                        : SizedBox()
                ],
              ))
            ],
          ),
        );
      })),
    );
  }
}
