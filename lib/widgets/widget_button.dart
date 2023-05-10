// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:roomsalse/widgets/widget_text.dart';



class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.size,
    this.marginTopButton,
    this.color,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final double? size;
  final double? marginTopButton;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginTopButton ?? 0.0),
      width: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
        onPressed: pressFunc,
        child: WidgetText(data: label),
      ),
    );
  }
}
