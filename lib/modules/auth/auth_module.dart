import 'package:get/get.dart';

import '../common/storage/storage.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/storages/token_storage.dart';
import 'domain/repositories/auth_repository.dart';

class AuthModule {
  static void inject() async {
    Get.put<Storage>(SecureStorageImpl());

    final tokenStorageImpl = TokenStorage(Get.find());
    await tokenStorageImpl.init();
    Get.put<TokenStorage>(tokenStorageImpl);

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    // Get.lazyPut(() => AuthController(Get.find()));
  }
}
