package com.example.iot_health_app

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.iot_health_app/wifi"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        Log.d("MainActivity", "MethodChannel setup initialized")

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            Log.d(
                "MainActivity",
                "MethodChannel received call: ${call.method}, SSID: ${call.argument<String>("ssid")}"
            )

            if (call.method == "connectToWifi") {
                // Safely get the arguments with a null check
                val ssid = call.argument<String>("ssid") ?: run {
                    result.error("INVALID_ARGUMENT", "SSID is required", null)
                    return@setMethodCallHandler
                }
                val password = call.argument<String>("password") ?: ""
                val devices = call.argument<List<Map<String, String>>>("devices") ?: emptyList()

                // Log the received data for debugging
                Log.d(
                    "MainActivity",
                    "Received SSID: $ssid, Password: $password, Devices: $devices"
                )

                val validationResult = connectToWifi(ssid, password, devices)

                // Log the validation result
                Log.d("MainActivity", "Validation Result: $validationResult")

                // Send response to Dart
                result.success(validationResult)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun connectToWifi(ssid: String,
                              password: String,
                              devices: List<Map<String, String>>): Any {
        Log.d("MainActivity", "Inside connectToWifi method")
        // Your logic to connect to Wi-Fi
        return true  // Return some result based on connection status
    }
}
