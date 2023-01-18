import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/inventory_data.dart';
import '../data/models/product_model.dart';
import '../utils/constants.dart';
import '../widgets/button_widget.dart';
import '../widgets/pagination_widget.dart';

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  Iterable<TableRow> productList = [];
  Iterable<TableRow>? filteredProductList;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productList =
          productInventoryList.map((product) => _buildProductRowTile(product));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(defaultSpace),
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultSpace / 2)),
                color: Colors.white,
                shape: BoxShape.rectangle),
            margin: const EdgeInsets.only(
                top: defaultSpace * 2,
                left: defaultSpace,
                right: defaultSpace * 2,
                bottom: defaultSpace * 3),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: defaultSpace * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 400,
                          height: 40,
                          decoration: BoxDecoration(
                              color: backgroundColor.withOpacity(.5),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(.4),
                                  width: .7),
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(defaultSpace / 2),
                                child: Icon(CupertinoIcons.search,
                                    color: Colors.grey.withOpacity(.8)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultSpace),
                                  child: TextField(
                                    onChanged: (searchTerm) {
                                      if (searchTerm.length >= 2) {
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          filteredProductList =
                                              productInventoryList
                                                  .where(
                                                      (product) =>
                                                          product.productName
                                                              .contains(
                                                                  searchTerm) ||
                                                          product.productPrice
                                                              .toString()
                                                              .contains(
                                                                  searchTerm) ||
                                                          product.category.name
                                                              .contains(
                                                                  searchTerm))
                                                  .map((product) =>
                                                      _buildProductRowTile(
                                                          product));
                                          setState(() {
                                            productList = filteredProductList!;
                                          });
                                        });
                                      } else if (searchTerm.isEmpty == true) {
                                        final list = productInventoryList.map(
                                            (product) =>
                                                _buildProductRowTile(product));
                                        setState(() {
                                          productList = list;
                                        });
                                      }
                                    },
                                    style: TextStyle(fontSize: 12),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              ButtonWidgetWithIcon(
                                icon: Icons.keyboard_arrow_down_outlined,
                                label: 'Filter',
                                onTap: () {
                                  print("filter clicked");
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: defaultSpace / 2,
                        ),
                        Row(
                          children: [
                            ButtonWidgetWithIcon(
                              borderColor: primaryColor,
                              borderRadius: 4,
                              labelAndIconColor: primaryColor,
                              icon: Icons.keyboard_arrow_down_outlined,
                              label: 'Export',
                              onTap: () {
                                print("export clicked");
                              },
                            ),
                            const SizedBox(
                              width: defaultSpace / 2,
                            ),
                            Container(
                              width: 120,
                              height: 45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "New Product",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Table(
                    columnWidths: const {
                      0: FixedColumnWidth(25),
                      1: FixedColumnWidth(70),
                      2: FixedColumnWidth(175),
                      3: FixedColumnWidth(120),
                      4: FixedColumnWidth(150),
                      5: FixedColumnWidth(170),
                    },
                    border: TableBorder(
                        top: BorderSide(
                            color: Colors.grey.withOpacity(.1), width: 1),
                        bottom: BorderSide(
                            color: Colors.grey.withOpacity(.1), width: 1),
                        horizontalInside: BorderSide(
                            color: Colors.grey.withOpacity(.1), width: 1)),
                    children: [
                      _buildProductHeader(),
                      ...productList,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [PaginationWidget()],
        ),
        const SizedBox(
          height: defaultSpace * 3,
        )
      ],
    );
  }

  TableRow _buildProductRowTile(Product product) {
    return TableRow(key: ValueKey(product.productPrice), children: [
      _buildProductItem(
          child: Checkbox(
              side: const BorderSide(color: Colors.grey, width: 1),
              focusColor: Colors.black45,
              value: false,
              onChanged: (value) {})),
      _buildProductItem(
          child: Image.network(
        product.productPhoto,
        width: 40,
        errorBuilder: (context, err, _) {
          return Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.blueGrey, shape: BoxShape.rectangle));
        },
      )),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.productName,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black87.withOpacity(.7)),
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.category.name.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black87.withOpacity(.7)),
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.productSku,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black87.withOpacity(.7)),
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.variantCount.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.black87.withOpacity(.7)),
              ),
              Row(
                children: [
                  const Text("Varies on: "),
                  ...product.productVariants.map((variant) => Flexible(
                          child: Text(
                        '${variant.name},',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.black87.withOpacity(.7)),
                      )))
                ],
              )
            ],
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '\$${product.productPrice.toString()}',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Colors.black87.withOpacity(.7),
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 35,
            width: 120,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: product.status.name == "active"
                    ? Colors.green.withOpacity(.3)
                    : Colors.red.withOpacity(.3),
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Text(
                friendlyStatus(product.status),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    color: product.status.name == "active"
                        ? Colors.green
                        : Colors.red),
              ),
            ),
          ),
        ),
      ),
      TableCell(
          child: Container(
        padding: const EdgeInsets.symmetric(vertical: defaultSpace + 6),
        child: Center(
          child: Container(
            height: 25,
            width: 25,
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle, color: backgroundColor),
            child: Icon(
              Icons.more_horiz,
              size: 17,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ),
      )),
    ]);
  }

  TableRow _buildProductHeader() {
    return TableRow(children: [
      _buildProductItem(
          child: Padding(
        padding: const EdgeInsets.all(defaultSpace / 2),
        child: Checkbox(value: false, onChanged: (value) {}),
      )),
      _buildProductItem(child: Container()),
      _buildProductItem(
          child: const Padding(
        padding: EdgeInsets.all(defaultSpace / 2),
        child: Text("Product Name"),
      )),
      _buildProductItem(
          child: const Padding(
        padding: EdgeInsets.all(defaultSpace / 2),
        child: Text("Category"),
      )),
      _buildProductItem(
          child: const Padding(
        padding: EdgeInsets.all(defaultSpace / 2),
        child: Text("SKU"),
      )),
      _buildProductItem(
          child: const Padding(
        padding: EdgeInsets.all(defaultSpace / 2),
        child: Text("Variant"),
      )),
      _buildProductItem(
          child: const Padding(
        padding: EdgeInsets.all(defaultSpace / 2),
        child: Text("Price"),
      )),
      _buildProductItem(
          child: const Padding(
        padding: EdgeInsets.all(defaultSpace / 2),
        child: Text("Status"),
      )),
      _buildProductItem(child: Container()),
    ]);
  }

  TableCell _buildProductItem({required Widget child}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: SizedBox(
        height: 70,
        child: Center(
          child: child,
        ),
      ),
    );
  }

  friendlyStatus(ProductStatus status) {
    switch (status) {
      case ProductStatus.outOfStock:
        return "Out of Stock";
      case ProductStatus.active:
        return "Active";
    }
  }
}
