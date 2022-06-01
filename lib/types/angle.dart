class Angle {
  num value;
  Angle({required this.value});

  @override
  String toString() {
    num angle = value % 360;
    return '$angle°';
  }
}
