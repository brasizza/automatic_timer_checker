import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'automatic_timer_checker_method_channel.dart';

abstract class AutomaticTimerCheckerPlatform extends PlatformInterface {
  /// Constructs a AutomaticTimerCheckerPlatform.
  AutomaticTimerCheckerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AutomaticTimerCheckerPlatform _instance = MethodChannelAutomaticTimerChecker();

  /// The default instance of [AutomaticTimerCheckerPlatform] to use.
  ///
  /// Defaults to [MethodChannelAutomaticTimerChecker].
  static AutomaticTimerCheckerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AutomaticTimerCheckerPlatform] when
  /// they register themselves.
  static set instance(AutomaticTimerCheckerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> isAutomaticTimeEnabled() {
    throw UnimplementedError('isAutomaticTimeEnabled() has not been implemented.');
  }
}
