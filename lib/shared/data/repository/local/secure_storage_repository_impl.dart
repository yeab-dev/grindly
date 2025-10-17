import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  final FlutterSecureStorage secureStorage;
  const SecureStorageRepositoryImpl({required this.secureStorage});

  @override
  Future<String?> read({required String key}) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<void> delete({required String key}) async {
    await secureStorage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
  }
}
