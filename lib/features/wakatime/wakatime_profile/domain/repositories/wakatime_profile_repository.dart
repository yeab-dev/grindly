import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';

abstract class WakatimeProfileRepository {
  Future<WakatimeUser?> getUserData();
}
