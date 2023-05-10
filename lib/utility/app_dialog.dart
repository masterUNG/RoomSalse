// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/widgets/widget_image.dart';
import 'package:roomsalse/widgets/widget_text.dart';
import 'package:roomsalse/widgets/widget_text_button.dart';


class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context,
  });

  void normalDialog({
    required String title,
    Widget? iconWidget,
    Widget? contentWidget,
    Widget? firstButtonWidget,
    Widget? secondButtonWidget,
    String? pathImage,
    bool? cancelAction,
  }) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).primaryColorLight,
        icon: iconWidget ??
            WidgetImage(
            
            ),
        title: WidgetText(
          data: title,
          textStyle: AppConstant().h2Style(),
        ),
        content: contentWidget,
        actions: [
          firstButtonWidget ?? const SizedBox(),
          secondButtonWidget ??
              WidgetTextButton(
                label: 'Cancel',
               
                pressFunc: () {
                  Get.back();
                },
              ),
          cancelAction ?? false
              ? WidgetTextButton(
                  label: 'Cancel',
                  pressFunc: () {
                    Get.back();
                  },
                )
              : const SizedBox(),
        ],
        scrollable: true,
      ),
      barrierDismissible: false,
    );
  }

  
}
