import 'package:flutter/material.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';

class CategoryData {
  final List<CategoryModel> _categories = [
    // CategoryModel(
    //   title: 'Все',
    //   color: ColorPalette.purple1,
    // ),
    // CategoryModel(
    //   title: 'Семья',
    //   color: Color(0xFFFFD15C),
    // ),
    // CategoryModel(
    //   title: 'Дом',
    //   color: Color(0xFF6EA4FF),
    // ),
    // CategoryModel(
    //   title: 'Работа',
    //   color: Color(0xFF91E06C),
    // ),
    // CategoryModel(
    //   title: 'Хобби',
    //   color: Color(0xFF6CDAF2),
    // ),
    // CategoryModel(
    //   title: 'Покупки',
    //   color: Color(0xFFF97171),
    // ),
    // CategoryModel(
    //   title: 'Оплата',
    //   color: Color(0xFF6CE4AA),
    // ),
  ];

  List<CategoryModel> get categoryList => _categories;

  void addCategory(CategoryModel category) {
    _categories.add(category);
  }

  void removeCategory(CategoryModel category) {
    _categories.remove(category);
  }

  // void editCategory(int index, Color color, String title) {
  //   _categories[index]
  //     ..title = title
  //     ..color = color;
  // }
}
