// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/remote/firebase_injectable_module.dart' as _i25;
import 'core/repository/auth_repository.dart' as _i7;
import 'core/repository/channel_repository.dart' as _i8;
import 'core/repository/direct_message_repository.dart' as _i11;
import 'core/repository/profile_repository.dart' as _i5;
import 'core/repository/user_repository.dart' as _i6;
import 'core/use_case/channel/create_channel_use_case.dart' as _i18;
import 'core/use_case/channel/delete_channel_use_case.dart' as _i10;
import 'core/use_case/channel/get_all_channels_use_case.dart' as _i12;
import 'core/use_case/channel/get_channel_thread_use_case.dart' as _i19;
import 'core/use_case/channel/get_channels_to_join_use_case.dart' as _i24;
import 'core/use_case/channel/get_joined_channels_use_case.dart' as _i21;
import 'core/use_case/channel/get_owned_channels_use_case.dart' as _i23;
import 'core/use_case/channel/join_channel_use_case.dart' as _i14;
import 'core/use_case/channel/quit_channel_use_case.dart' as _i15;
import 'core/use_case/channel/send_message_to_channel_use_case.dart' as _i16;
import 'core/use_case/direct_messages/get_friends_use_case.dart' as _i20;
import 'core/use_case/direct_messages/get_messages_with_user_use_case.dart'
    as _i22;
import 'core/use_case/direct_messages/send_message_to_user_use_case.dart'
    as _i17;
import 'core/use_case/profile/create_profile_use_case.dart' as _i9;
import 'core/use_case/profile/get_profile_use_case.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i8.ChannelRepository>(
      () => _i8.ChannelRepository(get<_i4.FirebaseFirestore>()));
  gh.factory<_i9.CreateProfileUseCase>(() => _i9.CreateProfileUseCase(
        get<_i5.ProfileRepository>(),
        get<_i6.UserRepository>(),
        get<_i7.AuthRepository>(),
      ));
  gh.factory<_i10.DeleteChannelUseCase>(
      () => _i10.DeleteChannelUseCase(get<_i8.ChannelRepository>()));
  gh.factory<_i11.DirectMessageRepository>(
      () => _i11.DirectMessageRepository(get<_i4.FirebaseFirestore>()));
  gh.factory<_i12.GetAllChannelsUseCase>(
      () => _i12.GetAllChannelsUseCase(get<_i8.ChannelRepository>()));
  gh.factory<_i13.GetProfileUseCase>(() => _i13.GetProfileUseCase(
        get<_i5.ProfileRepository>(),
        get<_i7.AuthRepository>(),
        get<_i6.UserRepository>(),
      ));
  gh.factory<_i14.JoinChannelUseCase>(() => _i14.JoinChannelUseCase(
        get<_i8.ChannelRepository>(),
        get<_i13.GetProfileUseCase>(),
      ));
  gh.factory<_i15.QuitChannelUseCase>(() => _i15.QuitChannelUseCase(
        get<_i8.ChannelRepository>(),
        get<_i13.GetProfileUseCase>(),
      ));
  gh.factory<_i16.SendMessageToChannelUseCase>(
      () => _i16.SendMessageToChannelUseCase(
            get<_i8.ChannelRepository>(),
            get<_i13.GetProfileUseCase>(),
          ));
  gh.factory<_i17.SendMessageToUserUseCase>(() => _i17.SendMessageToUserUseCase(
        get<_i11.DirectMessageRepository>(),
        get<_i13.GetProfileUseCase>(),
      ));
  gh.factory<_i18.CreateChannelUseCase>(() => _i18.CreateChannelUseCase(
        get<_i8.ChannelRepository>(),
        get<_i13.GetProfileUseCase>(),
      ));
  gh.factory<_i19.GetChannelThreadUseCase>(() => _i19.GetChannelThreadUseCase(
        get<_i8.ChannelRepository>(),
        get<_i13.GetProfileUseCase>(),
      ));
  gh.factory<_i20.GetFriendsUseCase>(() => _i20.GetFriendsUseCase(
        get<_i11.DirectMessageRepository>(),
        get<_i13.GetProfileUseCase>(),
      ));
  gh.factory<_i21.GetJoinedChannelsUseCase>(() => _i21.GetJoinedChannelsUseCase(
        get<_i8.ChannelRepository>(),
        get<_i13.GetProfileUseCase>(),
      ));
  gh.factory<_i22.GetMessagesWithUserUseCase>(
      () => _i22.GetMessagesWithUserUseCase(
            get<_i11.DirectMessageRepository>(),
            get<_i13.GetProfileUseCase>(),
          ));
  gh.factory<_i23.GetOwnedChannelsUseCase>(() => _i23.GetOwnedChannelsUseCase(
        get<_i8.ChannelRepository>(),
        get<_i13.GetProfileUseCase>(),
      ));
  gh.factory<_i24.GetChannelsToJoinUseCase>(() => _i24.GetChannelsToJoinUseCase(
        get<_i12.GetAllChannelsUseCase>(),
        get<_i21.GetJoinedChannelsUseCase>(),
        get<_i23.GetOwnedChannelsUseCase>(),
      ));
  return get;
}

class _$FirebaseInjectableModule extends _i25.FirebaseInjectableModule {}
