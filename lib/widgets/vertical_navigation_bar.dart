import 'package:flutter/material.dart';

import '../utils/constants.dart';

class VerticalNavigationMenuBar extends StatefulWidget {
  final List<NavBarMenuItem> menuItems;
  final Function(int index)? onTap;
  final int? currentIndex;
  final Color? selectedMenuColor;
  final Color? unSelectedMenuColor;
  final double iconSize;

  const VerticalNavigationMenuBar({
    Key? key,
    required this.menuItems,
    this.onTap,
    this.currentIndex,
    this.selectedMenuColor,
    this.unSelectedMenuColor,
    required this.iconSize,
  }) : super(key: key);

  @override
  State<VerticalNavigationMenuBar> createState() => _VerticalTabMenuState();
}

class _VerticalTabMenuState extends State<VerticalNavigationMenuBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(defaultSpace / 2),
        width: 70,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: Colors.white,
            border:
                Border(right: BorderSide(color: Colors.black12, width: .7))),
        child: Column(
          children: [
            ...widget.menuItems.map((menu) => InkWell(
                  onTap: () => widget.onTap!(widget.menuItems.indexOf(menu)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: defaultSpace + 8),
                    child: Icon(
                      menu.icon,
                      color:
                          widget.currentIndex == widget.menuItems.indexOf(menu)
                              ? primaryColor
                              : Colors.black45,
                      size: widget.iconSize,
                    ),
                  ),
                ))
          ],
        ));
  }
}

class NavBarMenuItem {
  final IconData icon;
  NavBarMenuItem({required this.icon});
}
