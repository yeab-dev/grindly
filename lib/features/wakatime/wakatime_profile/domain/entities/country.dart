import 'package:grindly/features/wakatime/wakatime_profile/data/models/country_model.dart';

class Country {
  final String countryName;
  final String countryCode;

  const Country({required this.countryName, required this.countryCode});

  CountryModel toModel() {
    return CountryModel(countryCode: countryCode, countryName: countryName);
  }
}
