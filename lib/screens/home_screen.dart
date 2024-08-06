import 'package:flashlight/services/platform/flashlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOn = false;

  void _toggleFlashLight() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isOn = await Flashlight.toggleFlashLight();
    await prefs.setBool('status', isOn);
  }

  @override
  void initState() {
    super.initState();
    _loadFlashlightStatus();
  }

  void _loadFlashlightStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isOn = prefs.getBool('status') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/off.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              if (isOn)
                Positioned(
                  left: -18.h,
                  child: Image.asset(
                    "assets/images/light.png",
                    width: 396.w,
                  ),
                ),
              Positioned(
                top: 440.h,
                left: 168.w,
                child: Text(
                  "OFF",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Anton',
                    color: const Color(0xFF979797).withOpacity(0.5),
                  ),
                ),
              ),
              Positioned(
                top: 490.h,
                left: 170.w,
                child: Text(
                  "ON",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Anton',
                    color: const Color(0xFFFFB10B),
                    shadows: [
                      Shadow(
                        blurRadius: 9.r,
                        color: const Color(0xFFFFB10B).withOpacity(0.3),
                      )
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                top: isOn ? 422.h : 475.h,
                left: 155.w,
                child: GestureDetector(
                  onTap: () {
                    _toggleFlashLight();
                    setState(() {
                      isOn = !isOn;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 50.w,
                    height: 50.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/button.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: isOn
                              ? const Color(0xFFFFBF00)
                              : Colors.transparent,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
