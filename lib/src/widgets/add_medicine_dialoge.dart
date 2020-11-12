import 'package:get/get.dart';
import 'package:medi_tech/Models/MedicineModel.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddMedicineDialog extends StatefulWidget {
  final dialoagFor;

  AddMedicineDialog({this.dialoagFor});
  @override
  _AddMedicineDialogState createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends State<AddMedicineDialog> {
  final DbController dbController = Get.put(DbController());
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  bool _isUploading = false;
  String errorText = "";
  String dropdownValue = "Injections";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                  child: Center(
                child: Text("Add ${widget.dialoagFor}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20)),
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "Enter Name",
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
                child: Expanded(
                  child: Container(
                    height: 50,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Row(
                      children: [
                        Text("Select Category",
                            style: TextStyle(color: Colors.black45)),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                          value: dropdownValue,
                          items: <String>[
                            'Capsules',
                            'Drops',
                            'Injections',
                            'Liquid',
                            'Other',
                            'Tablet'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              dropdownValue = val;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
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
                    : RaisedButton(
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        child: Text("Add"),
                        onPressed: () {
                          if (nameController.text != "") {
                            // setState(() {
                            //   _isUploading = true;
                            // });
                            print('Add is pressed');
                            Medicine data = Medicine(
                                // medId: 9,
                                name: nameController.text,
                                price: priceController.text,
                                type: dropdownValue);
                            dbController
                                .saveMedicine(data)
                                .then((value) => Get.back());
                          } else {
                            setState(() {
                              errorText = "Please Add Name of Medicine...!";
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
    );
  }
}
