import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String newText = newValue.text.replaceAll(RegExp(r'[^0-9,]'), '');

    if (newText.indexOf(',') != newText.lastIndexOf(',')) {
      return oldValue;
    }

    List<String> parts = newText.split(',');
    String integerPart = parts[0];
    String? decimalPart = parts.length > 1 ? parts[1] : null;

    if (integerPart.length > 1 && integerPart.startsWith('0')) {
      integerPart = integerPart.substring(1);
    } else if (integerPart.isEmpty && newText.contains(',')) {
      integerPart = '0'; 
    }

    integerPart = integerPart.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );

    String finalString = integerPart;
    if (parts.length > 1 || newText.endsWith(',')) {
      finalString += ',';
      if (decimalPart != null) {
        if (decimalPart.length > 2) {
          decimalPart = decimalPart.substring(0, 2);
        }
        finalString += decimalPart;
      }
    }

    return TextEditingValue(
      text: finalString,
      selection: TextSelection.collapsed(offset: finalString.length),
    );
  }
}
