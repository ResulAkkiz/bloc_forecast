extension HeatTransformExtension on double {
  String get kelvinToCelsius => (this - 273.15).toStringAsFixed(1);
}
