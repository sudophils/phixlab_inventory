import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/inventory_data.dart';
import '../data/models/product_model.dart';
import '../main.dart';
import '../utils/constants.dart';
import 'button_wdget.dart';

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  Iterable<TableRow>? productList;
  Iterable<TableRow>? filteredProductList;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productList ??= productInventoryList
          .map((product) => _buildProductListItemTile(product));
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
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            margin: const EdgeInsets.only(
                left: defaultSpace * 2,
                top: defaultSpace,
                bottom: defaultSpace * 3,
                right: defaultSpace * 2),
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
                            border: Border.all(
                                color: Colors.grey.withOpacity(.4), width: .7),
                            borderRadius: BorderRadius.circular(4),
                            shape: BoxShape.rectangle,
                            color: backgroundColor.withOpacity(.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  CupertinoIcons.search,
                                  color: Colors.grey.withOpacity(.8),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: TextField(
                                  onChanged: (value) {
                                    if (value.length >= 3) {
                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                        setState(() {
                                          filteredProductList =
                                              productInventoryList
                                                  .where(
                                                      (element) =>
                                                          value
                                                              .toLowerCase() ==
                                                          element.category.name)
                                                  .map((product) =>
                                                      _buildProductListItemTile(
                                                          product));
                                          productList = filteredProductList;
                                        });
                                      });
                                    } else if (value.isEmpty) {
                                      setState(() {
                                        productList = productInventoryList.map(
                                            (product) =>
                                                _buildProductListItemTile(
                                                    product));
                                      });
                                    }
                                  },
                                  style: const TextStyle(fontSize: 12),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              )),
                              ButtonWidgetWithIcon(
                                onClick: () {
                                  print('filter clicked');
                                },
                                label: 'Filter',
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
                              label: 'Export',
                              borderColor: primaryColor,
                              labelAndIconColor: primaryColor,
                              borderRadius: 4,
                              onClick: () {
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
                                  color: primaryColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4)),
                              child: const Center(
                                child: Text(
                                  "New product",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Table(
                    columnWidths: const {
                      0: FixedColumnWidth(25),
                      1: FixedColumnWidth(70),
                      2: FixedColumnWidth(175),
                      3: FixedColumnWidth(120)
                    },
                    border: TableBorder(
                      top: BorderSide(
                          color: Colors.grey.withOpacity(.1), width: 1),
                      bottom: BorderSide(
                          color: Colors.grey.withOpacity(.1), width: 1),
                      horizontalInside: BorderSide(
                          color: Colors.grey.withOpacity(.1), width: 1.7),
                    ),
                    children: [_buildProductHeader(), ...?productList],
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            PaginationWidget(),
          ],
        ),
        const SizedBox(
          height: defaultSpace * 3,
        )
      ],
    );
  }

  TableRow _buildProductHeader() {
    return TableRow(children: [
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Checkbox(
            value: false,
            onChanged: (bool? value) {},
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Product Name",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black45),
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Category",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black45),
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "SKU",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black45),
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Variant",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black45),
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Price",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black45),
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Status",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black45),
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(),
        ),
      ),
    ]);
  }

  TableRow _buildProductListItemTile(Product product) {
    return TableRow(key: ValueKey(product.productPrice), children: [
      _buildProductItem(
        child: Checkbox(
          side: const BorderSide(color: Colors.grey, width: 1),
          focusColor: Colors.black45,
          onChanged: (checked) {},
          value: false,
        ),
      ),
      _buildProductItem(
        child: Image.network(
          product.productPhoto,
          errorBuilder: (context, e, _) {
            return Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle, color: Colors.blueGrey),
            );
          },
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        ),
      ),
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
          padding: const EdgeInsets.only(left: defaultSpace * 3),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              product.category.name.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.black87.withOpacity(.7)),
            ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  product.variantCount.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.black87.withOpacity(.7)),
                ),
              ),
              Row(
                children: [
                  const Text("Varies on: "),
                  ...product.productVariants.map((variant) => Flexible(
                        flex: 1,
                        child: Text(
                          variant.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.black87.withOpacity(.7)),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
      _buildProductItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '\$${product.productPrice.toString()}',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black87, fontWeight: FontWeight.w600),
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
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle, color: backgroundColor),
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.black.withOpacity(.5),
                    )))),
      )
    ]);
  }

  TableCell _buildProductItem({required Widget child}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: SizedBox(
        height: 70,
        child: Center(child: child),
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
