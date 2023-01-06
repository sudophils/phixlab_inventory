import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      margin: const EdgeInsets.only(
          left: defaultSpace * 2,
          top: defaultSpace,
          bottom: defaultSpace * 3,
          right: defaultSpace * 2),
    );
  }
}
