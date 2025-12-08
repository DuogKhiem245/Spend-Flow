import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String? l10nKey;
  final String iconKey;
  final Color color;

  CategoryModel({
    required this.name,
    this.l10nKey,
    required this.iconKey,
    required this.color,
  });

  static final List<CategoryModel> suggestedCategories = [
    CategoryModel(
      name: 'Ăn uống',
      l10nKey: 'category_food',
      iconKey: 'food',
      color: Colors.orange,
    ),
    CategoryModel(
      name: 'Di chuyển',
      l10nKey: 'category_transport',
      iconKey: 'transport',
      color: Colors.blue,
    ),
    CategoryModel(
      name: 'Mua sắm',
      l10nKey: 'category_shopping',
      iconKey: 'shopping',
      color: Colors.purple,
    ),
  ];

  static final List<CategoryModel> sampleCategories = [
    CategoryModel(
      name: 'Ăn uống',
      l10nKey: 'category_food',
      iconKey: 'food',
      color: Colors.orange,
    ),
    CategoryModel(
      name: 'Di chuyển',
      l10nKey: 'category_transport',
      iconKey: 'transport',
      color: Colors.blue,
    ),
    CategoryModel(
      name: 'Lương',
      l10nKey: 'category_salary',
      iconKey: 'salary',
      color: Colors.green,
    ),
    CategoryModel(
      name: 'Mua sắm',
      l10nKey: 'category_shopping',
      iconKey: 'shopping',
      color: Colors.purple,
    ),
    CategoryModel(
      name: 'Giải trí',
      l10nKey: 'category_entertainment',
      iconKey: 'entertainment',
      color: Colors.pink,
    ),

    CategoryModel(
      name: 'Nhà cửa',
      l10nKey: 'category_house',
      iconKey: 'house',
      color: Colors.brown,
    ),
    CategoryModel(
      name: 'Hóa đơn',
      l10nKey: 'category_bill',
      iconKey: 'bill',
      color: Colors.blueGrey,
    ),
    CategoryModel(
      name: 'Điện',
      l10nKey: 'category_electricity',
      iconKey: 'electricity',
      color: Colors.amber,
    ),
    CategoryModel(
      name: 'Nước',
      l10nKey: 'category_water',
      iconKey: 'water',
      color: Colors.lightBlue,
    ),
    CategoryModel(
      name: 'Internet',
      l10nKey: 'category_internet',
      iconKey: 'internet',
      color: Colors.indigoAccent,
    ),
    CategoryModel(
      name: 'Gas',
      l10nKey: 'category_gas',
      iconKey: 'gas',
      color: Colors.deepOrangeAccent,
    ),
    CategoryModel(
      name: 'Sửa chữa',
      l10nKey: 'category_repair',
      iconKey: 'repair',
      color: Colors.grey,
    ),
    CategoryModel(
      name: 'Vệ sinh',
      l10nKey: 'category_cleaning',
      iconKey: 'cleaning',
      color: Colors.teal,
    ),
    CategoryModel(
      name: 'Điện thoại',
      l10nKey: 'category_phone',
      iconKey: 'phone',
      color: Colors.indigo,
    ),

    CategoryModel(
      name: 'Sức khỏe',
      l10nKey: 'category_health',
      iconKey: 'health',
      color: Colors.redAccent,
    ),
    CategoryModel(
      name: 'Bảo hiểm',
      l10nKey: 'category_insurance',
      iconKey: 'insurance',
      color: Colors.cyan,
    ),
    CategoryModel(
      name: 'Thể thao',
      l10nKey: 'category_sport',
      iconKey: 'sport',
      color: Colors.lightGreen,
    ),
    CategoryModel(
      name: 'Làm đẹp',
      l10nKey: 'category_beauty',
      iconKey: 'beauty',
      color: Colors.pinkAccent,
    ),

    CategoryModel(
      name: 'Giáo dục',
      l10nKey: 'category_education',
      iconKey: 'education',
      color: Colors.deepPurpleAccent,
    ),
    CategoryModel(
      name: 'Em bé',
      l10nKey: 'category_baby',
      iconKey: 'baby',
      color: Colors.lime,
    ),
    CategoryModel(
      name: 'Thú cưng',
      l10nKey: 'category_pet',
      iconKey: 'pet',
      color: Colors.orangeAccent,
    ),

    CategoryModel(
      name: 'Trò chơi',
      l10nKey: 'category_game',
      iconKey: 'game',
      color: Colors.deepPurple,
    ),
    CategoryModel(
      name: 'Âm nhạc',
      l10nKey: 'category_music',
      iconKey: 'music',
      color: Colors.purpleAccent,
    ),
    CategoryModel(
      name: 'Du lịch',
      l10nKey: 'category_travel',
      iconKey: 'travel',
      color: Colors.lightBlueAccent,
    ),
    CategoryModel(
      name: 'Quà tặng',
      l10nKey: 'category_gift',
      iconKey: 'gift',
      color: Colors.red,
    ),

    CategoryModel(
      name: 'Tiết kiệm',
      l10nKey: 'category_savings',
      iconKey: 'savings',
      color: Colors.greenAccent,
    ),
    CategoryModel(
      name: 'Thuế',
      l10nKey: 'category_tax',
      iconKey: 'tax',
      color: Colors.blueGrey,
    ),
  ];
  
}
