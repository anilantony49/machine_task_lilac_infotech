import 'package:dio/dio.dart';
import 'package:machine_task_lilac_infotech/core/config/env_config.dart';
import 'package:machine_task_lilac_infotech/core/network/api_constants.dart';
import 'package:machine_task_lilac_infotech/data/models/movie_models.dart';
 
class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,

      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),

      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<List<MovieModels>> fetchMovie(int page) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}/?apikey=${EnvConfig.apiKey}&s=avengers&page=$page",
        // queryParameters: {
        //   "apikey": EnvConfig.apiKey,
        //   "s": "avengers",
        //   "page": 1,
        // },
      );

      if (response.statusCode == 200) {
        final List<dynamic> movies = response.data['Search'] ?? [];

        return movies.map((movie) => MovieModels.fromJson(movie)).toList();
      } else {
        throw Exception("Failed to load movies");
      }
    } on DioException catch (e) {
      throw Exception('Failed to load data: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Future<MovieDetailsModels> fetchMovieDetails(String imdbID) async {
  //   try {
  //     final response = await _dio.get(
  //       "${ApiConstants.baseUrl}/?apikey=${EnvConfig.apiKey}&i=$imdbID&plot=full",
  //     );

  //     if (response.statusCode == 200) {
  //       return MovieDetailsModels.fromJson(response.data);
  //     } else {
  //       throw Exception("Failed to load movie details");
  //     }
  //   } on DioException catch (e) {
  //     throw Exception('Failed to load data: ${e.message}');
  //   } catch (e) {
  //     throw Exception('An unexpected error occurred: $e');
  //   }
  // }
}
