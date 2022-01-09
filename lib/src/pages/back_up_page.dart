import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medi_tech/Models/backup_model.dart';
import 'package:medi_tech/src/controllers/back_up_controller.dart';

class BackUpPage extends StatelessWidget {
  BackUpPage({Key? key}) : super(key: key);
  final BackUpController controller = Get.put(BackUpController());
  @override
  Widget build(BuildContext context) {
    controller.getBackUpList();
    return Scaffold(
      appBar: AppBar(
        title: Text('BackUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<BackUpController>(builder: (backUpController) {
          return FirebaseAuth.instance.currentUser == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'You are not logged in\nPlease login to backup your data'),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                          onPressed: () {
                            backUpController.loginWithGoogle();
                          },
                          icon: Icon(FontAwesome.google),
                          label: Text('Login with Google'))
                    ],
                  ),
                )
              : backUpController.isLoading
                  ? Center(
                      child: Lottie.asset('assets/animation/sync.json'),
                    )
                  : Column(
                      children: [
                        ListTile(
                          title: Text(
                              FirebaseAuth.instance.currentUser?.email ??
                                  'Email'),
                          subtitle: Text(
                              FirebaseAuth.instance.currentUser?.displayName ??
                                  'Name'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              backUpController.logout();
                            },
                            child: Text('Logout'),
                          ),
                        ),
                        Row(),
                        ElevatedButton.icon(
                          icon: Icon(FontAwesome.upload_cloud),
                          label: Text('BackUp Data'),
                          onPressed: () {
                            backUpController.backUpData();
                          },
                        ),
                        SizedBox(height: 8),
                        Expanded(
                            child: ListView.builder(
                          itemCount: backUpController.backupList.length,
                          itemBuilder: (context, index) {
                            BackupModel data =
                                backUpController.backupList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListTile(
                                tileColor: Colors.grey[200],
                                title: Text('${data.title}'),
                                subtitle: Text('${data.date}'),
                                trailing: ElevatedButton.icon(
                                  label: Text('Restore'),
                                  icon: Icon(Icons.restore),
                                  onPressed: () {
                                    backUpController.restoreData(data);
                                  },
                                ),
                              ),
                            );
                          },
                        ))
                      ],
                    );
        }),
      ),
    );
  }
}
