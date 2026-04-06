import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_task_lilac_infotech/presentation/widgets/booking_screen_widget.dart';

class MovieBookingScreen extends StatelessWidget {
  final String date;
  final String title;

  final String time;
  const MovieBookingScreen({
    super.key,
    required this.date,
    required this.time,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 69,
            left: 16,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 18,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 103,
            left: 148,
            child: Image.asset('assets/images/tic_image.png'),
          ),
          Positioned(
            top: 233,
            left: 0,
            right: 0,
            child: Center(child: BookingHeader(title: title)),
          ),

          Stack(
            children: [
              Positioned(
                top: 318,
                left: 71,
                child: Container(
                  width: 260,
                  height: 478,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(-1, 13),
                        blurRadius: 17,
                        color: Color(0x26000000),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Background image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          // alignment: Alignment(3, 6),
                          'assets/images/Image.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),

                      // Second container INSIDE
                      Positioned(
                        top: 341,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 137,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(251, 227, 203, 222),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      infoText("Date", "April $date"),
                                      infoText("Time", time),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InfoStatic(label: "Row", value: "2"),
                                      InfoStatic(
                                        label: "Seats",
                                        value: "9, 10",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/images/bar_code.png',
                                // height: 40,
                                // width: 700,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 34,
                        top: 20.05,
                        child: SizedBox(
                          // height: 47,
                          width: 191.2,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Doctor Strange\n",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    height: 1.0,
                                    color: Colors.white,
                                    letterSpacing: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: "in the Multiverse of Madness",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.0,
                                    color: Colors.white,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ],
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
        ],
      ),
    );
  }
}
