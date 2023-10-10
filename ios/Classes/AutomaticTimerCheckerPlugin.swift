import Flutter
import UIKit
import Foundation

public class AutomaticTimerCheckerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "automatic_timer_checker", binaryMessenger: registrar.messenger())
    let instance = AutomaticTimerCheckerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       
        if (call.method == "isAutomaticTimeEnabled") {
            let isAutomaticTimeEnabled = checkAutomaticTimeEnabled()
            result(isAutomaticTimeEnabled)
        } else if(call.method == "getPlatformVersion"){
          result("iOS " + UIDevice.current.systemVersion)
        }
        else {
            result(FlutterMethodNotImplemented)
        }

    }

    private func checkAutomaticTimeEnabled() -> Bool {

        let timeZone = NSTimeZone.system.description
        let localTimeZone = TimeZone.ReferenceType.local.description
        let currentTimeZone = TimeZone.current.description
        let defaultTimeZone = TimeZone.ReferenceType.default.description
        let autoUpdateTimezon = TimeZone.autoupdatingCurrent.description

        print ("System Timezone \(timeZone)")
        print ("Local Timezone \(localTimeZone)")
        print ("Current Timezone \(currentTimeZone)")
        print ("Default Timezone \(defaultTimeZone)")
        print ("Auto updating Timezone \(autoUpdateTimezon)")
        
        return timeZone == defaultTimeZone
    }
}
