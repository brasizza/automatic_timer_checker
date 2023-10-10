import Flutter
import UIKit

public class AutomaticTimerCheckerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "automatic_timer_checker", binaryMessenger: registrar.messenger())
    let instance = AutomaticTimerCheckerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "isAutomaticTimeEnabled" {
            let isAutomaticTimeEnabled = checkAutomaticTimeEnabled()
            result(isAutomaticTimeEnabled)
        } 
        
        if(call.method == "getPlatformVersion"){
      result("iOS " + UIDevice.current.systemVersion)
            
        }
        else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func checkAutomaticTimeEnabled() -> Bool {
        let systemTimeZone = TimeZone.autoupdatingCurrent
        let defaultTimeZone = TimeZone.current
        return systemTimeZone == defaultTimeZone
    }
}
