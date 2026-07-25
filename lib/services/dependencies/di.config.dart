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
import '../../features/food_detail/data/datasources/_datasources.dart' as _i924;
import '../../features/food_detail/data/repositories/_repositories.dart'
    as _i36;
import '../../features/food_detail/domain/repositories/_repositories.dart'
    as _i593;
import '../../features/food_detail/presentation/cubit/_cubits.dart' as _i563;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i924.NutritionRemoteDataSource>(
      () => _i924.NutritionRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i242.CaptureLocalDataSource>(
      () => _i242.CaptureLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i924.MealRemoteDataSource>(
      () => _i924.MealRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i367.ClassificationLocalDataSource>(
      () => _i367.ClassificationLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i407.CaptureRepository>(
      () => _i1056.CaptureRepositoryImpl(gh<_i242.CaptureLocalDataSource>()),
    );
    gh.lazySingleton<_i593.NutritionRepository>(
      () => _i36.NutritionRepositoryImpl(gh<_i924.NutritionRemoteDataSource>()),
    );
    gh.lazySingleton<_i147.ClassificationRepository>(
      () => _i221.ClassificationRepositoryImpl(
        gh<_i367.ClassificationLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i593.MealRepository>(
      () => _i36.MealRepositoryImpl(gh<_i924.MealRemoteDataSource>()),
    );
    gh.factory<_i967.CaptureCubit>(
      () => _i967.CaptureCubit(
        gh<_i407.CaptureRepository>(),
        gh<_i147.ClassificationRepository>(),
      ),
    );
    gh.factory<_i563.FoodDetailCubit>(
      () => _i563.FoodDetailCubit(
        gh<_i593.MealRepository>(),
        gh<_i593.NutritionRepository>(),
      ),
    );
    return this;
  }
}
