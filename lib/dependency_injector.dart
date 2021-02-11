import 'core/database/fruts_database.dart';
import 'features/cart/data/data_sources/cart_local_data_source.dart';
import 'features/cart/data/data_sources/cart_local_data_source_implementation.dart';
import 'features/cart/data/repository/cart_repository_implementation.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/domain/use_cases/add_to_cart.dart';
import 'features/cart/domain/use_cases/get_all_cart_crops.dart';
import 'features/cart/domain/use_cases/remove_from_cart.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/crop/data/data_sources/crop_local_data_source.dart';
import 'features/crop/data/data_sources/crop_local_data_source_implementation.dart';
import 'features/crop/data/repository/crop_repository_implementation.dart';
import 'features/crop/domain/repositories/crop_repository.dart';
import 'features/crop/domain/use_cases/get_all_crops.dart';
import 'features/crop/presentation/blocs/tabs/tabs_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import 'core/presentation/blocs/navigation/navigation_bloc.dart';
import 'features/crop/presentation/blocs/crops/crops_bloc.dart';

final sl = GetIt.instance;
final StoreRef _cropStore = intMapStoreFactory.store('__crop_store__');
final StoreRef _cartStore = intMapStoreFactory.store('__cart_store__');

Future<void> init() async {
  // BLoCs
  sl.registerFactory<CropsBloc>(() => CropsBloc(useCase: sl()));
  sl.registerFactory<NavigationBloc>(() => NavigationBloc());
  sl.registerFactory<TabsBloc>(() => TabsBloc(useCase: sl()));
  sl.registerFactory<CartBloc>(
    () => CartBloc(
      getAllCartCrops: sl(),
      addToCart: sl(),
      removeFromCart: sl(),
    ),
  );

  // UseCase
  sl.registerLazySingleton<GetAllCrops>(() => GetAllCrops(repository: sl()));
  sl.registerLazySingleton<GetAllCartCrops>(
      () => GetAllCartCrops(repository: sl()));
  sl.registerLazySingleton<AddToCart>(() => AddToCart(repository: sl()));
  sl.registerLazySingleton<RemoveFromCart>(
      () => RemoveFromCart(repository: sl()));

  // Repository
  sl.registerLazySingleton<CropRepository>(
    () => CropRepositoryImplementation(source: sl()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImplementation(source: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CropLocalDataSource>(
    () => CropLocalDataSourceImplementation(
      database: sl(),
      store: _cropStore,
    ),
  );

  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImplementation(
      database: sl(),
      store: _cartStore,
      cropStore: _cropStore,
    ),
  );

  // External
  final frutsDatabase = await FrutsDatabase.init();
  sl.registerLazySingleton<FrutsDatabase>(() => frutsDatabase);
}
