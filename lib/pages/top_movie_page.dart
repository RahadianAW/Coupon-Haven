import 'package:flutter/material.dart';
import '../services/marvel_rating_service.dart';
import '../models/movie.dart';
import '../widgets/app_footer.dart';
import 'detail_page.dart';
import 'home_page.dart';

class TopRatedMoviesCache {
  static final TopRatedMoviesCache _instance = TopRatedMoviesCache._internal();
  factory TopRatedMoviesCache() => _instance;

  TopRatedMoviesCache._internal();

  List<Movie>? topRatedMovies;
}

class TopMoviePage extends StatefulWidget {
  const TopMoviePage({super.key});

  @override
  _TopMoviePageState createState() => _TopMoviePageState();
}

class _TopMoviePageState extends State<TopMoviePage> {
  List<Movie>? topRatedMovies;
  int? hoveredIndex;

  @override
  void initState() {
    super.initState();
    fetchTopRatedMovies();
  }

  Future<void> fetchTopRatedMovies() async {
    final cache = TopRatedMoviesCache();
    if (cache.topRatedMovies == null) {
      List<Movie> movies =
          await MarvelRatingService().fetchMarvelMoviesWithRatings();
      cache.topRatedMovies = movies
          .where((movie) => movie.rating != null)
          .toList()
        ..sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
    }
    topRatedMovies = cache.topRatedMovies;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Marvel Movies'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: topRatedMovies == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: topRatedMovies!.length,
                itemBuilder: (context, index) {
                  final movie = topRatedMovies![index];
                  final isHovered = hoveredIndex == index;

                  return MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        hoveredIndex = index;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        hoveredIndex = null;
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(movie: movie),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isHovered ? Colors.grey[850] : Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                movie.coverUrl,
                                height: 80,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rating: ${movie.rating?.toStringAsFixed(1) ?? "N/A"}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: const AppFooter(currentIndex: 1),
    );
  }
}
