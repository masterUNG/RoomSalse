// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roomsalse/models/room_model.dart';
import 'package:roomsalse/models/user_model.dart';
import 'package:roomsalse/utility/app_controller.dart';
import 'package:path/path.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> readAllRoomBuyer() async {
    if (appController.buyerRoomModels.isNotEmpty) {
      appController.buyerRoomModels.clear();
    }

    await FirebaseFirestore.instance
        .collection('user')
        .where('typeUser', isEqualTo: 'Seller')
        .get()
        .then((value) async {
      print('value readAllRoomBuyer ----> ${value.docs.length}');
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(element.id)
              .collection('room')
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              for (var element in value.docs) {
                RoomModel roomModel = RoomModel.fromMap(element.data());
                appController.buyerRoomModels.add(roomModel);
              }
            }
          });
        }
      }
    });
  }

  Future<void> readRoomSeller() async {
    if (appController.sellerRoomModels.isNotEmpty) {
      appController.sellerRoomModels.clear();
    }

    await FirebaseFirestore.instance
        .collection('user')
        .doc(appController.loginUserModels.last.uid)
        .collection('room')
        .get()
        .then((value) {
      print('value --->>> ${value.docs.length}');
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          RoomModel roomModel = RoomModel.fromMap(element.data());
          appController.sellerRoomModels.add(roomModel);
        }
      }
    });
  }

  Future<void> processTakePhoto() async {
    var result = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 800, maxHeight: 800);
    if (result != null) {
      appController.files.add(File(result.path));
    }
  }

  Future<void> processAddDetail(
      {required String detail,
      required String price,
      required String priceEle,
      required String amount}) async {
    print(
        'loginUserModel at processAddDetail ---> ${appController.loginUserModels.length}');

    String nameFile = basename(appController.files.last.path);
    print('nameFile --> $nameFile');

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child('room/$nameFile');
    UploadTask uploadTask = reference.putFile(appController.files.last);
    await uploadTask.whenComplete(() async {
      await reference.getDownloadURL().then((value) async {
        String url = value.toString();
        print('url --> $url');
        RoomModel roomModel = RoomModel(
            detail: detail,
            url: url,
            price: price,
            priceEle: priceEle,
            amount: amount);
        await FirebaseFirestore.instance
            .collection('user')
            .doc(appController.loginUserModels.last.uid)
            .collection('room')
            .doc()
            .set(roomModel.toMap())
            .then((value) {
          appController.files.clear();
          Get.back();
        });
      });
    });
  }

  Future<void> findUserModelLogin() async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      if (value.data() != null) {
        UserModel userModel = UserModel.fromMap(value.data()!);
        print('loginUserModel at findUserModelLogin ---> ${userModel.toMap()}');
        appController.loginUserModels.add(userModel);
      }
    });
  }
}
