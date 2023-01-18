import 'package:flutter/material.dart';
import 'package:phixlab_inventory/utils/constants.dart';

class VerticalSideNavigationMenu extends StatefulWidget {
  final List<NavBarMenuItem> menuItems;
  final Function(int index)? onTap;
  final int? currentIndex;
  final double iconSize;

  const VerticalSideNavigationMenu(
      {Key? key,
      required this.menuItems,
      this.onTap,
      this.currentIndex,
      required this.iconSize})
      : super(key: key);

  @override
  State<VerticalSideNavigationMenu> createState() =>
      _VerticalSideNavigationMenuState();
}

class _VerticalSideNavigationMenuState
    extends State<VerticalSideNavigationMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultSpace / 2),
      width: 80,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: Colors.black12, width: .7))),
      child: Column(
        children: [
          ...widget.menuItems.map(
            (menu) => InkWell(
              onTap: () => widget.onTap!(widget.menuItems.indexOf(menu)),
              child: Padding(
                padding: const EdgeInsets.only(top: defaultSpace * 2),
                child: Icon(
                  menu.icon,
                  color: widget.currentIndex == widget.menuItems.indexOf(menu)
                      ? primaryColor
                      : Colors.black45,
                  size: widget.iconSize,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NavBarMenuItem {
  final IconData icon;

  NavBarMenuItem({required this.icon});
}
