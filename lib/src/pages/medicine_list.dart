import 'package:flutter/material.dart';
import 'package:medi_tech/src/widgets/dialoge.dart';
import 'package:medi_tech/src/widgets/medicine_card.dart';

class MedicineList extends StatefulWidget {
  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  String seachText = "";
  TextEditingController editingController = TextEditingController();
  Icon serachIcon = Icon(Icons.search, color: Colors.white);
  bool _isSearch = false;

  Widget appBar() {
    return Text("Medicines", style: TextStyle(fontSize: 14));
  }

  Widget searchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          seachText = value;
        });
      },
      controller: editingController,
      decoration: InputDecoration(
          hintText: "Search here",
          hintStyle: TextStyle(color: Colors.grey[300])),
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            icon: serachIcon,
            onPressed: () {
              setState(() {
                if (serachIcon.icon == Icons.search) {
                  serachIcon = Icon(Icons.cancel, color: Colors.white);
                  _isSearch = true;
                } else {
                  serachIcon = Icon(Icons.search, color: Colors.white);
                  _isSearch = false;
                }
              });
            })
      ], title: !_isSearch ? appBar() : searchBar()),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Medicine"),
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return MyDialog(
                  dialoagFor: "medicine",
                );
              });
        },
        isExtended: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return medicineCard("pic", "Peracitamole", "790");
                    }))
          ],
        ),
      ),
    );
  }
}
