import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/splashcontroller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});
  final controller = Get.put(Splashcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Animated Logo
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 2),
                curve: Curves.bounceOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Icon(
                      Icons.receipt_long_outlined,
                      size: MediaQuery.sizeOf(context).width * 0.3,
                      // color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // App Name with Custom Font
              const Text(
                "Tech App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "@Muhammad Talha",
                      style: TextStyle(
                        fontSize: 13,
                        // color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Loading Indicator
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
