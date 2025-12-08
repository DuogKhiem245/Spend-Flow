class VietnameseUtils {
  static String toSortable(String text) {
    String str = text.toLowerCase();

    str = str.replaceAll(RegExp(r'[àáạảã]'), 'a');
    str = str.replaceAll(RegExp(r'[ăằắặẳẵ]'), 'a{');
    str = str.replaceAll(RegExp(r'[âầấậẩẫ]'), 'a|');

    str = str.replaceAll(RegExp(r'[đ]'), 'd{');

    str = str.replaceAll(RegExp(r'[èéẹẻẽ]'), 'e');
    str = str.replaceAll(RegExp(r'[êềếệểễ]'), 'e{');

    str = str.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');

    str = str.replaceAll(RegExp(r'[òóọỏõ]'), 'o');
    str = str.replaceAll(RegExp(r'[ôồốộổỗ]'), 'o{');
    str = str.replaceAll(RegExp(r'[ơờớợởỡ]'), 'o|');

    str = str.replaceAll(RegExp(r'[ùúụủũ]'), 'u');
    str = str.replaceAll(RegExp(r'[ưừứựửữ]'), 'u{');

    str = str.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');

    return str;
  }
}
