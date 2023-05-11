// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roomsalse/models/user_model.dart';
import 'package:roomsalse/utility/app_controller.dart';

class AppService {
  AppController appController = Get.put(AppController());

  

  Future<void> processTakePhoto() async {
    var result = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 800, maxHeight: 800);
    if (result != null) {
      appController.files.add(File(result.path));
    }
  }

  Future<void> processAddDetail({required String detail}) async {
    print(
        'loginUserModel at processAddDetail ---> ${appController.loginUserModels.length}');
  }

  Future<void> findUserModelLogin() async {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        print('uid login at findUserModelLogin --> ${event.uid}');
        await FirebaseFirestore.instance
            .collection('user')
            .doc(event.uid)
            .get()
            .then((value) {
          if (value.data() != null) {
            UserModel userModel = UserModel.fromMap(value.data()!);
            print(
                'loginUserModel at findUserModelLogin ---> ${userModel.toMap()}');
            appController.loginUserModels.add(userModel);
          }
        });
      }
    });
  }
}
