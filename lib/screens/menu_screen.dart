import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() {
    return _MovieScreenState();
  }
}

class _MovieScreenState extends State<MovieScreen> {
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final MovieRepository repository = MovieRepository();
    final List<Movie> movies = await repository.loadMoviesFromAsset();
    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        drawer: const NavDrawer(),
        body: ListView.builder(
            itemCount: _movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: _movies[index]);
            }));
  }
}
