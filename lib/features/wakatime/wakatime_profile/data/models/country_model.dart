import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/country.dart';

class CountryModel {
  final String countryName;
  final String countryCode;

  const CountryModel({required this.countryCode, required this.countryName});
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryName: json['country'],
      countryCode: json["country_code"],
    );
  }

  Map<String, dynamic> toMap() {
    return {"country_name": countryName, "country_code": countryCode};
  }

  Country toEntity() {
    return Country(countryName: countryName, countryCode: countryCode);
  }
}
