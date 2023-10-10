package com.brasizza.marcus.automatic_timer_checker

import android.content.Context
import android.provider.Settings
import android.provider.Settings.SettingNotFoundException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** AutomaticTimerCheckerPlugin */
class AutomaticTimerCheckerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var context: Context? = null


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext()
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "automatic_timer_checker")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "isAutomaticTimeEnabled" -> {
                val isAutomaticTimeEnabled = checkAutomaticTimeEnabled()
                result.success(isAutomaticTimeEnabled)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    private fun checkAutomaticTimeEnabled(): Boolean {
        return try {
            val autoTimeSettings: Int =
                Settings.Global.getInt(this.context?.contentResolver, Settings.Global.AUTO_TIME)
            autoTimeSettings == 1
        } catch (e: SettingNotFoundException) {
            e.printStackTrace()
            false
        }
    }
}
