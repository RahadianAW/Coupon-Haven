import '../models/movie.dart';

class MovieCache {
  MovieCache._privateConstructor();
  static final MovieCache _instance = MovieCache._privateConstructor();
  static MovieCache get instance => _instance;
  List<Movie>? _cachedMovies;
  List<Movie>? get cachedMovies => _cachedMovies;
  void setMovies(List<Movie> movies) {
    _cachedMovies = movies;
  }
}
