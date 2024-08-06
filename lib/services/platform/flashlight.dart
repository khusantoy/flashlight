import 'package:flutter/services.dart';

class Flashlight {
  static const platform = MethodChannel('uz.xusanboy.platform/flashlight');
  static Future<bool> toggleFlashLight() async {
    try {
      final bool result = await platform.invokeMethod('toggleFlashLight');
      return result;
    } on PlatformException catch (e) {
      print("Failed to toggle flashlight: '${e.message}'.");
    }
    return false;
  }
}
