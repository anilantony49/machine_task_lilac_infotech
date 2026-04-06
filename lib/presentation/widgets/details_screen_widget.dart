import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_task_lilac_infotech/data/models/movie_details_models.dart';

class TimeSlotWidget extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotWidget({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0x1AFFFFFF),
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: isSelected ? Colors.white : const Color(0x33FFFFFF),
            width: 1,
          ),
        ),
        child: Text(
          time,
          textAlign: TextAlign.center,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            height: 24 / 14,
            color: isSelected ? const Color(0xFF1A0004) : Colors.white,
          ),
        ),
      ),
    );
  }
}

class DateItem extends StatelessWidget {
  final String day;
  final String weekDay;
  final bool isSelected;
  final VoidCallback onTap;

  const DateItem({
    super.key,
    required this.day,
    required this.weekDay,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isSelected ? 54 : null,
        height: isSelected ? 52 : null,
        padding:
            isSelected
                ? const EdgeInsets.symmetric(vertical: 5)
                : EdgeInsets.zero,
        decoration:
            isSelected
                ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                )
                : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              day,
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                height: 24 / 20,
                color: isSelected ? const Color(0xFF1A0004) : Colors.white,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              weekDay,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                height: isSelected ? 1 : 24 / 20,
                color:
                    isSelected
                        ? const Color(0xFF1A0004)
                        : const Color(0x80FFFFFF),
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateDivider extends StatelessWidget {
  const DateDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 28, color: const Color(0x1CFFFFFF));
  }
}

class GenreChip extends StatelessWidget {
  final Future<MovieDetailsModels> future;
  final String iconPath;
  final bool isFirst; // true = first genre, false = last genre

  const GenreChip({
    super.key,
    required this.future,
    required this.iconPath,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 110, maxHeight: 28),
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0x1FFFFFFF),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: const Color(0x1AFFFFFF), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconPath, height: 14),
            const SizedBox(width: 6),
            FutureBuilder<MovieDetailsModels>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.hasError) {
                  return const SizedBox();
                }

                final genres = snapshot.data!.genre.split(',');

                final text = isFirst ? genres.first.trim() : genres.last.trim();

                return Text(
                  text,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: .5,
                    color: Colors.white,
                    letterSpacing: 0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InfoChip extends StatelessWidget {
  final Future<MovieDetailsModels> future;
  final String Function(MovieDetailsModels) valueExtractor;

  const InfoChip({
    super.key,
    required this.future,
    required this.valueExtractor,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 150),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0x1AFFFFFF), width: 0.5),
        ),
        child: FutureBuilder<MovieDetailsModels>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              );
            }

            if (!snapshot.hasData || snapshot.hasError) {
              return const SizedBox();
            }

            final value = valueExtractor(snapshot.data!);

            return Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: .6,
                letterSpacing: 0,
                color: const Color(0xB2FFFFFF),
              ),
            );
          },
        ),
      ),
    );
  }
}
