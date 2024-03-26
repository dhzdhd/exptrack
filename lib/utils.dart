extension StringUtils on String {
  String capitalize() {
    if (isEmpty) {
      return "";
    } else {
      return replaceRange(0, 1, this[0].toUpperCase());
    }
  }
}
