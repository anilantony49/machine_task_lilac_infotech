import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingHeader extends StatelessWidget {
  final String title;

  const BookingHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Booking Successful",
          style: GoogleFonts.dmSans(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1,
            color: Colors.black,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "For '$title'",
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1,
            color: const Color(0xFF4A4F62),
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}

Widget infoText(String label, String value) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(fontSize: 14),
      children: [
        TextSpan(
          text: "$label: ",
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

class InfoStatic extends StatelessWidget {
  final String label;
  final String value;

  const InfoStatic({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14),
        children: [
          TextSpan(
            text: "$label: ",
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
