import 'package:flutter/material.dart';
import 'package:new10/Screens/homepage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Fade animation for the text
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Slide animation for the image
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation
    _controller.forward();
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
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: ListView(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/image/gate.jpg",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.9,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                "News from around the\nworld for you",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                "Best time to read,\n take your time to read a little more of this world",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 30),
            FadeTransition(
              opacity: _fadeAnimation,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return MainScreen();
                  }));
                },
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  elevation: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Center(
                        child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
