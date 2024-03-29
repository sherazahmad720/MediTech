import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medi_tech/Models/ordersModel.dart';

import 'package:medi_tech/src/controllers/db_controller.dart';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddQuantityDialog extends StatefulWidget {
  final medicineName;
  final medicinePrice;
  final date;
  final storeName;
  AddQuantityDialog(
      {this.medicineName, this.medicinePrice, this.date, this.storeName});
  @override
  _AddQuantityDialogState createState() => _AddQuantityDialogState();
}

class _AddQuantityDialogState extends State<AddQuantityDialog> {
  final DbController dbController = Get.put(DbController());
  final quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController bonusController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  bool _isUploading = false;
  String errorText = "";
  bool datafound = false;
  @override
  Widget build(BuildContext context) {
    priceController.text = widget.medicinePrice;
    return AlertDialog(
      content: Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                    child: Center(
                  child: Text("${widget.medicineName}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20)),
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  controller: quantityController,
                  decoration: InputDecoration(
                      hintText: "Enter quantity",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                        ),
                      )),
                ),
              ),
              Text(
                errorText,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                  ],
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  decoration: InputDecoration(
                      hintText: "Enter Price",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  keyboardType: TextInputType.number,
                  controller: bonusController,
                  decoration: InputDecoration(
                      hintText: "Enter Bonus",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                  ],
                  keyboardType: TextInputType.number,
                  controller: discountController,
                  decoration: InputDecoration(
                      hintText: "Enter Discount",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    // textColor: Colors.white,
                    // color: Theme.of(context).primaryColor,
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // goToQuizPage("mid", subject);
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  _isUploading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          // textColor: Colors.white,
                          // color: Theme.of(context).primaryColor,
                          child: Text("Add"),
                          onPressed: () {
                            if (quantityController.text != "") {
                              datafound = false;
                              for (var i = 0;
                                  i < dbController.order.length;
                                  i++) {
                                if (dbController.order[i].medName ==
                                    widget.medicineName) {
                                  datafound = true;
                                  print("data already present");
                                  dbController.order[i] = Orders(
                                      totalQty:
                                          (int.parse(dbController.order[i].totalQty) +
                                                  int.parse(
                                                      quantityController.text))
                                              .toString(),
                                      bonus: (dbController.order[i].bonus == ''
                                              ? 0
                                              : int.parse(dbController.order[i].bonus) +
                                                  (bonusController.text.trim() == ''
                                                      ? 0
                                                      : int.parse(bonusController
                                                          .text)))
                                          .toString(),
                                      date: dbController.order[i].date,
                                      medName: dbController.order[i].medName,
                                      medicalStore:
                                          dbController.order[i].medicalStore,
                                      price: priceController.text);
                                } else {}
                              }
                              if (!datafound) {
                                dbController.order.add(Orders(
                                    date: widget.date,
                                    medName: widget.medicineName,
                                    medicalStore: widget.storeName,
                                    price: priceController.text,
                                    totalQty: quantityController.text,
                                    bonus: bonusController.text,
                                    discount: "${discountController.text}%"));
                              }
                              Get.back();
                            } else {
                              setState(() {
                                errorText =
                                    "Please Add quantity of Medicine...!";
                              });
                              print('Field is empty');
                            }
                          },
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
