import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_task_lilac_infotech/core/network/api_service.dart';
import 'package:machine_task_lilac_infotech/data/models/movie_details_models.dart';
import 'package:machine_task_lilac_infotech/presentation/booking_screen/movie_booking_screen.dart';
import 'package:machine_task_lilac_infotech/presentation/widgets/details_screen_widget.dart';

class DetailsScreen extends StatefulWidget {
  final String imdbID;
  const DetailsScreen({super.key, required this.imdbID});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ApiService _apiService = ApiService();
  late Future<MovieDetailsModels> _movieDetails;
  int selectedIndex = 0;

  final List<Map<String, String>> dates = [
    {"day": "12", "week": "Fri"},
    {"day": "13", "week": "Sat"},
    {"day": "14", "week": "Sun"},
    {"day": "15", "week": "Mon"},
    {"day": "16", "week": "Thu"},
    {"day": "17", "week": "Thu"},
    {"day": "18", "week": "Fri"},
  ];

  int selectedTimeIndex = -1;

  final List<String> timeSlots = [
    "09:40 AM",
    "11:20 AM",
    "02:30 PM",
    "05:45 PM",
  ];
  String? movieTitle;
  @override
  void initState() {
    super.initState();
    _movieDetails = _apiService.fetchMovieDetails(widget.imdbID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          // height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // 180deg
              end: Alignment.bottomCenter,
              colors: [Color(0xFF02021B), Color(0xFF590001)],
            ),
          ),
          child: Stack(
            children: [
              SizedBox(
                height: 243,
                width: double.infinity,
                child: FutureBuilder<MovieDetailsModels>(
                  future: _movieDetails,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Failed to load",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }

                    return Image.network(
                      snapshot.data!.poster,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => Container(
                            color: Colors.black,
                            child: Center(
                              child: Text(
                                'Image is not available at the moment',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                    );
                  },
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    top: 199,
                    left: 139,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(27),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7.8, sigmaY: 7.8),
                        child: Container(
                          width: 124,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0x54000000), // #00000054
                            borderRadius: BorderRadius.circular(27),
                            border: Border.all(
                              color: const Color(0x70FFFFFF), // #FFFFFF70
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.play_arrow,
                                  size: 12, // close to 8x9 visual size
                                  color: Colors.white,
                                ),
                                Center(
                                  child: Text(
                                    "Watch Trailer",
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: .5,
                                      color: Colors.white,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Genre
              Positioned(
                top: 259,
                left: 16,

                child: Row(
                  children: [
                    GenreChip(
                      future: _movieDetails,
                      iconPath: 'assets/images/boom.png',
                      isFirst: true,
                    ),
                    const SizedBox(width: 10),
                    GenreChip(
                      future: _movieDetails,
                      iconPath: 'assets/images/star.png',
                      isFirst: false,
                    ),
                  ],
                ),
              ),

              //title
              Positioned(
                top: 307,
                left: 16,
                right: 16, // better than fixed width
                child: FutureBuilder<MovieDetailsModels>(
                  future: _movieDetails,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 24,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Text(
                        "Failed to load",
                        style: TextStyle(color: Colors.white),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }

                    //  store title
                    movieTitle = snapshot.data!.title;

                    return Text(
                      movieTitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                        letterSpacing: 0,
                        color: const Color(0xFFD9D9D9),
                      ),
                    );
                  },
                ),
              ),

              // Language and runtime
              Positioned(
                top: 348,
                left: 16,
                child: Row(
                  children: [
                    InfoChip(
                      future: _movieDetails,
                      valueExtractor: (data) => data.rated,
                    ),
                    const SizedBox(width: 10),
                    InfoChip(
                      future: _movieDetails,
                      valueExtractor: (data) => data.language,
                    ),
                    const SizedBox(width: 10),
                    InfoChip(
                      future: _movieDetails,
                      valueExtractor: (data) => data.runtime,
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 394,
                left: 16,
                child: SizedBox(
                  width: 344,
                  height: 106,
                  child: FutureBuilder<MovieDetailsModels>(
                    future: _movieDetails,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            "Failed to load",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const SizedBox();
                      }

                      return Text(
                        snapshot.data!.plot,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 24 / 16, // ✅ correct
                          letterSpacing: 0,
                          color: const Color(0xB2FFFFFF),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    top: 532,
                    left: 16,
                    child: Container(
                      width: 391,
                      height: 61,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight, // 270deg
                          end: Alignment.centerLeft,
                          colors: [
                            Color(0x08120003), // rgba(18,0,3,0.03)
                            Color(0xFF120003), // #120003
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 12.5,
                            left: 16,
                            child: RotatedBox(
                              quarterTurns: 3, // 270 degrees
                              child: Text(
                                "Cast",
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 24 / 16, // correct line height
                                  letterSpacing: 0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Positioned(
                top: 546,
                left: 79,
                child: SizedBox(
                  height: 20,
                  width: 140,
                  child: FutureBuilder<MovieDetailsModels>(
                    future: _movieDetails,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 2,
                          width: 2,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Text(
                          "Failed to load",
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const SizedBox();
                      }

                      final firstActor =
                          snapshot.data!.actors.split(",").first.trim();

                      return Text(
                        firstActor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: .6,
                          letterSpacing: 0,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 572,
                left: 79,
                child: SizedBox(
                  width: 116,
                  height: 8,
                  child: Text(
                    "Tony Stark/Iron Man",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: .4, // 2.0
                      color: const Color(0xA6FFFFFF),
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 546,
                left: 236,
                child: SizedBox(
                  height: 20,
                  width: 140,
                  child: FutureBuilder<MovieDetailsModels>(
                    future: _movieDetails,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 2,
                          width: 2,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Text(
                          "Failed to load",
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const SizedBox();
                      }

                      final secondActor =
                          snapshot.data!.actors.split(",").length > 1
                              ? snapshot.data!.actors.split(",")[1].trim()
                              : "";

                      return Text(
                        secondActor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: .6,
                          letterSpacing: 0,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 572,
                left: 236,
                child: SizedBox(
                  width: 183,
                  height: 8,
                  child: Text.rich(
                    TextSpan(
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: .4, // important
                        color: const Color(0xA6FFFFFF),
                        letterSpacing: 0,
                      ),
                      children: const [
                        TextSpan(text: "Natasha Romanoff/"),
                        TextSpan(
                          text: "Black Widow",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xA6FFFFFF),
                            decorationThickness: 1.2, // make visible
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              Positioned(
                top: 544,
                left: 220,
                child: Container(
                  width: 1,
                  height: 38,
                  color: const Color(0x33FFFFFF),
                ),
              ),

              Positioned(
                top: 625,
                left: 0,
                right: 0,
                child: Container(
                  height: 290,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A0004),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        left: 185,
                        child: Container(
                          width: 39,
                          height: 2,
                          decoration: BoxDecoration(
                            color: const Color(0x80FFFFFF), // #FFFFFF80
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 46,
                        left: 30,
                        right: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(dates.length * 2 - 1, (
                            index,
                          ) {
                            if (index.isEven) {
                              final item = dates[index ~/ 2];

                              return DateItem(
                                day: item["day"]!,
                                weekDay: item["week"]!,
                                isSelected: selectedIndex == index ~/ 2,
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index ~/ 2;
                                  });
                                },
                              );
                            } else {
                              return const DateDivider();
                            }
                          }),
                        ),
                      ),

                      Positioned(
                        top: 115,
                        left: 24,
                        right: 24,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(timeSlots.length, (index) {
                            return TimeSlotWidget(
                              time: timeSlots[index],
                              isSelected: selectedTimeIndex == index,
                              onTap: () {
                                setState(() {
                                  selectedTimeIndex = index;
                                });
                              },
                            );
                          }),
                        ),
                      ),

                      Positioned(
                        top: 160,
                        left: 16,
                        right: 16,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(80),
                            onTap: () {
                              if (selectedIndex == -1 ||
                                  selectedTimeIndex == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please select date and time",
                                    ),
                                  ),
                                );
                                return;
                              }

                              final selectedDate = dates[selectedIndex];
                              final selectedTime = timeSlots[selectedTimeIndex];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => MovieBookingScreen(
                                        date: selectedDate["day"]!,
                                        time: selectedTime,
                                        title: movieTitle!,
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              width: 370,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF60000),
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: Center(
                                child: Text(
                                  "Book Now",
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 24 / 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
