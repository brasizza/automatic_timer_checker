import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:automatic_timer_checker/automatic_timer_checker_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelAutomaticTimerChecker platform = MethodChannelAutomaticTimerChecker();
  const MethodChannel channel = MethodChannel('automatic_timer_checker');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
