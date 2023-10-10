import 'dart:async';

import 'package:automatic_timer_checker/automatic_timer_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool _isAutomaticTimerEnabled = false;
  final _automaticTimerCheckerPlugin = AutomaticTimerChecker();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    bool isAutomaticTimerEnabled;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _automaticTimerCheckerPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      isAutomaticTimerEnabled = await _automaticTimerCheckerPlugin.isAutomaticTimeEnabled() ?? false;
    } on PlatformException {
      isAutomaticTimerEnabled = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _isAutomaticTimerEnabled = isAutomaticTimerEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Automatic timer checker '),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text('Automatic timer enabled: $_isAutomaticTimerEnabled\n'),
            ),
            ElevatedButton(
                onPressed: () async {
                  final enabled = await _automaticTimerCheckerPlugin.isAutomaticTimeEnabled() ?? false;

                  setState(() {
                    _isAutomaticTimerEnabled = enabled;
                  });
                },
                child: Text("Automatic timer is enabled?")),
          ],
        ),
      ),
    );
  }
}
