class DateFormatterHelper {
  static ddMMyy({required String stringDate}) {
    DateTime id = DateTime.parse(stringDate);
    return "${id.day}-${id.month}-${id.year}";
  }
}
