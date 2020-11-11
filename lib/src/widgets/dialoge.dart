import 'dart:io';
import 'package:path/path.dart' as path;
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  final dialoagFor;

  MyDialog({this.dialoagFor});
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final nameController = TextEditingController();
  bool _isUploading = false;
  String errorText = "";
  String dropdownValue = "Inj";

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
                    style: TextStyle(color: Colors.indigo[600], fontSize: 20)),
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
                controller: nameController,
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
                        Text("Select Category"),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                          value: dropdownValue,
                          items: <String>['Tablet', 'Inj'].map((String value) {
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
                  color: Colors.indigo[600],
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
                        color: Colors.indigo[600],
                        child: Text("Add"),
                        onPressed: () {
                          if (nameController.text != "") {
                            setState(() {
                              _isUploading = true;
                            });
                            print('Add is pressed');
                          } else {
                            setState(() {
                              errorText = "Please Add Name of Category";
                            });
                            print('Field is empty');
                          }
                          // goToQuizPage("final", subject);
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
