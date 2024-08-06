package com.example.flashlight

import android.content.Context
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager

class FlashLightController(private val context: Context) {
    private var flashLightStatus: Boolean = false

    fun toggleFlashLight(): Boolean {
        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        val cameraId = cameraManager.cameraIdList[0]
        return try {
            flashLightStatus = !flashLightStatus
            cameraManager.setTorchMode(cameraId, flashLightStatus)
            flashLightStatus
        } catch (e: CameraAccessException) {
            e.printStackTrace()
            false
        }
    }
}
