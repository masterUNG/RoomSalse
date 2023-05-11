import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/utility/app_controller.dart';
import 'package:roomsalse/utility/app_service.dart';
import 'package:roomsalse/utility/app_snackbar.dart';
import 'package:roomsalse/widgets/widget_button.dart';
import 'package:roomsalse/widgets/widget_form.dart';
import 'package:roomsalse/widgets/widget_image.dart';
import 'package:roomsalse/widgets/widget_text.dart';

class AddNewRoom extends StatefulWidget {
  const AddNewRoom({super.key});

  @override
  State<AddNewRoom> createState() => _AddNewRoomState();
}

class _AddNewRoomState extends State<AddNewRoom> {
  String? detail;
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          data: 'Add New Room',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: ListView(
        children: [
          Obx(() {
            return appController.files.isEmpty
                ? WidgetImage(
                    pathImage: 'images/camera.png',
                    size: 200,
                    tapFunc: () {
                      AppService().processTakePhoto();
                    },
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(
                        appController.files.last,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ],
                  );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                changeFunc: (p0) {
                  detail = p0.trim();
                },
                labelWidget: const WidgetText(data: 'Detail Room :'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WidgetButton(
                      label: 'Add New Room',
                      pressFunc: () {
                        if (detail?.isEmpty ?? true) {
                          AppSnackBar(
                                  title: 'Detail ?',
                                  message: 'Please Fill Detail')
                              .errorSnackBar();
                        } else if (appController.files.isEmpty) {
                          AppSnackBar(
                                  title: 'Photo ?',
                                  message: 'Please Take Photo')
                              .errorSnackBar();
                        } else {
                          AppService().processAddDetail(detail: detail!);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
