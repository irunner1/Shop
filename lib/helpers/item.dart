import 'package:flutter/material.dart';


class CategoryItem {
  String name;
  // ignore: prefer_typing_uninitialized_variables
  final icon;

  CategoryItem({
    required this.name,
    required this.icon,
  });
}

var category = [
  CategoryItem(
    name: 'Phone',
    icon: Icons.smartphone,
  ),
  CategoryItem(
    name: 'Computer',
    icon: Icons.computer,
  ),
  CategoryItem(
    name: 'Health',
    icon: Icons.heart_broken,
  ),
  CategoryItem(
    name: 'Books',
    icon: Icons.book,
  ),
  CategoryItem(
    name: 'Smthng',
    icon: Icons.smartphone,
  )
];