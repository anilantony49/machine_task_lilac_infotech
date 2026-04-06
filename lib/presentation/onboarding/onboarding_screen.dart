import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_task_lilac_infotech/presentation/widgets/round_button_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Transform.scale(
              scale: 1.13,
              alignment: const Alignment(-0.1, 0.2),
              child: Image.asset(
                "assets/images/onboarding_image.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Bottom Gradient Overlay
          Positioned(
            top: 222,
            left: 0,
            right: 0,
            child: Container(
              height: 690,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.0, 0.3551, 1.0],
                  colors: [
                    Color(0xFF26539E),
                    Color(0xFF26539E),
                    Color(0x0026539E),
                  ],
                ),
              ),
            ),
          ),

          /// Heading Text
          Positioned(
            top: 615,
            left: 24,
            right: 24,
            child: Text(
              "Because\nMovies Deserve\nMore Than Queues",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 33.86,
                fontWeight: FontWeight.w700,
                height: 1.33,
                color: Colors.white,
              ),
            ),
          ),

          /// NEXT Button
          PrimaryRoundedButton(
            title: "NEXT",
            onTap: () {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
