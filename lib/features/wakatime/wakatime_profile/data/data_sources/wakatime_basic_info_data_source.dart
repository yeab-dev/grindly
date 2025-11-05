import 'package:dio/dio.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

class WakatimeBasicInfoDataSource {
  final Dio dio;
  final SecureStorageRepository repository;
  final String _endpoint = "https://wakatime.com/api/v1/users/current";
  const WakatimeBasicInfoDataSource({
    required this.dio,
    required this.repository,
  });

  Future<Map<String, dynamic>> getBasicUserInfo() async {
    final accessToken = await repository.read(key: 'access_token');
    try {
      final response = await dio.get(
        _endpoint,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      if (response.statusCode == 200) {
        final String id = response.data['data']['id'];
        final String photoUrl = response.data['data']['photo'];
        final country = response.data['data']['city'];
        return {"id": id, "photo_url": photoUrl, "country": country};
      }
      throw Exception(response.statusMessage);
    } catch (e) {
      rethrow;
    }
  }
}
