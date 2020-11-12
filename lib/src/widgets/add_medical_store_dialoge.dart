import 'package:get/get.dart';

import 'package:medi_tech/src/controllers/db_controller.dart';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../Models/MedicalStoreModel.dart';

class AddMedicalStoreDialog extends StatefulWidget {
  final dialoagFor;

  AddMedicalStoreDialog({this.dialoagFor});
  @override
  _AddMedicalStoreDialogState createState() => _AddMedicalStoreDialogState();
}

class _AddMedicalStoreDialogState extends State<AddMedicalStoreDialog> {
  final DbController dbController = Get.put(DbController());
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  bool _isUploading = false;
  String errorNameText = "";
  String errorAddressText = "";

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
              errorNameText,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(
                    hintText: "Enter Address",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                      ),
                    )),
              ),
            ),
            Text(
              errorAddressText,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
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
                          if (nameController.text != "" &&
                              addressController.text != "") {
                            MedicalStore data = MedicalStore(
                                // medId: 9,
                                name: nameController.text,
                                address: addressController.text,
                                status: "Active");
                            dbController
                                .saveMedicalStore(data)
                                .then((value) => Get.back());
                            // setState(() {
                            //   _isUploading = true;
                            // });
                            print('Add is pressed');
                          } else {
                            setState(() {
                              if (nameController.text == "") {
                                errorNameText =
                                    "Please Add Name of Medical Store...!";
                              }
                              if (nameController.text == "") {
                                errorNameText =
                                    "Please Add Name of Medical Store...!";
                              }
                              if (addressController.text == "") {
                                errorAddressText =
                                    "Please Add Address of Medical Store...!";
                              }
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
