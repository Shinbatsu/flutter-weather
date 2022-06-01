// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 4;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      daily: (fields[0] as List)
          .map((dynamic e) => (e as List).cast<dynamic>())
          .toList(),
      hourly: (fields[1] as List)
          .map((dynamic e) => (e as List).cast<dynamic>())
          .toList(),
      lat: fields[2] as num,
      lon: fields[3] as num,
      sunrise: fields[4] as num,
      sunset: fields[5] as num,
      hourlyTemp: (fields[6] as List).cast<int>(),
      hourlyHumidity: (fields[7] as List).cast<int>(),
      temp: fields[8] as num,
      tempMin: fields[9] as num,
      tempMax: fields[10] as num,
      weatherType: fields[11] as String,
      windSpeed: fields[12] as num,
      windDeg: fields[13] as num,
      dateDay: fields[14] as int,
      dateMonth: fields[15] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.daily)
      ..writeByte(1)
      ..write(obj.hourly)
      ..writeByte(2)
      ..write(obj.lat)
      ..writeByte(3)
      ..write(obj.lon)
      ..writeByte(4)
      ..write(obj.sunrise)
      ..writeByte(5)
      ..write(obj.sunset)
      ..writeByte(6)
      ..write(obj.hourlyTemp)
      ..writeByte(7)
      ..write(obj.hourlyHumidity)
      ..writeByte(8)
      ..write(obj.temp)
      ..writeByte(9)
      ..write(obj.tempMin)
      ..writeByte(10)
      ..write(obj.tempMax)
      ..writeByte(11)
      ..write(obj.weatherType)
      ..writeByte(12)
      ..write(obj.windSpeed)
      ..writeByte(13)
      ..write(obj.windDeg)
      ..writeByte(14)
      ..write(obj.dateDay)
      ..writeByte(15)
      ..write(obj.dateMonth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
