// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomsalse/models/room_model.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/widgets/widget_image_network.dart';
import 'package:roomsalse/widgets/widget_text.dart';

class WidgetListRoom extends StatelessWidget {
  const WidgetListRoom({
    Key? key,
    required this.roomModels,
  }) : super(key: key);

  final List<RoomModel> roomModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: roomModels.length,
      itemBuilder: (context, index) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WidgetImageNetwork(
              urlImage: roomModels[index].url,
              width: 180,
              height: 150,
            ),
          ),
          SizedBox(height: 150,
            child: WidgetText(
              data: roomModels[index].detail,
              textStyle: AppConstant().h3Style(),
            ),
          )
        ],
      ),
    );
  }
}
