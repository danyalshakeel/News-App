import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new10/Screens/landing_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Fade Animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Scale Animation for logo scaling effect
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    // Navigate to Main Screen after 3 seconds
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LandingPage()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.blue[300]!, Colors.pinkAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.article,
                    color: Colors.white,
                    size: 100.0,
                  ),
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "News",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "10",
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.redAccent[700],
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
