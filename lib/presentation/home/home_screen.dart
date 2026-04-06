import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_task_lilac_infotech/core/network/api_service.dart';
import 'package:machine_task_lilac_infotech/data/models/movie_models.dart';
import 'package:machine_task_lilac_infotech/presentation/movie_details_screen/details_screen.dart';
import 'package:machine_task_lilac_infotech/presentation/widgets/bottom_navigation_widget.dart';
import 'package:machine_task_lilac_infotech/presentation/widgets/home_screen_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();

  List<MovieModels> movies = [];
  // late Future<List<MovieModels>> _movies;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !isLoading &&
          hasMore) {
        fetchMovies();
      }
    });
  }

  Future<void> fetchMovies() async {
    setState(() => isLoading = true);

    final newMovies = await _apiService.fetchMovie(currentPage);

    if (newMovies.isEmpty) {
      hasMore = false;
    } else {
      currentPage++;
      movies.addAll(newMovies);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // width: double.infinity,
          height: 1118,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // 180deg
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF02021B), // #02021B
                Color(0xFF590001), // #590001
              ],
            ),
          ),
          child: Stack(
            children: [
              // Background Image
              Positioned(
                top: -5,
                left: -83,

                child: SizedBox(
                  width: 568,
                  height: 582,
                  child: Image.asset(
                    "assets/images/home_screen_bg_image.png", // rename properly
                    fit: BoxFit.cover,
                    // alignment: Alignment.center,
                    alignment: Alignment(1, -1.01),
                  ),
                ),
              ),

              // Search
              Positioned(
                top: 70,
                left: 24,
                right: 24,
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0x17FFFFFF),
                    borderRadius: BorderRadius.circular(62),
                    border: Border.all(
                      color: const Color(0xA3FFFFFF),
                      width: 0.5,
                    ),
                  ),
                  child: TextField(
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFF2F2F2),
                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      border: InputBorder.none,
                      hintText: "Search Movie",
                      hintStyle: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFFF2F2F2),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 20,
                        color: Color(0xFFF2F2F2),
                      ),
                    ),
                  ),
                ),
              ),

              /// Gradient Container Below Search
              Positioned(
                top: 144,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 433,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter, // 180deg
                      end: Alignment.bottomCenter,
                      stops: [
                        0.0,
                        0.9038, // 90.38%
                      ],
                      colors: [
                        Color(0x0002021B), // transparent
                        Color(0xFF31010D), // #31010D
                      ],
                    ),
                  ),
                ),
              ),
              // Play arrow button
              Positioned(
                top: 198,
                left: 180,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(71, 255, 255, 255),
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(
                      color: const Color(0x75FFFFFF),
                      width: 0.58,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              /// Rounded Glass Small Container
              /// Small Pill Container (63x24)
              Positioned(
                top: 321,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    GenrePill(text: "Drama"),
                    SizedBox(width: 8),
                    GenrePill(text: "12+"),
                    SizedBox(width: 8),
                    GenrePill(text: "Drama"),
                  ],
                ),
              ),

              /// Movie Card Container
              Positioned(
                top: 412,
                left: -9,
                child: SidePoster(
                  imagePath: "assets/images/movie_poster_1.png",
                ),
              ),

              /// Large Movie Card With Shadow
              Positioned(
                top: 377,
                left: 135.03,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.38),

                  child: Stack(
                    children: [
                      /// Poster Image
                      Image.asset(
                        "assets/images/movie_poster_2.png",
                        width: 133,
                        height: 192,
                        fit: BoxFit.cover,
                        alignment: const Alignment(-0.3, -1),
                      ),

                      /// Gradient Overlay (133x102 at top: 90)
                      Positioned(
                        top: 90,
                        left: -0.03,
                        child: Container(
                          width: 133,
                          height: 102,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter, // 180deg
                              end: Alignment.bottomCenter,
                              colors: [Color(0x00000000), Color(0xFF000000)],
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 66,
                                left: 12,
                                child: Container(
                                  width: 109,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: const Color(0x91000000), // #00000091
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: const Color(
                                        0x30FFFFFF,
                                      ), // #FFFFFF30
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 7,
                                        left: 22,
                                        child: Text(
                                          "Book Now",
                                          style: GoogleFonts.spaceGrotesk(
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeight.w400, // Regular
                                            height:
                                                10 /
                                                14, // 1.714 exact line height
                                            letterSpacing: 0,
                                            color: const Color(0xFFFFFFFF),
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
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 412,
                left: 292,

                child: SidePoster(
                  imagePath: "assets/images/movie_poster_3.png",
                ),
              ),
              Positioned(
                top: 377, // same top reference
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 220,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      /// Left Poster
                      Positioned(
                        top: 35, // slightly lower than center poster
                        left: -3,
                        child: SidePoster(
                          imagePath: "assets/images/movie_poster_1.png",
                        ),
                      ),

                      /// Center Poster
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14.38),
                        child: Stack(
                          children: [
                            Image.asset(
                              "assets/images/movie_poster_2.png",
                              width: 133,
                              height: 192,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 90,
                              left: -0.03,
                              child: Container(
                                width: 133,
                                height: 102,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter, // 180deg
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0x00000000),
                                      Color(0xFF000000),
                                    ],
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 66,
                                      left: 12,
                                      child: Container(
                                        width: 109,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0x91000000,
                                          ), // #00000091
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          border: Border.all(
                                            color: const Color(
                                              0x30FFFFFF,
                                            ), // #FFFFFF30
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 7,
                                              left: 22,
                                              child: Text(
                                                "Book Now",
                                                style: GoogleFonts.spaceGrotesk(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight
                                                          .w400, // Regular
                                                  height:
                                                      10 /
                                                      14, // 1.714 exact line height
                                                  letterSpacing: 0,
                                                  color: const Color(
                                                    0xFFFFFFFF,
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
                          ],
                        ),
                      ),

                      /// Right Poster
                      Positioned(
                        top: 35, // match left poster
                        right: -4,
                        child: SidePoster(
                          imagePath: "assets/images/movie_poster_3.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Trending Movie Title
              Positioned(
                top: 627,
                left: 16,
                child: const SectionTitle(title: "Trending Movie Near You"),
              ),

              /// Trending Movie Card
              Positioned(
                top: 665,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 95,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (!isLoading &&
                          hasMore &&
                          scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent - 100) {
                        fetchMovies();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 16),
                      itemCount: isLoading ? 2 : movies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child:
                              isLoading
                                  ? const TrendingMovieLoadingCard()
                                  : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => DetailsScreen(
                                                imdbID: movies[index].imdbID,
                                              ),
                                        ),
                                      );
                                    },
                                    child: TrendingMovieCard(
                                      poster: movies[index].poster,
                                      title: movies[index].title,
                                    ),
                                  ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 792,
                left: 16,
                child: const SectionTitle(title: "Upcoming"),
              ),

              /// Movie Poster Card (126x187)
              Positioned(
                top: 830,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 187,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 16),
                    itemCount: movies.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < movies.length) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => DetailsScreen(
                                        imdbID: movies[index].imdbID,
                                      ),
                                ),
                              );
                            },
                            child: UpcomingCard(poster: movies[index].poster),
                          ),
                        );
                      } else {
                        return const SizedBox(
                          width: 80,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
