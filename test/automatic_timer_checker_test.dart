import 'package:flutter_test/flutter_test.dart';
import 'package:automatic_timer_checker/automatic_timer_checker.dart';
import 'package:automatic_timer_checker/automatic_timer_checker_platform_interface.dart';
import 'package:automatic_timer_checker/automatic_timer_checker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAutomaticTimerCheckerPlatform
    with MockPlatformInterfaceMixin
    implements AutomaticTimerCheckerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AutomaticTimerCheckerPlatform initialPlatform = AutomaticTimerCheckerPlatform.instance;

  test('$MethodChannelAutomaticTimerChecker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAutomaticTimerChecker>());
  });

  test('getPlatformVersion', () async {
    AutomaticTimerChecker automaticTimerCheckerPlugin = AutomaticTimerChecker();
    MockAutomaticTimerCheckerPlatform fakePlatform = MockAutomaticTimerCheckerPlatform();
    AutomaticTimerCheckerPlatform.instance = fakePlatform;

    expect(await automaticTimerCheckerPlugin.getPlatformVersion(), '42');
  });
}
