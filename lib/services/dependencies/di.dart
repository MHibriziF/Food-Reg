import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final GetIt get = GetIt.I;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  get.registerSingleton<Dio>(
    Dio(BaseOptions(connectTimeout: const Duration(seconds: 5))),
  );
  get.init();
}
