enum ProductCategory {
  clothing,
  shoes,
  bag,
  jewelry,
}

enum ProductVariant { color, size, material }

enum ProductStatus { active, outOfStock }

class Product {
  final String productName;
  final String productPhoto;
  final ProductCategory category;
  final String productSku;
  final int variantCount;
  final List<ProductVariant> productVariants;
  final num productPrice;
  final ProductStatus status;

  Product({
    required this.variantCount,
    required this.productPhoto,
    required this.productName,
    required this.category,
    required this.productSku,
    required this.productVariants,
    required this.productPrice,
    required this.status,
  });
}
