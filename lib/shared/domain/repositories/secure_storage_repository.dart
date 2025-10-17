abstract class SecureStorageRepository {
  /// Save a string securely under the given key
  Future<void> write({required String key, required String value});

  /// Read a securely saved string
  Future<String?> read({required String key});

  /// Delete a value securely by key
  Future<void> delete({required String key});

  /// Delete all stored values
  Future<void> deleteAll();
}
