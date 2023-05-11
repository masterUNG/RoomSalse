import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomsalse/states/add_new_room.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/utility/app_service.dart';
import 'package:roomsalse/widgets/widget_button.dart';
import 'package:roomsalse/widgets/widget_image.dart';
import 'package:roomsalse/widgets/widget_text.dart';

class SellerMainHome extends StatefulWidget {
  const SellerMainHome({super.key});

  @override
  State<SellerMainHome> createState() => _SellerMainHomeState();
}

class _SellerMainHomeState extends State<SellerMainHome> {
  @override
  void initState() {
    super.initState();
    AppService().findUserModelLogin();
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
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return SizedBox(
          width: boxConstraints.maxWidth,
          height: boxConstraints.maxHeight,
          child: Stack(
            children: [
              Positioned(
                bottom: 16,
                right: 16,
                child: WidgetButton(
                  label: 'Add Room',
                  pressFunc: () {
                    Get.to(const AddNewRoom())!.then((value) {});
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
