class Converters {
  static Duration toDuration(double seconds) {
    final hoursInDouble = double.parse('${seconds / 3600}');
    final hours = hoursInDouble.toInt();
    final minutes = int.parse('${(hoursInDouble - hours) * 60}').toInt();
    return Duration(hours: hours, minutes: minutes);
  }
}
