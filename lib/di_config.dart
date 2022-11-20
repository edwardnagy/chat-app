import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/di_config.config.dart';

final locator = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(locator);
