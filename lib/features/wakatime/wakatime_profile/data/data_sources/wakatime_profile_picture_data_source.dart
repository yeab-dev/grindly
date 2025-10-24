import 'package:dio/dio.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

class WakatimeProfilePictureDataSource {
  final Dio dio;
  final SecureStorageRepository repository;
  final String _endpoint = "https://wakatime.com/api/v1/users/current";
  const WakatimeProfilePictureDataSource({
    required this.dio,
    required this.repository,
  });

  Future<String> getProfilePictureUrl() async {
    final accessToken = await repository.read(key: 'access_token');
    try {
      final response = await dio.get(
        _endpoint,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      if (response.statusCode == 200) {
        final String photoUrl = response.data['data']['photo'];
        return photoUrl;
      }
      throw Exception(response.statusMessage);
    } catch (e) {
      rethrow;
    }
  }
}
