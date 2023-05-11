import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomsalse/models/user_model.dart';
import 'package:roomsalse/states/create_new_account.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/utility/app_controller.dart';
import 'package:roomsalse/utility/app_service.dart';
import 'package:roomsalse/utility/app_snackbar.dart';
import 'package:roomsalse/widgets/widget_button.dart';
import 'package:roomsalse/widgets/widget_form.dart';
import 'package:roomsalse/widgets/widget_image.dart';
import 'package:roomsalse/widgets/widget_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? email, password;
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 250,
                child: Row(
                  children: [
                    const WidgetImage(
                      size: 80,
                    ),
                    WidgetText(
                      data: 'Room\nSell',
                      textStyle: AppConstant().h2Style(),
                    )
                  ],
                ),
              ),
              WidgetForm(
                hint: 'Email',
                suffixWidget: const Icon(Icons.email_outlined),
                changeFunc: (p0) {
                  email = p0.trim();
                },
              ),
              WidgetForm(
                hint: 'Password',
                suffixWidget: const Icon(Icons.lock_outline),
                obsecu: true,
                changeFunc: (p0) {
                  password = p0.trim();
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WidgetButton(
                      label: 'Sign In',
                      pressFunc: () async {
                        if ((email?.isEmpty ?? true) ||
                            (password?.isEmpty ?? true)) {
                          AppSnackBar(
                                  title: 'Have Space',
                                  message: 'Please Fill EveryBlank')
                              .errorSnackBar();
                        } else {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email!, password: password!)
                              .then((value) async {
                            await FirebaseFirestore.instance
                                .collection('user')
                                .doc(value.user!.uid)
                                .get()
                                .then((value) {
                              UserModel userModel =
                                  UserModel.fromMap(value.data()!);
                              appController.loginUserModels.add(userModel);

                              Get.offAllNamed('/${userModel.typeUser}');

                              AppSnackBar(
                                      title: 'Login Success',
                                      message:
                                          'Welcome ${userModel.name} to App')
                                  .normalSnackBar();
                            });
                          }).catchError((onError) {
                            AppSnackBar(
                                    title: onError.code,
                                    message: onError.message)
                                .errorSnackBar();
                          });
                        }
                      },
                      size: 100,
                    ),
                    WidgetButton(
                      label: 'Sign Up',
                      pressFunc: () {
                        Get.to(const CreateNewAccount());
                      },
                      size: 100,
                      color: Colors.deepOrange,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
