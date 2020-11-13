import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_tech/Models/ordersModel.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  DbController dbController = Get.put(DbController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DbController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Order"),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  if (_.order.length > 0) {
// save in data base

                    for (var i = 0; i <= _.order.length; i++) {
                      Orders data = Orders(
                          date: _.order[0].date,
                          medicalStore: _.order[0].medicalStore,
                          medName: _.order[i].medName,
                          price: _.order[i].price,
                          totalQty: _.order[i].totalQty);
                      dbController.saveOrder(data);
                    }
                  }
                })
          ],
        ),
        body: Container(
          child: _.order.length <= 0
              ? Text("Empty List")
              : ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_.order[0].medicalStore),
                        Text(_.order[0].date)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for (var data in _.order)
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${data.totalQty} x ${data.medName}          ${data.price}"),
                            IconButton(
                                icon: Icon(Icons.highlight_remove_outlined),
                                onPressed: () {
                                  setState(() {
                                    _.order.removeWhere((element) =>
                                        element.medName == data.medName);
                                  });
                                })
                          ],
                        ),
                      )
                  ],
                ),
        ),
      );
    });
  }
}
