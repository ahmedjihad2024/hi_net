
import 'package:get_it/get_it.dart';
import 'package:hi_net/presentation/views/edit_account/bloc/edit_account_bloc.dart';
import 'package:hi_net/presentation/views/notification/bloc/notification_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hi_net/app/services/app_preferences.dart';
import 'package:hi_net/data/data_source/data_source.dart';
import 'package:hi_net/data/network/api.dart';
import 'package:hi_net/data/network/dio_factory.dart';
import 'package:hi_net/data/network/internet_checker.dart';
import 'package:hi_net/data/repository/repository_impl.dart';


final instance = GetIt.instance;

Future initAppModules() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences));
  instance.registerFactory<DioFactory>(
      () => DioFactory(instance<AppPreferences>()));
  instance.registerFactory<NetworkConnectivity>(() => NetworkConnectivity());

  // ** Data
  instance
      .registerFactory<AppServices>(() => AppServices(instance<DioFactory>()));
  instance.registerLazySingleton<DataSource>(
      () => DataSource(instance<AppServices>()));
  instance.registerLazySingleton<Repository>(() =>
      Repository(instance<AppServices>(), instance<NetworkConnectivity>()));
  // **

  // ** Blocs
  instance.registerFactory<NotificationBloc>(() => NotificationBloc());
  instance.registerFactory<EditAccountBloc>(() => EditAccountBloc());

  // **

  // ** Usecases
  
  // **
}
