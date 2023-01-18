import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phixlab_inventory/screens/main_content_screen.dart';
import 'package:phixlab_inventory/utils/constants.dart';
import 'package:phixlab_inventory/widgets/app_header.dart';
import 'package:phixlab_inventory/widgets/vertical_side_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phixlab Inventory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget buildMainContent({required int currentPage}) {
      switch (currentPage) {
        case 0:
          return const MainContent();
        case 1:
          return Container();
        case 2:
          return Container();
        case 3:
          return Container();
        case 4:
          return Container();
        default:
          return const MainContent();
      }
    }

    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Header
            const AppHeader(),
            // menu and content
            Expanded(
              child: Row(
                children: [
                  VerticalSideNavigationMenu(
                    onTap: (int index) {
                      print(index);
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    currentIndex: currentIndex,
                    menuItems: [
                      NavBarMenuItem(icon: CupertinoIcons.home),
                      NavBarMenuItem(icon: Icons.shopping_cart),
                      NavBarMenuItem(icon: CupertinoIcons.tag_solid),
                      NavBarMenuItem(icon: CupertinoIcons.group_solid),
                      NavBarMenuItem(icon: Icons.store),
                    ],
                    iconSize: 17,
                  ),
                  // Main content area
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currentIndex == 0)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: defaultSpace * 2, top: defaultSpace * 2),
                          child: Text(
                            "Products",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      Expanded(
                          child: buildMainContent(currentPage: currentIndex))
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
