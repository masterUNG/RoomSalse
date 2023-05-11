import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:roomsalse/models/user_model.dart';
import 'package:roomsalse/utility/app_controller.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processAddDetail({required String detail}) async {
    print('loginUserModel at processAddDetail ---> ${appController.loginUserModels.length}');
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
