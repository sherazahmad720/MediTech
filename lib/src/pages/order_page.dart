import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_tech/Models/OrderList.dart';
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: _.order.length <= 0
                ? Text("Empty List")
                : ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: RaisedButton(
                            color: Colors.green,
                            child: Text("Save order"),
                            onPressed: () {
                              Get.back();
                              Get.back();
                              Get.back();

                              if (_.order.length > 0) {
// save in data base
                                OrdersList data2 = OrdersList(
                                  date: _.order[0].date,
                                  storeName: _.order[0].medicalStore,
                                );
                                dbController.saveOrderList(data2);
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
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Store: ${_.order[0].medicalStore}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(_.order[0].date)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                        height: 40,
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Quantity",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Medicine Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Action",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      for (var data in _.order)
                        Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text("${data.totalQty}"),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text("${data.medName}"),
                                ),
                                Expanded(
                                  child: Text("${data.price}"),
                                ),
                                Expanded(
                                  child: IconButton(
                                      icon:
                                          Icon(Icons.highlight_remove_outlined),
                                      onPressed: () {
                                        setState(() {
                                          _.order.removeWhere((element) =>
                                              element.medName == data.medName);
                                        });
                                      }),
                                )
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
