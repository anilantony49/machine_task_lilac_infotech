import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  late Animation<Offset> _slideAnimation;

  // @override
  // void initState() {
  //   super.initState();

  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 2),
  //   );

  //   _fadeAnimation = Tween<double>(
  //     begin: 0,
  //     end: 1,
  //   ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  //   _scaleAnimation = Tween<double>(
  //     begin: 1.1,
  //     end: 1.14,
  //   ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  //   _slideAnimation = Tween<Offset>(
  //     begin: const Offset(0, 0.3),
  //     end: Offset.zero,
  //   ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  //   _controller.forward();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            /// Background Image with Zoom Animation
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    alignment: const Alignment(-0.1, 0.6),
                    child: Image.asset(
                      "assets/images/splash_image.jpg",
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),

            /// Bottom Gradient Frame
            Positioned(
              top: 281,
              left: 0,
              right: 0,
              child: Container(
                height: 633,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.0, 0.4327, 1.0],
                    colors: [
                      Color(0xFF9C9F8E),
                      Color(0xE89C9F8E),
                      Color(0x009C9F8E),
                    ],
                  ),
                ),
              ),
            ),

            /// Animated Text (Slide Up)
            Positioned(
              top: 615,
              left: 24,
              right: 24,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  "Catch Every\nBlockbuster Without\nthe Queue",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 33.86,
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                    color: const Color(0xFF2F302E),
                  ),
                ),
              ),
            ),

            /// NEXT Button
            // PrimaryRoundedButton(
            //   title: "NEXT",
            //   onTap: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (_) => const OnboardingScreen()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
