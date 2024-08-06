package com.example.flashlight

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "uz.xusanboy.platform/flashlight"
    private lateinit var flashLightController: FlashLightController

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        flashLightController = FlashLightController(this)

        val binaryMessenger = flutterEngine?.dartExecutor?.binaryMessenger
        if (binaryMessenger != null) {
            MethodChannel(binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
                when (call.method) {
                    "toggleFlashLight" -> {
                        val status = flashLightController.toggleFlashLight()
                        result.success(status)
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }
}
