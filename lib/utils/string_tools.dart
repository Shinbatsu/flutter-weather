extension StringCasingExtension on String {
  String toCapitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalize())
      .join(' ');
  String strToIcon() => length > 0
      ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
          .replaceAll(RegExp(' '), '')
      : '';
}
