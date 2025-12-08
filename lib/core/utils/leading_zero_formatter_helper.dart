import 'package:flutter/services.dart';

class LeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (text.isEmpty || text == '0') {
      return newValue;
    }

    if (text.startsWith('0') &&
        !text.startsWith('0,') &&
        !text.startsWith('0.')) {
      String newText = text;
      while (newText.startsWith('0') &&
          newText.length > 1 &&
          !newText.startsWith('0,') &&
          !newText.startsWith('0.')) {
        newText = newText.substring(1);
      }

      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    return newValue;
  }
}
