import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/utility/app_controller.dart';
import 'package:roomsalse/utility/app_dialog.dart';
import 'package:roomsalse/utility/app_service.dart';
import 'package:roomsalse/widgets/widget_icon_button.dart';
import 'package:roomsalse/widgets/widget_image.dart';
import 'package:roomsalse/widgets/widget_list_room.dart';
import 'package:roomsalse/widgets/widget_text.dart';
import 'package:roomsalse/widgets/widget_text_button.dart';

class BuyerMainHome extends StatefulWidget {
  const BuyerMainHome({super.key});

  @override
  State<BuyerMainHome> createState() => _BuyerMainHomeState();
}

class _BuyerMainHomeState extends State<BuyerMainHome> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().readAllRoomBuyer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const WidgetImage(),
        title: WidgetText(
          data: 'Buyer',
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
      body: Obx(() {
        return appController.buyerRoomModels.isEmpty
            ? const SizedBox()
            : WidgetListRoom(roomModels: appController.buyerRoomModels);
      }),
    );
  }
}
