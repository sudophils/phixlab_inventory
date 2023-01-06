import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phixlab_inventory/utils/constants.dart';
import 'package:phixlab_inventory/widgets/app_header.dart';
import 'package:phixlab_inventory/widgets/main_content.dart';
import 'package:phixlab_inventory/widgets/vertical_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'phixlab inventory',
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

  Widget buildMainContent({required int currentPage}) {
    switch (currentPage) {
      case 0:
        return const MainContent();
      case 1:
        return const Center(child: Text("Cart"));
      case 2:
        return const Center(child: Text("Favorite"));
      case 3:
        return const Center(child: Text("Customers"));
      case 4:
        return const Center(child: Text("Store front"));
      default:
        return const MainContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: backgroundColor,
      child: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: Row(
              children: [
                VerticalNavigationMenuBar(
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
                    iconSize: 19),

                /// Main content area
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: defaultSpace * 2, top: defaultSpace * 2),
                        child: Text(
                          "Products",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                      Expanded(
                          child: buildMainContent(currentPage: currentIndex)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
