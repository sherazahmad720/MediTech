import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';
import 'package:medi_tech/src/pages/order_details.dart';
// import 'package:medi_tech/src/widgets/add_medical_store_dialoge.dart';
import 'package:medi_tech/src/widgets/medical_store_card.dart';

class OrdersList extends StatefulWidget {
  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
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
                    data.storeName.contains(seachText) ||
                            data.date.contains(seachText)
                        ? InkWell(
                            onTap: () {
                              _
                                  .getSortedOrder(data.storeName, data.date)
                                  .then((value) => Get.to(OrderDetails(value)));
                            },
                            child:
                                medicalStoreCard(data.storeName, data.date, ""))
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
