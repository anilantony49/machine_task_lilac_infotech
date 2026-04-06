import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final bool isProfile; // 👈 NEW

  const BottomNavItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isActive,
    this.isProfile = false, // default normal icon
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child:
              isProfile
                  ? ClipOval(child: Image.asset(iconPath, fit: BoxFit.cover))
                  : Image.asset(iconPath, fit: BoxFit.contain),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.0,
            color: Colors.white,
            shadows:
                isActive
                    ? const [
                      Shadow(
                        color: Color(0xFF8C070A),
                        offset: Offset(0, 11),
                        blurRadius: 15,
                      ),
                    ]
                    : null,
          ),
        ),
      ],
    );
  }
}

class UpcomingCard extends StatelessWidget {
  final String poster;
  const UpcomingCard({super.key, required this.poster});

  @override
  Widget build(BuildContext context) {
    final bool hasValidPoster = poster.isNotEmpty && poster != "N/A";

    return Container(
      width: 126,
      height: 187,
      decoration: BoxDecoration(
        color: const Color(0xFF414141),
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          hasValidPoster
              ? ClipRRect(
                borderRadius: BorderRadius.circular(12), // ✅ Clip everything
                child: Stack(
                  children: [
                    // Poster
                    Positioned.fill(
                      child: Image.network(
                        poster,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _placeholder();
                        },
                      ),
                    ),

                    // Gradient
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 102,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black],
                          ),
                        ),
                      ),
                    ),

                    // Book Now Text
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          "Book Now",
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : _placeholder(),
    );
  }
}

Widget _placeholder() {
  return Container(
    width: 169,
    height: 94.9253,
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: const Color(0xFF94061C), width: 0.5),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFF7D0015),
          offset: Offset(0, 6),
          blurRadius: 17.2,
        ),
      ],
    ),
  );
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 0,
        color: const Color(0xFFD9D9D9),
      ),
    );
  }
}

class TrendingMovieCard extends StatelessWidget {
  final String poster;
  final String title;
  const TrendingMovieCard({
    super.key,
    required this.poster,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasValidPoster = poster.isNotEmpty && poster != "N/A";

    return Container(
      width: 169,
      height: 95,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFF94061C), width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF7D0015),
            offset: Offset(0, 6),
            blurRadius: 6.2,
          ),
        ],
      ),
      child:
          hasValidPoster
              ? Stack(
                children: [
                  // Poster
                  Positioned.fill(
                    child: Image.network(
                      poster,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _placeholder();
                      },
                    ),
                  ),

                  // Gradient Overlay
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black],
                        ),
                      ),
                    ),
                  ),

                  // Book Now Text
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        title,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 169,
      height: 94.9253,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFF94061C), width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF7D0015),
            offset: Offset(0, 6),
            blurRadius: 6.2,
          ),
        ],
      ),
    );
  }
}

class GenrePill extends StatelessWidget {
  final String text;

  const GenrePill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 24, // keep height fixed
        minWidth: 0, // allow shrink
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0x1FFFFFFF),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: const Color(0x1AFFFFFF), width: 1),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SidePoster extends StatelessWidget {
  final String imagePath;

  const SidePoster({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 173,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13.92),
        child: Image.asset(
          imagePath,
          fit: BoxFit.fill, // better than contain
        ),
      ),
    );
  }
}

// class TrendingMovieLoadingCard extends StatelessWidget {
//   const TrendingMovieLoadingCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 169,
//       height: 95,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(13),
//         border: Border.all(color: const Color(0xFF94061C), width: 0.5),
//       ),
//       child: const Center(
//         child: SizedBox(
//           width: 20,
//           height: 20,
//           child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
