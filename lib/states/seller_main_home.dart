import 'package:flutter/material.dart';
import 'package:roomsalse/utility/app_constant.dart';
import 'package:roomsalse/widgets/widget_image.dart';
import 'package:roomsalse/widgets/widget_text.dart';

class SellerMainHome extends StatelessWidget {
  const SellerMainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const WidgetImage(),
        title: WidgetText(
          data: 'Seller',
          textStyle: AppConstant().h2Style(),
        ),
      ),
    );
  }
}
