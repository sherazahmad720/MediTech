import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_tech/Models/OrderList.dart';
import 'package:medi_tech/Models/ordersModel.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';
import 'package:medi_tech/src/pages/home_page.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  DbController dbController = Get.put(DbController());
  int totalAmount = 0;

  Widget totalText() {
    totalAmount = 0;
    for (int i = 0; i < dbController.order.length; i++) {
      totalAmount = totalAmount +
          (double.parse(dbController.order[i].price) *
                  double.parse(dbController.order[i].totalQty))
              .toInt();
    }
    return Text("Total Amount is ${totalAmount.toString()}",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

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
                            onPressed: () async {
                              Get.offAll(HomePage());

                              if (_.order.length > 0) {
// save in data base
                                OrdersListModel data2 = OrdersListModel(
                                  date: _.order[0].date,
                                  storeName: _.order[0].medicalStore,
                                  storeAddress: _.address,
                                );
                                await dbController.saveOrderList(data2);
                                for (var i = 0; i < _.order.length; i++) {
                                  Orders data = Orders(
                                    date: _.order[0].date,
                                    medicalStore: _.order[0].medicalStore,
                                    medName: _.order[i].medName,
                                    price: _.order[i].price,
                                    totalQty: _.order[i].totalQty,
                                    bonus: _.order[i].bonus,
                                    discount: _.order[i].discount,
                                  );
                                  await dbController.saveOrder(data);
                                }
                                _.order.clear();
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
                                "Store: ${_.order[0].medicalStore} (${_.address})",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(_.order[0].date)
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      totalText(),
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
                                  "Discount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
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
                                  child: Text(data.bonus == ''
                                      ? "${data.totalQty}"
                                      : "${data.totalQty}+${data.bonus}"),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text("${data.medName}"),
                                ),
                                Expanded(
                                  child: Text("${data.price}"),
                                ),
                                Expanded(
                                  child: Text("${data.discount}"),
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
                        ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
