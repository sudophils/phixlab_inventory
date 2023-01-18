import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ButtonWidgetWithIcon extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? borderColor;
  final Color? labelAndIconColor;
  final double? borderRadius;
  final Function() onTap;

  const ButtonWidgetWithIcon(
      {Key? key,
      required this.label,
      this.icon,
      this.borderColor,
      this.labelAndIconColor,
      this.borderRadius,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
              color: borderColor ?? Colors.grey.withOpacity(.4), width: .7),
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(defaultSpace / 2),
                  child: Text(
                    label,
                    style: TextStyle(
                        color:
                            labelAndIconColor ?? Colors.grey.withOpacity(.7)),
                  )),
              Icon(
                icon,
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
