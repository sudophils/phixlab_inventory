import 'package:flutter/material.dart';

import '../utils/constants.dart';

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
