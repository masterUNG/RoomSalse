// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetImage extends StatelessWidget {
  const WidgetImage({
    Key? key,
    this.size,
    this.pathImage,
    this.tapFunc,
  }) : super(key: key);

  final double? size;
  final String? pathImage;
  final Function()? tapFunc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapFunc,
      child: Image.asset(
        pathImage ?? 'images/applogo.png',
        width: size,
        height: size,
      ),
    );
  }
}
