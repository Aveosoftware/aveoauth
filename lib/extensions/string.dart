extension StringExtension on String {
  bool stringToBool(String value) {
    bool newValue = value == 'Y' || value == 'y' ? true : false;
    return newValue;
  }
}
