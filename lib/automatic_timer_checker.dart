import 'automatic_timer_checker_platform_interface.dart';

class AutomaticTimerChecker {
  Future<String?> getPlatformVersion() {
    return AutomaticTimerCheckerPlatform.instance.getPlatformVersion();
  }

  Future<bool?> isAutomaticTimeEnabled() => AutomaticTimerCheckerPlatform.instance.isAutomaticTimeEnabled();
}
