part of '../aveoauth.dart';
class EnumToString {
  static bool _isEnumItem(enumItem) {
    final splitEnum = enumItem.toString().split('.');
    return splitEnum.length > 1 &&
        splitEnum[0] == enumItem.runtimeType.toString();
  }

  static String convertToString(dynamic enumItem) {
    assert(enumItem != null);
    assert(_isEnumItem(enumItem),
        '$enumItem of type ${enumItem.runtimeType.toString()} is not an enum item');
    final tmp = enumItem.toString().split('.')[1];
    return tmp;
  }

  static String parse(enumItem) => convertToString(enumItem);
  
  static T? fromString<T>(List<T> enumValues, String value) {
    try {
      return enumValues.singleWhere((enumItem) =>
          EnumToString.convertToString(enumItem).toLowerCase() ==
          value.toLowerCase());
    } on StateError catch (_) {
      return null;
    }
  }

  static int indexOf<T>(List<T> enumValues, String value) {
    final fromStringResult = fromString<T>(enumValues, value);
    if (fromStringResult == null) {
      return -1;
    } else {
      return enumValues.indexOf(fromStringResult);
    }
  }

  static List<String> toList<T>(List<T> enumValues) {
    final enumList = enumValues.map((t) => EnumToString.convertToString(t));
    var output = <String>[];
    for (var value in enumList) {
      output.add(value);
    }
    return output;
  }

  static List<T?> fromList<T>(List<T> enumValues, List valueList) {
    return List<T?>.from(
        valueList.map<T?>((item) => fromString(enumValues, item)));
  }
}
