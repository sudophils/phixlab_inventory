import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LeftSideBar extends StatefulWidget {
  late int currentIndex;

  LeftSideBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<LeftSideBar> createState() => _LeftSideBarState();
}

class _LeftSideBarState extends State<LeftSideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultSpace / 2),
      width: 100,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: Colors.black12, width: .7))),
      child: NavigationRail(
        selectedIndex: widget.currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        labelType: NavigationRailLabelType.selected,
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: Text('First'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.book),
            label: Text('Second'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.star_border),
            selectedIcon: Icon(Icons.star),
            label: Text('Third'),
          ),
        ],
      ),
    );
  }
}
