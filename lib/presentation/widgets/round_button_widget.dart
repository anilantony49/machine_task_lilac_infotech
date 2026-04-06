 
import 'package:flutter/material.dart';

class PrimaryRoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const PrimaryRoundedButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 15,
      right: 15,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(80),
          onTap: onTap,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(80),
              border: Border.all(
                color: const Color(0x66FFFFFF),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}