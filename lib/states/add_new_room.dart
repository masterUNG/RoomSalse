import 'package:flutter/material.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/widgets/widget_button.dart';
import 'package:roomsalse/widgets/widget_form.dart';
import 'package:roomsalse/widgets/widget_text.dart';

class AddNewRoom extends StatefulWidget {
  const AddNewRoom({super.key});

  @override
  State<AddNewRoom> createState() => _AddNewRoomState();
}

class _AddNewRoomState extends State<AddNewRoom> {
  String? detail;

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
                      pressFunc: () {},
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
