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

  @override
  Widget build(BuildContext context) {
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
                      if (currentIndex == 0)
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

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.keyboard_arrow_left),
          ),
          ProductPageLabel(
            pageNo: 1,
          ),
          ProductPageLabel(
            pageNo: 2,
          ),
          ProductPageLabel(
            pageNo: 3,
          ),
          ProductPageLabel(
            isCurrentPage: true,
            pageNo: 4,
          ),
          ProductPageLabel(
            pageNo: 5,
          ),
          ProductPageLabel(
            pageNo: "...",
          ),
          ProductPageLabel(
            pageNo: "20",
          ),
          Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }
}

class ProductPageLabel extends StatelessWidget {
  final dynamic pageNo;
  final bool? isCurrentPage;

  const ProductPageLabel({Key? key, required this.pageNo, this.isCurrentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isCurrentPage ?? false ? primaryColor : Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Center(
            child: Text(
          "$pageNo",
          style: TextStyle(
              color: isCurrentPage ?? false ? Colors.white : Colors.black87),
        )),
      ),
    );
  }
}
