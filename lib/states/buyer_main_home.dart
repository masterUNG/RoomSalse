import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/utility/app_controller.dart';
import 'package:roomsalse/utility/app_service.dart';
import 'package:roomsalse/widgets/widget_image.dart';
import 'package:roomsalse/widgets/widget_list_room.dart';
import 'package:roomsalse/widgets/widget_text.dart';

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
      ),
      body: Obx(() {
        return appController.buyerRoomModels.isEmpty
            ? const SizedBox()
            : WidgetListRoom(roomModels: appController.buyerRoomModels);
      }),
    );
  }
}
