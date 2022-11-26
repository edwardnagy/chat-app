// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/remote/firebase_injectable_module.dart' as _i14;
import 'core/repository/auth_repository.dart' as _i7;
import 'core/repository/direct_message_repository.dart' as _i9;
import 'core/repository/profile_repository.dart' as _i5;
import 'core/repository/user_repository.dart' as _i6;
import 'core/use_case/direct_messages/get_friends_use_case.dart' as _i12;
import 'core/use_case/direct_messages/get_messages_with_user_use_case.dart'
    as _i13;
import 'core/use_case/direct_messages/send_message_to_user_use_case.dart'
    as _i11;
import 'core/use_case/profile/create_profile_use_case.dart' as _i8;
import 'core/use_case/profile/get_profile_use_case.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.factory<_i5.ProfileRepository>(
      () => _i5.ProfileRepository(get<_i4.FirebaseFirestore>()));
  gh.factory<_i6.UserRepository>(
      () => _i6.UserRepository(get<_i4.FirebaseFirestore>()));
  gh.factory<_i7.AuthRepository>(
      () => _i7.AuthRepository(get<_i3.FirebaseAuth>()));
  gh.factory<_i8.CreateProfileUseCase>(() => _i8.CreateProfileUseCase(
        get<_i5.ProfileRepository>(),
        get<_i6.UserRepository>(),
        get<_i7.AuthRepository>(),
      ));
  gh.factory<_i9.DirectMessageRepository>(
      () => _i9.DirectMessageRepository(get<_i4.FirebaseFirestore>()));
  gh.factory<_i10.GetProfileUseCase>(() => _i10.GetProfileUseCase(
        get<_i5.ProfileRepository>(),
        get<_i7.AuthRepository>(),
        get<_i6.UserRepository>(),
      ));
  gh.factory<_i11.SendMessageToUserUseCase>(() => _i11.SendMessageToUserUseCase(
        get<_i9.DirectMessageRepository>(),
        get<_i10.GetProfileUseCase>(),
      ));
  gh.factory<_i12.GetFriendsUseCase>(() => _i12.GetFriendsUseCase(
        get<_i9.DirectMessageRepository>(),
        get<_i10.GetProfileUseCase>(),
      ));
  gh.factory<_i13.GetMessagesWithUserUseCase>(
      () => _i13.GetMessagesWithUserUseCase(
            get<_i9.DirectMessageRepository>(),
            get<_i10.GetProfileUseCase>(),
          ));
  return get;
}

class _$FirebaseInjectableModule extends _i14.FirebaseInjectableModule {}
