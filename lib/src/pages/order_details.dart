import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_tech/Models/ordersModel.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';

class OrderDetails extends StatefulWidget {
  final List<Orders> orders;
  OrderDetails(this.orders);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DbController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Detailed Order"),
            titleSpacing: 4,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Store: ${widget.orders[0].medicalStore}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(widget.orders[0].date)
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
                          // Expanded(
                          //   child: Text(
                          //     "Action",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.white),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  for (var data in widget.orders)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
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
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
