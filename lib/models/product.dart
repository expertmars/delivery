import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final int quanity;
  final int stock;
  final String unit;
  final String imageUrl;
  final String description;
  final int categoryId;

  Product({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.quanity,
    @required this.unit,
    @required this.stock,
    @required this.description,
    @required this.imageUrl,
    @required this.categoryId,
  });
}
