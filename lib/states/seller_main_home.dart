import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomsalse/states/add_new_room.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/utility/app_controller.dart';
import 'package:roomsalse/utility/app_dialog.dart';
import 'package:roomsalse/utility/app_service.dart';
import 'package:roomsalse/widgets/widget_button.dart';
import 'package:roomsalse/widgets/widget_icon_button.dart';
import 'package:roomsalse/widgets/widget_image.dart';
import 'package:roomsalse/widgets/widget_list_room.dart';
import 'package:roomsalse/widgets/widget_text.dart';
import 'package:roomsalse/widgets/widget_text_button.dart';

class SellerMainHome extends StatefulWidget {
  const SellerMainHome({super.key});

  @override
  State<SellerMainHome> createState() => _SellerMainHomeState();
}

class _SellerMainHomeState extends State<SellerMainHome> {
  @override
  void initState() {
    super.initState();
    AppService()
        .findUserModelLogin()
        .then((value) => AppService().readRoomSeller());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const WidgetImage(),
        title: WidgetText(
          data: 'Seller',
          textStyle: AppConstant().h2Style(),
        ),
         actions: [
          WidgetIconButton(
            iconData: Icons.exit_to_app,
            pressFunc: () {
              AppDialog(context: context).normalDialog(
                  iconWidget: const Icon(
                    Icons.exit_to_app,
                    size: 64,
                  ),
                  title: 'Confirm Sign Out',
                  firstButtonWidget: WidgetTextButton(
                    label: 'Confirm',
                    pressFunc: () {
                      AppService().processSignOut();
                    },
                  ),
                  secondButtonWidget: WidgetTextButton(
                    label: 'Cancel',
                    pressFunc: () {
                      Get.back();
                    },
                  ));
            },
          )
        ],
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              print('roomModels ---> ${appController.sellerRoomModels.length}');
              return SizedBox(
                width: boxConstraints.maxWidth,
                height: boxConstraints.maxHeight,
                child: Stack(
                  children: [
                    appController.sellerRoomModels.isEmpty ? const SizedBox() : WidgetListRoom(roomModels: appController.sellerRoomModels) ,
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: WidgetButton(
                        label: 'Add Room',
                        pressFunc: () {
                          Get.to(const AddNewRoom())!.then((value) {
                            AppService().readRoomSeller();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
