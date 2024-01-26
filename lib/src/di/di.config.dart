// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/datasources/hotel_datasource.dart' as _i3;
import '../data/datasources/hotel_datasource_impl.dart' as _i4;
import '../data/repositories/hotel_repository_impl.dart' as _i6;
import '../domain/repositories/hotel_repository.dart' as _i5;
import '../domain/usecases/get_hotels_usecase.dart' as _i7;
import '../domain/usecases/get_rooms_usecase.dart' as _i8;
import '../domain/usecases/get_tours_usecase.dart' as _i9;
import '../presentation/blocs/hotel/hotel_bloc.dart' as _i10;
import '../presentation/blocs/reservation/reservation_bloc.dart' as _i11;
import '../presentation/blocs/rooms/rooms_bloc.dart' as _i12;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.HotelDatasource>(_i4.HotelDataSourceImpl());
  gh.singleton<_i5.HotelRepository>(
      _i6.HotelRepositoryImpl(gh<_i3.HotelDatasource>()));
  gh.singleton<_i7.GetHotelsUsecase>(
      _i7.GetHotelsUsecase(gh<_i5.HotelRepository>()));
  gh.singleton<_i8.GetRoomsUsecase>(
      _i8.GetRoomsUsecase(gh<_i5.HotelRepository>()));
  gh.singleton<_i9.GetToursUsecase>(
      _i9.GetToursUsecase(gh<_i5.HotelRepository>()));
  gh.factory<_i10.HotelBloc>(
      () => _i10.HotelBloc(getHotelsUsecase: gh<_i7.GetHotelsUsecase>()));
  gh.factory<_i11.ReservationBloc>(
      () => _i11.ReservationBloc(getToursUsecase: gh<_i9.GetToursUsecase>()));
  gh.factory<_i12.RoomsBloc>(
      () => _i12.RoomsBloc(getRoomsUsecase: gh<_i8.GetRoomsUsecase>()));
  return getIt;
}
