class Converters {
  static Duration toDuration(double seconds) {
    final hoursInDouble = double.parse('${seconds / 3600}');
    final hours = hoursInDouble.toInt();
    final minutesInDouble = double.parse('${(hoursInDouble - hours) * 60}');
    final minutes = minutesInDouble.toInt();
    return Duration(hours: hours, minutes: minutes);
  }
}
