import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';
import 'package:medi_tech/src/pages/medicalstore_list.dart';
import 'package:medi_tech/src/pages/medicine_list.dart';
import 'package:medi_tech/src/pages/orders_list.dart';
import 'package:medi_tech/src/pages/select_medical_store.dart';
import 'package:medi_tech/src/widgets/heading_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DbController dbController = Get.put(DbController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MediTech"),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: Container(child: GetBuilder<DbController>(
        builder: (_) {
          return Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(MedicalStoreList());
                      },
                      child: HeadingCard(
                        color: Color(0xffFF5151),
                        count: _.totalMedicalstores,
                        heading: "Mediacal \nStores",
                        icon: Icon(Icons.store, color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // dbController.getMedicineList();
                        Get.to(MedicineList());
                      },
                      child: HeadingCard(
                          color: Color(0xff2DCE89),
                          count: _.totalMedicines,
                          heading: "Medicines\n",
                          icon:
                              Icon(FontAwesome.ambulance, color: Colors.white)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(OrdersList());
                      },
                      child: HeadingCard(
                        color: Color(0xff5D78E3),
                        count: _.totalOrders,
                        heading: "Orders\n",
                        icon: Icon(
                          FontAwesome.clipboard,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(SelectMedicalStore());
                      },
                      child: HeadingCard(
                          color: Color(0xffFE662D),
                          count: "",
                          heading: "Take \n Orders",
                          icon: Icon(
                            FontAwesome.cart_plus,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
