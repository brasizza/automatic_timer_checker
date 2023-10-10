import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'automatic_timer_checker_platform_interface.dart';

/// An implementation of [AutomaticTimerCheckerPlatform] that uses method channels.
class MethodChannelAutomaticTimerChecker extends AutomaticTimerCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('automatic_timer_checker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> isAutomaticTimeEnabled() async {
    final isEnabled = await methodChannel.invokeMethod<bool?>('isAutomaticTimeEnabled');
    return isEnabled;
  }
}
