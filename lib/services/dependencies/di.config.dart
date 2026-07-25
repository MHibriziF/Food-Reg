// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/capture/data/datasources/_datasources.dart' as _i242;
import '../../features/capture/data/repositories/_repositories.dart' as _i1056;
import '../../features/capture/domain/repositories/_repositories.dart' as _i407;
import '../../features/capture/presentation/cubit/_cubits.dart' as _i967;
import '../../features/classification/data/datasources/_datasources.dart'
    as _i367;
import '../../features/classification/data/repositories/_repositories.dart'
    as _i221;
import '../../features/classification/domain/repositories/_repositories.dart'
    as _i147;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i242.CaptureLocalDataSource>(
      () => _i242.CaptureLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i367.ClassificationLocalDataSource>(
      () => _i367.ClassificationLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i407.CaptureRepository>(
      () => _i1056.CaptureRepositoryImpl(gh<_i242.CaptureLocalDataSource>()),
    );
    gh.lazySingleton<_i147.ClassificationRepository>(
      () => _i221.ClassificationRepositoryImpl(
        gh<_i367.ClassificationLocalDataSource>(),
      ),
    );
    gh.factory<_i967.CaptureCubit>(
      () => _i967.CaptureCubit(
        gh<_i407.CaptureRepository>(),
        gh<_i147.ClassificationRepository>(),
      ),
    );
    return this;
  }
}
