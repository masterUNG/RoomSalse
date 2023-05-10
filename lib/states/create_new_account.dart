import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/utility/app_controller.dart';
import 'package:roomsalse/utility/app_snackbar.dart';
import 'package:roomsalse/widgets/widget_button.dart';
import 'package:roomsalse/widgets/widget_form.dart';
import 'package:roomsalse/widgets/widget_text.dart';


class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  var types = <String>[
    'Buyer',
    'Shopper',
  ];

  String? name, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: WidgetText(
          data: 'Create New Account',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('typeUsers ---> ${appController.appName}');
            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Name :',
                      changeFunc: (p0) {
                        name = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.only(top: 16),
                      decoration: AppConstant().borderBox(),
                      width: 250,
                      child: DropdownButton(
                        focusColor: Colors.white,
                        underline: const SizedBox(),
                        isExpanded: true,
                        hint: const WidgetText(data: 'Please Choose TypeUser'),
                        value: appController.typeUsers.last,
                        items: types
                            .map(
                              (e) => DropdownMenuItem(
                                child: WidgetText(data: e),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          appController.typeUsers.add(value);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Email :',
                      changeFunc: (p0) {
                        email = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Password :',
                      changeFunc: (p0) {
                        password = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetButton(
                      
                     
                      label: 'Create New Account',
                      pressFunc: () async {
                        if ((name?.isEmpty ?? true) ||
                            (email?.isEmpty ?? true) ||
                            (password?.isEmpty ?? true)) {
                          AppSnackBar(
                                
                                  title: 'Have Space ?',
                                  message: 'Please Fill Every Blank')
                              .errorSnackBar();
                        } else if (appController.typeUsers.length == 1) {
                          AppSnackBar(
                                 
                                  title: 'No Choose TypeUser ?',
                                  message: 'Please Choose Type User')
                              .errorSnackBar();
                        } else {
                         
                        }
                      },
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
