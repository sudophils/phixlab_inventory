import 'package:flutter/material.dart';

class ButtonWidgetWithIcon extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? borderColor;
  final Color? labelAndIconColor;
  final double? borderRadius;
  final Function() onClick;

  const ButtonWidgetWithIcon(
      {Key? key,
      required this.label,
      this.icon,
      this.borderColor,
      this.labelAndIconColor,
      this.borderRadius,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onClick,
      child: Container(
        width: 120,
        height: 45,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
                color: borderColor ?? Colors.grey.withOpacity(.4), width: .7),
            borderRadius: BorderRadius.circular(borderRadius ?? 0)),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: TextStyle(
                      color: labelAndIconColor ?? Colors.grey.withOpacity(.7)),
                ),
              ),
              Icon(
                icon ?? Icons.keyboard_arrow_down_outlined,
                color: labelAndIconColor ?? Colors.grey.withOpacity(.8),
                size: 19,
              )
            ],
          ),
        ),
      ),
    );
  }
}
