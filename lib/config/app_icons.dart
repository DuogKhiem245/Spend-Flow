import 'package:flutter/cupertino.dart';

class AppIcons {
  static final Map<String, IconData> icons = {
    'food': CupertinoIcons.cart_fill,
    'transport': CupertinoIcons.car_detailed,
    'salary': CupertinoIcons.money_dollar_circle_fill,
    'shopping': CupertinoIcons.bag_fill,
    'game': CupertinoIcons.game_controller_solid,
    'house': CupertinoIcons.house_fill,
    'gift': CupertinoIcons.gift_fill,
    'health': CupertinoIcons.heart_fill,
    'entertainment': CupertinoIcons.tv_fill,
    'bill': CupertinoIcons.doc_text_fill,
    'insurance': CupertinoIcons.shield_fill,
    'education': CupertinoIcons.book_fill,
    'pet': CupertinoIcons.tortoise_fill,
    'travel': CupertinoIcons.airplane,
    'savings': CupertinoIcons.creditcard_fill,
    'phone': CupertinoIcons.phone_fill,
    'internet': CupertinoIcons.wifi,
    'water': CupertinoIcons.drop_fill,
    'electricity': CupertinoIcons.bolt_fill,
    'gas': CupertinoIcons.flame_fill,
    'cleaning': CupertinoIcons.clear,
    'beauty': CupertinoIcons.sparkles,
    'baby': CupertinoIcons.heart_circle_fill,
    'sport': CupertinoIcons.sportscourt_fill,
    'music': CupertinoIcons.music_note_2,
    'repair': CupertinoIcons.wrench_fill,
    'tax': CupertinoIcons.chart_pie_fill,
  };

  static IconData getIcon(String key) {
    return icons[key] ?? CupertinoIcons.question_circle;
  }
}
