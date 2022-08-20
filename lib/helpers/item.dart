import 'package:flutter/material.dart';


class CategoryItem {
  String name;
  bool isActive;
  // ignore: prefer_typing_uninitialized_variables
  final icon;

  CategoryItem({
    required this.name,
    required this.icon,
    required this.isActive,
  });
}

var category = [
  CategoryItem(
    name: 'Phone',
    icon: Icons.smartphone,
    isActive: true,
  ),
  CategoryItem(
    name: 'Computer',
    icon: Icons.computer,
    isActive: false,
  ),
  CategoryItem(
    name: 'Health',
    icon: Icons.heart_broken,
    isActive: false,
  ),
  CategoryItem(
    name: 'Books',
    icon: Icons.book,
    isActive: false,
  ),
  CategoryItem(
    name: 'Smthng',
    icon: Icons.smartphone,
    isActive: false,
  )
];