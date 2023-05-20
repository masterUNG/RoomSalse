import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/utility/app_controller.dart';
import 'package:roomsalse/utility/app_dialog.dart';
import 'package:roomsalse/utility/app_service.dart';
import 'package:roomsalse/utility/app_snackbar.dart';
import 'package:roomsalse/widgets/widget_button.dart';
import 'package:roomsalse/widgets/widget_form.dart';
import 'package:roomsalse/widgets/widget_image.dart';
import 'package:roomsalse/widgets/widget_text.dart';
import 'package:roomsalse/widgets/widget_text_button.dart';

class AddNewRoom extends StatefulWidget {
  const AddNewRoom({super.key});

  @override
  State<AddNewRoom> createState() => _AddNewRoomState();
}

class _AddNewRoomState extends State<AddNewRoom> {
  String? detail, price, priceEle, amount;
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
                      AppDialog(context: context).normalDialog(
                          title: 'Image Source',
                          iconWidget: const WidgetImage(
                            pathImage: 'images/camera.png',
                            size: 150,
                          ),
                          firstButtonWidget: WidgetTextButton(
                            label: 'Camera',
                            pressFunc: () {
                              AppService()
                                  .processTakePhoto(
                                      imageSource: ImageSource.camera)
                                  .then((value) => Get.back());
                            },
                          ),
                          secondButtonWidget: WidgetTextButton(
                            label: 'Gallery',
                            pressFunc: () {
                              AppService()
                                  .processTakePhoto(
                                      imageSource: ImageSource.gallery)
                                  .then((value) => Get.back());
                            },
                          ));
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
              WidgetForm(
                changeFunc: (p0) {
                  price = p0.trim();
                },
                labelWidget: const WidgetText(data: 'ราคาห้อง :'),
                textInputType: TextInputType.number,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                changeFunc: (p0) {
                  priceEle = p0.trim();
                },
                labelWidget: const WidgetText(data: 'ราคาค่าไฟต่อหน่วย :'),
                textInputType: TextInputType.number,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                changeFunc: (p0) {
                  amount = p0.trim();
                },
                labelWidget: const WidgetText(data: 'จำนวนห้อง :'),
                textInputType: TextInputType.number,
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
                        if ((detail?.isEmpty ?? true) ||
                            (price?.isEmpty ?? true) ||
                            (priceEle?.isEmpty ?? true) ||
                            (amount?.isEmpty ?? true)) {
                          AppSnackBar(
                                  title: 'Have Space ?',
                                  message: 'Please Fill EveryBlank')
                              .errorSnackBar();
                        } else if (appController.files.isEmpty) {
                          AppSnackBar(
                                  title: 'Photo ?',
                                  message: 'Please Take Photo')
                              .errorSnackBar();
                        } else {
                          AppService().processAddDetail(
                              detail: detail!,
                              price: price!,
                              priceEle: priceEle!,
                              amount: amount!);
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
