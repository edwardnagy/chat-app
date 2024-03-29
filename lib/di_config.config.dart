// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/firebase/firebase_injectable_module.dart' as _i30;
import 'data/firebase/repository/auth_repository_firebase_impl.dart' as _i10;
import 'data/firebase/repository/channel_repository_firestore_impl.dart'
    as _i12;
import 'data/firebase/repository/direct_message_repository_impl.dart' as _i15;
import 'data/firebase/repository/profile_repository_firestore_impl.dart' as _i6;
import 'data/firebase/repository/user_repository_firestore_impl.dart' as _i8;
import 'domain/repository/auth_repository.dart' as _i9;
import 'domain/repository/channel_repository.dart' as _i11;
import 'domain/repository/direct_message_repository.dart' as _i14;
import 'domain/repository/profile_repository.dart' as _i5;
import 'domain/repository/user_repository.dart' as _i7;
import 'domain/use_case/channel/create_channel_use_case.dart' as _i22;
import 'domain/use_case/channel/delete_channel_use_case.dart' as _i23;
import 'domain/use_case/channel/get_all_channels_use_case.dart' as _i16;
import 'domain/use_case/channel/get_channel_thread_use_case.dart' as _i24;
import 'domain/use_case/channel/get_channels_to_join_use_case.dart' as _i29;
import 'domain/use_case/channel/get_joined_channels_use_case.dart' as _i26;
import 'domain/use_case/channel/get_owned_channels_use_case.dart' as _i28;
import 'domain/use_case/channel/join_channel_use_case.dart' as _i18;
import 'domain/use_case/channel/quit_channel_use_case.dart' as _i19;
import 'domain/use_case/channel/send_message_to_channel_use_case.dart' as _i20;
import 'domain/use_case/direct_messages/get_friends_use_case.dart' as _i25;
import 'domain/use_case/direct_messages/get_messages_with_user_use_case.dart'
    as _i27;
import 'domain/use_case/direct_messages/send_message_to_user_use_case.dart'
    as _i21;
import 'domain/use_case/profile/create_profile_use_case.dart' as _i13;
import 'domain/use_case/profile/get_profile_use_case.dart'
    as _i17; // ignore_for_file: unnecessary_lambdas

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
      () => _i6.ProfileRepositoryFirestoreImpl(get<_i4.FirebaseFirestore>()));
  gh.factory<_i7.UserRepository>(
      () => _i8.UserRepositoryFirestoreImpl(get<_i4.FirebaseFirestore>()));
  gh.factory<_i9.AuthRepository>(
      () => _i10.AuthRepositoryFirebaseImpl(get<_i3.FirebaseAuth>()));
  gh.factory<_i11.ChannelRepository>(
      () => _i12.ChannelRepositoryFirestoreImpl(get<_i4.FirebaseFirestore>()));
  gh.factory<_i13.CreateProfileUseCase>(() => _i13.CreateProfileUseCase(
        get<_i5.ProfileRepository>(),
        get<_i7.UserRepository>(),
        get<_i9.AuthRepository>(),
      ));
  gh.factory<_i14.DirectMessageRepository>(() =>
      _i15.DirectMessageRepositoryFirestoreImpl(get<_i4.FirebaseFirestore>()));
  gh.factory<_i16.GetAllChannelsUseCase>(
      () => _i16.GetAllChannelsUseCase(get<_i11.ChannelRepository>()));
  gh.factory<_i17.GetProfileUseCase>(() => _i17.GetProfileUseCase(
        get<_i5.ProfileRepository>(),
        get<_i9.AuthRepository>(),
        get<_i7.UserRepository>(),
      ));
  gh.factory<_i18.JoinChannelUseCase>(() => _i18.JoinChannelUseCase(
        get<_i11.ChannelRepository>(),
        get<_i17.GetProfileUseCase>(),
      ));
  gh.factory<_i19.QuitChannelUseCase>(() => _i19.QuitChannelUseCase(
        get<_i11.ChannelRepository>(),
        get<_i17.GetProfileUseCase>(),
      ));
  gh.factory<_i20.SendMessageToChannelUseCase>(
      () => _i20.SendMessageToChannelUseCase(
            get<_i11.ChannelRepository>(),
            get<_i17.GetProfileUseCase>(),
          ));
  gh.factory<_i21.SendMessageToUserUseCase>(() => _i21.SendMessageToUserUseCase(
        get<_i14.DirectMessageRepository>(),
        get<_i17.GetProfileUseCase>(),
      ));
  gh.factory<_i22.CreateChannelUseCase>(() => _i22.CreateChannelUseCase(
        get<_i11.ChannelRepository>(),
        get<_i17.GetProfileUseCase>(),
      ));
  gh.factory<_i23.DeleteChannelUseCase>(() => _i23.DeleteChannelUseCase(
        get<_i11.ChannelRepository>(),
        get<_i17.GetProfileUseCase>(),
      ));
  gh.factory<_i24.GetChannelThreadUseCase>(() => _i24.GetChannelThreadUseCase(
        get<_i11.ChannelRepository>(),
        get<_i17.GetProfileUseCase>(),
      ));
  gh.factory<_i25.GetFriendsUseCase>(() => _i25.GetFriendsUseCase(
        get<_i14.DirectMessageRepository>(),
        get<_i17.GetProfileUseCase>(),
      ));
  gh.factory<_i26.GetJoinedChannelsUseCase>(() => _i26.GetJoinedChannelsUseCase(
        get<_i11.ChannelRepository>(),
        get<_i17.GetProfileUseCase>(),
      ));
  gh.factory<_i27.GetMessagesWithUserUseCase>(
      () => _i27.GetMessagesWithUserUseCase(
            get<_i14.DirectMessageRepository>(),
            get<_i17.GetProfileUseCase>(),
          ));
  gh.factory<_i28.GetOwnedChannelsUseCase>(() => _i28.GetOwnedChannelsUseCase(
        get<_i11.ChannelRepository>(),
        get<_i17.GetProfileUseCase>(),
      ));
  gh.factory<_i29.GetChannelsToJoinUseCase>(() => _i29.GetChannelsToJoinUseCase(
        get<_i16.GetAllChannelsUseCase>(),
        get<_i26.GetJoinedChannelsUseCase>(),
        get<_i28.GetOwnedChannelsUseCase>(),
      ));
  return get;
}

class _$FirebaseInjectableModule extends _i30.FirebaseInjectableModule {}
